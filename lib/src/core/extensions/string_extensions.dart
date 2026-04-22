// Project imports:
import 'package:fintech_app/src/core/extensions/date_extensions.dart';

extension TimeExtension on String {
  DateTime get toDate => DateTime.parse(this);

  String get capiTalizeFirst {
    return this[0].toUpperCase() + substring(1);
  }

  String get capiTalizeFirstLast {
    return this[0].toUpperCase() + substring(1);
  }

  String get capitalizeFullname {
    if (isEmpty) return this;

    List<String> words = split(" ");
    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] = words[i][0].toUpperCase() + words[i].substring(1);
      }
    }

    return words.join(" ");
  }

  String reArrangeDOB(String pattern, [String newPattern = '-']) {
    return split(pattern).reversed.join(newPattern);
  }

  String removeCommas() {
    if (contains(',')) {
      return replaceAll(',', '');
    } else {
      return this;
    }
  }

  String obscuredMail() {
    var newString = '';
    final List<String> emailList = split("");
    for (var i = 0; i < emailList.length; i++) {
      if (i != 0 && emailList[i] != '@' && i < indexOf('.')) {
        emailList[i] = '*';
        newString = emailList.join();
      }
    }
    return newString;
  }

  String obscurePhoneNumber() {
    if (length >= 10) {
      final List<String> numberList = split("");
      for (var i = 3; i < 7; i++) {
        // Replace digits from index 3 to 6 with '*'
        numberList[i] = '*';
      }
      return numberList.join();
    } else {
      // Handle cases where the phone number is too short
      return this;
    }
  }

  String truncateToMaxLength(int maxLength) {
    if (length <= maxLength) {
      return this;
    }
    return substring(0, maxLength);
  }

  String get toMonthDate {
    return DateTime.parse(this).toMonthDate;
  }

  String get toTime {
    return DateTime.parse(this).toTime;
  }

  String get initials {
    final name = split(' ');

    if (name.length > 1) {
      return '${name[0][0]}${name[1][0]}';
    }
    return name[0][1];
  }

  String get maskedCardNumber {
    // Remove all non-digit characters
    final cleaned = replaceAll(RegExp(r'\D'), '');

    // Mask all but the last 4 digits
    final masked = cleaned.replaceAll(RegExp(r'\d(?=\d{4})'), '*');

    // Add spaces between every four digits
    final spaced = masked.replaceAllMapped(
      RegExp(r".{4}"),
      (match) => "${match.group(0)} ",
    );

    // Trim any trailing space
    return spaced.trim();
  }

  /// Obscures a portion of the string between specified start and end indices
  ///
  /// [startIndex] is the beginning index where obscuration should start (optional)
  /// [endIndex] is the ending index where obscuration should end (optional)
  /// [obscureChar] is the character used to replace the original characters (default is '*')
  ///
  /// Returns the obscured string
  String obscure({int? startIndex, int? endIndex, String obscureChar = '*'}) {
    // If no indices specified, obscure the entire string
    if (startIndex == null && endIndex == null) {
      return obscureChar * length;
    }

    // Default start index to 0 if not specified
    int effectiveStartIndex = startIndex ?? 0;

    // Default end index to the last character if not specified
    int effectiveEndIndex = endIndex ?? (length - 1);

    // Validate input indices
    if (effectiveStartIndex < 0 ||
        effectiveEndIndex >= length ||
        effectiveStartIndex > effectiveEndIndex) {
      throw ArgumentError('Invalid start or end indices');
    }

    // Create the obscured portion
    String obscuredPortion =
        obscureChar * (effectiveEndIndex - effectiveStartIndex + 1);

    // Combine the parts of the string
    return substring(0, effectiveStartIndex) +
        obscuredPortion +
        substring(effectiveEndIndex + 1);
  }

  String _toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';
  String uppercased() => replaceAll(
    RegExp(' +'),
    ' ',
  ).split(' ').map((word) => word._toCapitalized()).join(' ');

  /// Removes all non-numeric characters from the string
  String numbersOnly({bool allowDecimal = false}) {
    if (isEmpty) return '';

    // If decimal points are allowed
    if (allowDecimal) {
      // First remove all characters except numbers and decimal points
      String cleaned = replaceAll(RegExp(r'[^\d.]'), '');

      // Handle multiple decimal points - keep only the first one
      int firstDecimalIndex = cleaned.indexOf('.');
      if (firstDecimalIndex != -1) {
        String beforeDecimal = cleaned.substring(0, firstDecimalIndex + 1);
        String afterDecimal = cleaned
            .substring(firstDecimalIndex + 1)
            .replaceAll('.', '');
        return beforeDecimal + afterDecimal;
      }

      return cleaned;
    }

    // If decimals not allowed, remove everything except numbers
    return replaceAll(RegExp(r'[^\d]'), '');
  }

  /// Removes all non-numeric characters and limits the length
  String numbersOnlyWithLength({
    required int maxLength,
    bool allowDecimal = false,
  }) {
    String cleaned = numbersOnly(allowDecimal: allowDecimal);

    if (allowDecimal && cleaned.contains('.')) {
      // Split into whole number and decimal parts
      List<String> parts = cleaned.split('.');
      String wholeNumber = parts[0].substring(
        0,
        parts[0].length.clamp(0, maxLength),
      );
      return parts.length > 1 ? '$wholeNumber.${parts[1]}' : wholeNumber;
    }

    // If no decimal point, just limit the length
    return cleaned.substring(0, cleaned.length.clamp(0, maxLength));
  }

  /// Checks if string contains only numbers
  bool get isOnlyNumbers => RegExp(r'^\d+$').hasMatch(this);

  /// Checks if string is a valid decimal number
  bool get isDecimalNumber => RegExp(r'^\d*\.?\d+$').hasMatch(this);

  /// Extracts the first sequence of numbers from the string
  String get firstNumberSequence {
    final match = RegExp(r'\d+').firstMatch(this);
    return match?.group(0) ?? '';
  }
}

String getGreeting(String userName) {
  late String greeting;

  int hours = DateTime.now().hour;

  if (hours >= 0 && hours <= 12) {
    greeting = "Good Morning $userName 👋";
  } else if (hours >= 12 && hours <= 16) {
    greeting = "Good Afternoon $userName 🌞";
  } else if (hours >= 16 && hours <= 21) {
    greeting = "Good Evening $userName 😋";
  } else if (hours >= 21 && hours <= 24) {
    greeting = "Good Night $userName 🛌🏻";
  }

  return greeting;
}

extension StringExtensions on String? {
  String? get nullIfEmpty {
    if (this == null || this!.trim().isEmpty) {
      return null;
    }
    return this;
  }
}
