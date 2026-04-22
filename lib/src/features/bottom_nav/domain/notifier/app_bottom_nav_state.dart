class AppBottomNavState {
  final int currentTabIndex;

  AppBottomNavState({required this.currentTabIndex});

  factory AppBottomNavState.initialState() {
    return AppBottomNavState(
      currentTabIndex: 0,
    );
  }

  AppBottomNavState copyWith({int? currentTabIndex}) {
    return AppBottomNavState(
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
    );
  }
}
