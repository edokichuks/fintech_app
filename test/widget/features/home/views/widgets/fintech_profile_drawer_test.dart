// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

// Project imports:
import 'package:fintech_app/src/features/home/domain/notifiers/profile_drawer_ui_notifier.dart';
import 'package:fintech_app/src/features/home/views/widgets/fintech_profile_drawer.dart';

// Relative imports:
import '../../../../../helpers/fintech_test_harness.dart';

void main() {
  testWidgets('renders drawer content and toggles app notifications', (
    WidgetTester tester,
  ) async {
    final snapshot = buildTestSnapshot();
    final container = createTestContainer();

    await pumpFintechApp(
      tester,
      container: container,
      home: FintechProfileDrawer(user: snapshot.user),
    );
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text('Profile Settings'), findsOneWidget);
    expect(find.text('E-Statement'), findsOneWidget);
    expect(find.text('Credit Card'), findsOneWidget);
    expect(find.text('App Notification'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);
    expect(find.byIcon(LucideIcons.fileText400), findsOneWidget);
    expect(find.byIcon(LucideIcons.languages400), findsOneWidget);

    expect(
      container.read(profileDrawerUiProvider).notificationsEnabled,
      isTrue,
    );

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    expect(
      container.read(profileDrawerUiProvider).notificationsEnabled,
      isFalse,
    );
  });
}
