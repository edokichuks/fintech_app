// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:fintech_app/src/core/utils/theme/theme_notifier/theme_notifier_state.dart';

// Relative imports:
import '../../../helpers/fintech_test_harness.dart';

void main() {
  group('AppTheme', () {
    test('defaults to dark mode', () {
      expect(ThemeNotifierState.initialState().themeMode, ThemeMode.dark);
    });

    testWidgets('uses Arimo as the app-wide font family', (
      WidgetTester tester,
    ) async {
      final container = createTestContainer();

      await pumpFintechApp(
        tester,
        container: container,
        home: const SizedBox.shrink(),
      );

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));

      expect(
        materialApp.theme?.textTheme.bodyMedium?.fontFamily,
        startsWith('Arimo'),
      );
      expect(
        materialApp.darkTheme?.textTheme.bodyMedium?.fontFamily,
        startsWith('Arimo'),
      );
      expect(
        materialApp.theme?.textTheme.titleLarge?.fontFamily,
        startsWith('Arimo'),
      );
      expect(
        materialApp.darkTheme?.textTheme.titleLarge?.fontFamily,
        startsWith('Arimo'),
      );
    });
  });
}
