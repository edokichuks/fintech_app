// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:fintech_app/src/application/repositories/fintech/fintech_dashboard_repository.dart';
import 'package:fintech_app/src/core/router/router.dart';
import 'package:fintech_app/src/features/cards/views/card_transaction_screen.dart';
import 'package:fintech_app/src/features/cards/views/cards_screen.dart';
import 'package:fintech_app/src/general_widgets/general_widget_exports.dart';

// Relative imports:
import '../../../../helpers/fintech_test_harness.dart';

void main() {
  group('Cards flow', () {
    testWidgets('cards screen renders carousel, indicators, and settings', (
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
        home: const CardsScreen(),
      );
      await tester.pump(const Duration(milliseconds: 900));

      expect(find.text('Your Card'), findsOneWidget);
      expect(find.text('Card Settings'), findsOneWidget);
      expect(find.text('Freeze Card'), findsOneWidget);
      expect(find.text('Change Pin'), findsOneWidget);
      expect(find.byType(FintechCardView), findsWidgets);
      expect(find.byType(Switch), findsNWidgets(4));
    });

    testWidgets(
      'card transaction screen renders chart shell and history list',
      (WidgetTester tester) async {
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
          home: const CardTransactionScreen(),
        );
        await tester.pump(const Duration(milliseconds: 900));

        expect(find.text('Card Transaction'), findsOneWidget);
        expect(find.text('Total Spend'), findsOneWidget);
        expect(find.text('Transaction History'), findsOneWidget);
        expect(find.byType(LineChart), findsOneWidget);
      },
    );

    testWidgets('opens card transaction detail through the registered route', (
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
        home: Builder(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      AppRouter.cardTransactionScreen,
                      arguments: snapshot.cards.first,
                    );
                  },
                  child: const Text('Open Transactions'),
                ),
              ),
            );
          },
        ),
        onGenerateRoute: AppRouter.onGenerateRoute,
      );
      await tester.pump();

      await tester.tap(find.text('Open Transactions'));
      await tester.pumpAndSettle();

      expect(find.text('Card Transaction'), findsOneWidget);
      expect(find.text('Total Spend'), findsOneWidget);
    });
  });
}
