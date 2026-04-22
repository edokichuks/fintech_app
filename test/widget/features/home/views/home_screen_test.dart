// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

// Project imports:
import 'package:fintech_app/src/application/model/fintech_dashboard_snapshot.dart';
import 'package:fintech_app/src/application/repositories/fintech/fintech_dashboard_repository.dart';
import 'package:fintech_app/src/features/home/views/home_screen.dart';
import 'package:fintech_app/src/features/home/domain/notifiers/profile_drawer_ui_notifier.dart';
import 'package:fintech_app/src/general_widgets/general_widget_exports.dart';

// Relative imports:
import '../../../../helpers/fintech_test_harness.dart';

void main() {
  group('HomeScreen', () {
    testWidgets('shows shimmer loading state while data is pending', (
      WidgetTester tester,
    ) async {
      final controller = StreamController<FintechDashboardSnapshot>();
      addTearDown(controller.close);

      final container = createTestContainer(
        overrides: <Override>[
          fintechDashboardRepositoryProvider.overrideWithValue(
            TestFintechDashboardRepository(stream: controller.stream),
          ),
        ],
      );

      await pumpFintechApp(
        tester,
        container: container,
        home: const HomeScreen(),
      );
      await tester.pump();

      expect(find.byType(FintechShimmerBox), findsWidgets);
    });

    testWidgets('renders dashboard sections in light mode on a small phone', (
      WidgetTester tester,
    ) async {
      final snapshot = buildTestSnapshot();
      final container = createTestContainer(
        overrides: <Override>[
          fintechDashboardRepositoryProvider.overrideWithValue(
            TestFintechDashboardRepository(
              stream: Stream.value(snapshot),
              refreshedSnapshot: snapshot,
            ),
          ),
        ],
      );

      await pumpFintechApp(
        tester,
        container: container,
        home: const HomeScreen(),
        themeMode: ThemeMode.light,
        size: const Size(320, 640),
      );
      await tester.pump(const Duration(milliseconds: 900));

      expect(find.text('Transaction History'), findsOneWidget);
      expect(find.text('Total Balance'), findsOneWidget);
      expect(find.text('Bill Pay'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('shows retry UI on stream error', (WidgetTester tester) async {
      final container = createTestContainer(
        overrides: <Override>[
          fintechDashboardRepositoryProvider.overrideWithValue(
            TestFintechDashboardRepository(
              stream: Stream.error(
                const FintechDashboardException(
                  'Unable to refresh your dashboard right now.',
                ),
              ),
            ),
          ),
        ],
      );

      await pumpFintechApp(
        tester,
        container: container,
        home: const HomeScreen(),
      );
      await tester.pump();

      expect(find.text('Something went wrong'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('menu tap opens the drawer and overlay tap closes it', (
      WidgetTester tester,
    ) async {
      final snapshot = buildTestSnapshot();
      final container = createTestContainer(
        overrides: <Override>[
          fintechDashboardRepositoryProvider.overrideWithValue(
            TestFintechDashboardRepository(
              stream: Stream.value(snapshot),
              refreshedSnapshot: snapshot,
            ),
          ),
        ],
      );

      await pumpFintechApp(
        tester,
        container: container,
        home: const HomeScreen(),
      );
      await tester.pump(const Duration(milliseconds: 900));

      expect(container.read(profileDrawerUiProvider).isOpen, isFalse);

      await tester.tap(find.byIcon(LucideIcons.menu400));
      await tester.pump(const Duration(milliseconds: 350));

      expect(container.read(profileDrawerUiProvider).isOpen, isTrue);

      await tester.tapAt(const Offset(360, 200));
      await tester.pump(const Duration(milliseconds: 350));

      expect(container.read(profileDrawerUiProvider).isOpen, isFalse);
    });
  });
}
