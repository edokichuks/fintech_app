// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileDrawerUiState {
  const ProfileDrawerUiState({
    this.isOpen = false,
    this.notificationsEnabled = true,
  });

  final bool isOpen;
  final bool notificationsEnabled;

  ProfileDrawerUiState copyWith({
    bool? isOpen,
    bool? notificationsEnabled,
  }) {
    return ProfileDrawerUiState(
      isOpen: isOpen ?? this.isOpen,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }
}

class ProfileDrawerUiNotifier extends StateNotifier<ProfileDrawerUiState> {
  ProfileDrawerUiNotifier() : super(const ProfileDrawerUiState());

  void open() {
    state = state.copyWith(isOpen: true);
  }

  void close() {
    state = state.copyWith(isOpen: false);
  }

  void toggleDrawer() {
    state = state.copyWith(isOpen: !state.isOpen);
  }

  void toggleNotifications(bool value) {
    state = state.copyWith(notificationsEnabled: value);
  }
}

final profileDrawerUiProvider =
    StateNotifierProvider<ProfileDrawerUiNotifier, ProfileDrawerUiState>(
      (ref) => ProfileDrawerUiNotifier(),
    );
