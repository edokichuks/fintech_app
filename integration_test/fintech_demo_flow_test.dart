// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

// Project imports:
import 'package:fintech_app/src/application/repositories/fintech/fintech_dashboard_repository.dart';
import 'package:fintech_app/src/core/router/router.dart';
import 'package:fintech_app/src/core/utils/app_utils_exports.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('records the fintech feature demo flow', (tester) async {
    await _pumpDemoApp(tester);

    await _hold(tester, 'home-dashboard', seconds: 4);

    await tester.drag(find.byType(CustomScrollView), const Offset(0, -360));
    await _settle(tester);
    await _hold(tester, 'home-transactions', seconds: 3);

    await tester.tap(find.text('Monthly').first);
    await _settle(tester);
    await _hold(tester, 'home-monthly-filter', seconds: 2);

    await tester.tap(find.byIcon(LucideIcons.menu400));
    await _settle(tester);
    await _hold(tester, 'profile-drawer', seconds: 4);

    await tester.tap(find.byType(Switch).first);
    await _settle(tester);
    await _hold(tester, 'drawer-notifications-toggle', seconds: 2);

    await tester.tap(find.text('Credit Card'));
    await _settle(tester);
    await _waitFor(tester, find.text('Your Card'));
    await _hold(tester, 'cards-overview', seconds: 4);

    await tester.tap(find.text('Freeze Card'));
    await _settle(tester);
    await _hold(tester, 'card-frozen', seconds: 2);

    await tester.tap(find.text('Reveal'));
    await _settle(tester);
    await _hold(tester, 'card-revealed', seconds: 3);

    await tester.tap(find.text('Virtual Card'));
    await _settle(tester);
    await _hold(tester, 'virtual-card', seconds: 3);

    await tester.ensureVisible(find.text('Card Transactions'));
    await _settle(tester);
    await _hold(tester, 'card-settings', seconds: 3);

    await tester.tap(find.text('Card Transactions'));
    await _settle(tester);
    await _waitFor(tester, find.text('Card Transaction'));
    await _hold(tester, 'card-transaction-detail', seconds: 4);

    await tester.tap(find.text('Weekly').last);
    await _settle(tester);
    await _hold(tester, 'spend-range-toggle', seconds: 2);

    await tester.drag(find.byType(ListView), const Offset(0, -420));
    await _settle(tester);
    await _hold(tester, 'transaction-history-detail', seconds: 4);
  });
}

Future<void> _pumpDemoApp(WidgetTester tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: <Override>[
        mockFintechDashboardServiceProvider.overrideWithValue(
          MockFintechDashboardService(
            enableRandomErrors: false,
            initialDelayOverride: const Duration(milliseconds: 120),
            updateInterval: const Duration(minutes: 2),
          ),
        ),
      ],
      child: ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'FinTrack',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,
            initialRoute: AppRouter.home,
            onGenerateRoute: AppRouter.onGenerateRoute,
          );
        },
      ),
    ),
  );

  await _waitFor(tester, find.text('Total Balance'));
}

Future<void> _waitFor(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 8),
}) async {
  final deadline = DateTime.now().add(timeout);

  while (DateTime.now().isBefore(deadline)) {
    await tester.pump(const Duration(milliseconds: 100));
    if (finder.evaluate().isNotEmpty) {
      return;
    }
  }

  expect(finder, findsWidgets);
}

Future<void> _settle(WidgetTester tester) async {
  for (var i = 0; i < 8; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

Future<void> _hold(
  WidgetTester tester,
  String label, {
  required int seconds,
}) async {
  debugPrint('DEMO_STATE:$label');
  await tester.pump(const Duration(milliseconds: 120));
  await Future<void>.delayed(Duration(seconds: seconds));
}
