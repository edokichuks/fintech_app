// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:fintech_app/src/application/model/fintech_dashboard_snapshot.dart';

class DashboardUiState {
  const DashboardUiState({
    this.selectedFilter = FintechHistoryFilter.weekly,
  });

  final FintechHistoryFilter selectedFilter;

  DashboardUiState copyWith({
    FintechHistoryFilter? selectedFilter,
  }) {
    return DashboardUiState(
      selectedFilter: selectedFilter ?? this.selectedFilter,
    );
  }
}

class DashboardUiNotifier extends StateNotifier<DashboardUiState> {
  DashboardUiNotifier() : super(const DashboardUiState());

  void setSelectedFilter(FintechHistoryFilter filter) {
    state = state.copyWith(selectedFilter: filter);
  }
}

final dashboardUiProvider =
    StateNotifierProvider<DashboardUiNotifier, DashboardUiState>(
      (ref) => DashboardUiNotifier(),
    );
