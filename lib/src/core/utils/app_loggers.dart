import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

/// Logs a debug message to the console with browser DevTools-like formatting.
///
/// - Maps and Lists are pretty-printed as indented JSON.
/// - Strings containing Dart's toString() map/list format (e.g. from
///   string interpolation of API responses) are auto-parsed and pretty-printed.
/// - Errors/Exceptions show type, message, and stack trace.
void debugLog(dynamic message, {String? tag}) {
  if (!kDebugMode) return;

  final label = tag != null ? '[$tag]' : '[DEBUG]';

  if (message is Map || message is List) {
    log('$label ${_describeType(message)}');
    _logJsonLines(message);
  } else if (message is String) {
    _logString(label, message);
  } else if (message is Exception || message is Error) {
    _logError(label, message);
  } else {
    log('$label $message');
  }
}

// ---------------------------------------------------------------------------
// String handling — detects embedded Maps/Lists and pretty-prints them.
// ---------------------------------------------------------------------------

void _logString(String label, String message) {
  // Look for a structured data portion ({...} or [...]) at the end of the string.
  // Handles patterns like:
  //   "[RESPONSE FROM /path]: {key: value, ...}"
  //   "[BODY] {key: value, ...}"
  //   "[QUERIES]{}"
  final match = RegExp(
    r'^(.*?)(\{.*\}|\[.*\])$',
    dotAll: true,
  ).firstMatch(message);

  if (match != null) {
    var prefix = match.group(1)!.trimRight();
    final dataPart = match.group(2)!;

    // Strip trailing colon from prefix (e.g. "[RESPONSE FROM /path]:")
    if (prefix.endsWith(':')) {
      prefix = prefix.substring(0, prefix.length - 1).trimRight();
    }

    // 1) Try standard JSON decode first.
    try {
      final decoded = jsonDecode(dataPart);
      _logPrettyWithPrefix(label, prefix, decoded);
      return;
    } catch (_) {}

    // 2) Try Dart's Map/List .toString() format (unquoted keys & values).
    final parsed = _tryParseDartStructure(dataPart);
    if (parsed != null) {
      _logPrettyWithPrefix(label, prefix, parsed);
      return;
    }
  }

  // Plain string — log as-is.
  log('$label $message');
}

void _logPrettyWithPrefix(String label, String prefix, dynamic data) {
  if (prefix.isNotEmpty) {
    log('$label $prefix');
  } else {
    log('$label ${_describeType(data)}');
  }
  _logJsonLines(data);
}

void _logJsonLines(dynamic json) {
  try {
    const encoder = JsonEncoder.withIndent('  ');
    final prettyJson = encoder.convert(json);
    for (final line in prettyJson.split('\n')) {
      log(line);
    }
  } catch (_) {
    log('  (unparseable): $json');
  }
}

// ---------------------------------------------------------------------------
// Dart .toString() format parser
// ---------------------------------------------------------------------------
// Parses strings like:
//   {success: true, message: Hello world, data: {nested: value}}
// which is what Dart produces when you do '${someMap}'.

dynamic _tryParseDartStructure(String input) {
  final trimmed = input.trim();
  if (trimmed.startsWith('{') && trimmed.endsWith('}')) {
    return _tryParseDartMap(trimmed);
  }
  if (trimmed.startsWith('[') && trimmed.endsWith(']')) {
    return _tryParseDartList(trimmed);
  }
  return null;
}

Map<String, dynamic>? _tryParseDartMap(String input) {
  try {
    final content = input.substring(1, input.length - 1).trim();
    if (content.isEmpty) return {};

    final entries = _splitMapEntries(content);
    final result = <String, dynamic>{};

    for (final entry in entries) {
      final colonIdx = entry.indexOf(': ');
      if (colonIdx == -1) return null;

      final key = entry.substring(0, colonIdx).trim();
      final value = entry.substring(colonIdx + 2);
      result[key] = _parseDartValue(value);
    }

    return result;
  } catch (_) {
    return null;
  }
}

/// Splits map content into key-value entries.
///
/// A split only occurs at `, ` when the remainder starts with `identifier: `.
/// This prevents splitting inside values that contain commas
/// (e.g. "1b azihen street, Agbor, Lagos, Nigeria").
List<String> _splitMapEntries(String content) {
  final entries = <String>[];
  var depth = 0;
  var start = 0;

  for (var i = 0; i < content.length; i++) {
    final char = content[i];
    if (char == '{' || char == '[') depth++;
    if (char == '}' || char == ']') depth--;

    if (depth == 0 &&
        char == ',' &&
        i + 1 < content.length &&
        content[i + 1] == ' ') {
      // Only split if the next token looks like a map key (word followed by ": ")
      final rest = content.substring(i + 2);
      if (RegExp(r'^\w+: ').hasMatch(rest)) {
        entries.add(content.substring(start, i));
        start = i + 2;
      }
    }
  }

  entries.add(content.substring(start));
  return entries;
}

List<dynamic>? _tryParseDartList(String input) {
  try {
    final content = input.substring(1, input.length - 1).trim();
    if (content.isEmpty) return [];

    final items = <dynamic>[];
    var depth = 0;
    var start = 0;

    for (var i = 0; i < content.length; i++) {
      final char = content[i];
      if (char == '{' || char == '[') depth++;
      if (char == '}' || char == ']') depth--;

      if (depth == 0 &&
          char == ',' &&
          i + 1 < content.length &&
          content[i + 1] == ' ') {
        items.add(_parseDartValue(content.substring(start, i)));
        start = i + 2;
      }
    }
    items.add(_parseDartValue(content.substring(start)));

    return items;
  } catch (_) {
    return null;
  }
}

dynamic _parseDartValue(String value) {
  final v = value.trim();
  if (v == 'null') return null;
  if (v == 'true') return true;
  if (v == 'false') return false;

  if (v.startsWith('{') && v.endsWith('}')) return _tryParseDartMap(v) ?? v;
  if (v.startsWith('[') && v.endsWith(']')) return _tryParseDartList(v) ?? v;

  // Only parse clean numerics (no +/- prefix that could be a phone number).
  if (RegExp(r'^\d+\.?\d*$').hasMatch(v)) return num.tryParse(v) ?? v;

  return v;
}

// ---------------------------------------------------------------------------
// Error logging
// ---------------------------------------------------------------------------

void _logError(String label, dynamic error) {
  if (error is Error) {
    log('$label ❌ ${error.runtimeType}: $error');
    if (error.stackTrace != null) {
      log('StackTrace:\n${error.stackTrace}');
    }
  } else if (error is Exception) {
    log('$label ⚠️ ${error.runtimeType}: $error');
  }
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

String _describeType(dynamic data) {
  if (data is Map) return 'Map (${data.length} keys)';
  if (data is List) return 'List (${data.length} items)';
  return '${data.runtimeType}';
}
