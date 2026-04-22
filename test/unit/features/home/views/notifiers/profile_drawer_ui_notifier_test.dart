// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:fintech_app/src/features/home/domain/notifiers/profile_drawer_ui_notifier.dart';

void main() {
  test('profileDrawerUiProvider opens, closes, and updates notifications', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(profileDrawerUiProvider).isOpen, isFalse);
    expect(
      container.read(profileDrawerUiProvider).notificationsEnabled,
      isTrue,
    );

    container.read(profileDrawerUiProvider.notifier).open();
    expect(container.read(profileDrawerUiProvider).isOpen, isTrue);

    container.read(profileDrawerUiProvider.notifier).toggleNotifications(false);
    expect(
      container.read(profileDrawerUiProvider).notificationsEnabled,
      isFalse,
    );

    container.read(profileDrawerUiProvider.notifier).close();
    expect(container.read(profileDrawerUiProvider).isOpen, isFalse);
  });
}
