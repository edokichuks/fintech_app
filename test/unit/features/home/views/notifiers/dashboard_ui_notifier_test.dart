// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:fintech_app/src/application/model/fintech_dashboard_snapshot.dart';
import 'package:fintech_app/src/features/home/domain/notifiers/dashboard_ui_notifier.dart';

void main() {
  test('dashboardUiProvider updates the selected filter', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(
      container.read(dashboardUiProvider).selectedFilter,
      FintechHistoryFilter.weekly,
    );

    container
        .read(dashboardUiProvider.notifier)
        .setSelectedFilter(FintechHistoryFilter.monthly);

    expect(
      container.read(dashboardUiProvider).selectedFilter,
      FintechHistoryFilter.monthly,
    );
  });
}
