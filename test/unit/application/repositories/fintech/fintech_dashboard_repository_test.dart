// Dart imports:
import 'dart:math';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:fintech_app/src/application/repositories/fintech/fintech_dashboard_repository.dart';

void main() {
  group('MockFintechDashboardRepository', () {
    test(
      'refreshDashboard returns a snapshot after the initial load delay',
      () async {
        final repository = MockFintechDashboardRepository(
          MockFintechDashboardService(
            random: Random(7),
            enableRandomErrors: false,
            initialDelayOverride: Duration.zero,
          ),
        );

        final snapshot = await repository.refreshDashboard();

        expect(snapshot.totalBalance, greaterThan(0));
        expect(snapshot.cards, isNotEmpty);
      },
    );

    test('watchDashboard emits periodic updates', () async {
      final repository = MockFintechDashboardRepository(
        MockFintechDashboardService(
          random: Random(3),
          updateInterval: Duration.zero,
          enableRandomErrors: false,
          initialDelayOverride: Duration.zero,
        ),
      );

      final snapshots = await repository.watchDashboard().take(2).toList();

      expect(snapshots, hasLength(2));
      expect(
        snapshots.first.generatedAt.isBefore(snapshots.last.generatedAt),
        isTrue,
      );
      expect(
        snapshots.first.totalBalance != snapshots.last.totalBalance,
        isTrue,
      );
    });

    test('refreshDashboard supports retry after a recoverable error', () async {
      final repository = MockFintechDashboardRepository(
        MockFintechDashboardService(
          random: Random(9),
          enableRandomErrors: false,
          errorTicks: const <int>{1},
          initialDelayOverride: Duration.zero,
        ),
      );

      await expectLater(
        repository.refreshDashboard(),
        throwsA(isA<FintechDashboardException>()),
      );

      final retriedSnapshot = await repository.refreshDashboard();

      expect(retriedSnapshot.cards, isNotEmpty);
      expect(retriedSnapshot.generatedAt.year, 2024);
    });
  });
}
