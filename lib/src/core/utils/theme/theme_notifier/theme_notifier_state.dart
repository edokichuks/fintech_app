// Flutter imports:
import 'package:flutter/material.dart';

class ThemeNotifierState {
  final ThemeMode themeMode;
  const ThemeNotifierState({
    this.themeMode = ThemeMode.dark,
  });

  factory ThemeNotifierState.initialState() {
    return const ThemeNotifierState(
      themeMode: ThemeMode.dark,
    );
  }

  ThemeNotifierState copyWith({ThemeMode? themeMode}) {
    return ThemeNotifierState(
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
