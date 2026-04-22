// Dart imports:
import 'dart:async';
import 'dart:math';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:fintech_app/src/application/model/fintech_dashboard_snapshot.dart';

class FintechDashboardException implements Exception {
  const FintechDashboardException(this.message);

  final String message;

  @override
  String toString() => message;
}

class MockFintechDashboardService {
  MockFintechDashboardService({
    Random? random,
    this.updateInterval = const Duration(seconds: 3),
    this.enableRandomErrors = true,
    this.errorTicks = const <int>{},
    this.initialDelayOverride,
  }) : _random = random ?? Random();

  final Random _random;
  final Duration updateInterval;
  final bool enableRandomErrors;
  final Set<int> errorTicks;
  final Duration? initialDelayOverride;

  int _emissionCount = 0;

  Stream<FintechDashboardSnapshot> watchDashboard() async* {
    await Future<void>.delayed(initialDelayOverride ?? _initialDelay());

    while (true) {
      yield _buildSnapshot();
      await Future<void>.delayed(updateInterval);
    }
  }

  Future<FintechDashboardSnapshot> refreshDashboard() async {
    await Future<void>.delayed(initialDelayOverride ?? _initialDelay());
    return _buildSnapshot();
  }

  Duration _initialDelay() {
    return Duration(milliseconds: 500 + _random.nextInt(301));
  }

  FintechDashboardSnapshot _buildSnapshot() {
    _emissionCount += 1;

    if (errorTicks.contains(_emissionCount) ||
        (enableRandomErrors && _random.nextInt(100) == 0)) {
      throw const FintechDashboardException(
        'Unable to refresh your dashboard right now.',
      );
    }

    return FintechDashboardSnapshot.mock(
      random: _random,
      tick: _emissionCount,
      generatedAt: DateTime(2024, 12, 12, 12, 10).add(
        Duration(minutes: _emissionCount),
      ),
    );
  }
}

abstract interface class FintechDashboardRepository {
  Stream<FintechDashboardSnapshot> watchDashboard();
  Future<FintechDashboardSnapshot> refreshDashboard();
}

class MockFintechDashboardRepository implements FintechDashboardRepository {
  const MockFintechDashboardRepository(this._service);

  final MockFintechDashboardService _service;

  @override
  Future<FintechDashboardSnapshot> refreshDashboard() {
    return _service.refreshDashboard();
  }

  @override
  Stream<FintechDashboardSnapshot> watchDashboard() {
    return _service.watchDashboard();
  }
}

final mockFintechDashboardServiceProvider = Provider<MockFintechDashboardService>(
  (ref) => MockFintechDashboardService(),
);

final fintechDashboardRepositoryProvider = Provider<FintechDashboardRepository>(
  (ref) => MockFintechDashboardRepository(
    ref.watch(mockFintechDashboardServiceProvider),
  ),
);

final fintechDashboardStreamProvider = StreamProvider<FintechDashboardSnapshot>(
  (ref) => ref.watch(fintechDashboardRepositoryProvider).watchDashboard(),
);
