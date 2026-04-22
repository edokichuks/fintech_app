// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:fintech_app/src/application/model/fintech_dashboard_snapshot.dart';
import 'package:fintech_app/src/features/cards/domain/notifiers/cards_ui_notifier.dart';

void main() {
  group('cardsUiProvider', () {
    test('selected variant resets the active card index', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(cardsUiProvider.notifier);
      notifier.setActiveCardIndex(2);
      notifier.setSelectedVariant(FintechCardVariant.virtual);

      final state = container.read(cardsUiProvider);
      expect(state.selectedVariant, FintechCardVariant.virtual);
      expect(state.activeCardIndex, 0);
    });

    test('control toggles are stored per card id', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(cardsUiProvider.notifier);
      notifier.toggleFreeze('physical-primary');
      notifier.toggleReveal('physical-primary');
      notifier.toggleOnlineShopping('physical-primary', true);
      notifier.toggleTapPay('physical-primary', false);

      final controls = container
          .read(cardsUiProvider)
          .controlFor('physical-primary');

      expect(controls.isFrozen, isTrue);
      expect(controls.isRevealed, isTrue);
      expect(controls.onlineShoppingEnabled, isTrue);
      expect(controls.tapPayEnabled, isFalse);
    });

    test('spend range can be switched independently of card controls', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(cardsUiProvider.notifier);
      notifier.setSpendRange(FintechSpendRange.monthly);

      expect(
        container.read(cardsUiProvider).spendRange,
        FintechSpendRange.monthly,
      );
    });
  });
}
