// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:fintech_app/src/features/bottom_nav/domain/notifier/app_bottom_nav_state.dart';

class AppBottomNavNotifier extends StateNotifier<AppBottomNavState> {
  AppBottomNavNotifier() : super(AppBottomNavState.initialState());

  moveToTab({required int index}) {
    state = state.copyWith(currentTabIndex: index);
  }
}

final appBottomNavProdivder =
    StateNotifierProvider<AppBottomNavNotifier, AppBottomNavState>(
      (ref) => AppBottomNavNotifier(),
    );
