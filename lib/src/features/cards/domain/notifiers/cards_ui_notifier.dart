// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:fintech_app/src/application/model/fintech_dashboard_snapshot.dart';

class FintechCardControlState {
  const FintechCardControlState({
    this.isFrozen = false,
    this.isRevealed = false,
    this.changePinEnabled = true,
    this.qrPaymentEnabled = true,
    this.onlineShoppingEnabled = false,
    this.tapPayEnabled = true,
  });

  final bool isFrozen;
  final bool isRevealed;
  final bool changePinEnabled;
  final bool qrPaymentEnabled;
  final bool onlineShoppingEnabled;
  final bool tapPayEnabled;

  FintechCardControlState copyWith({
    bool? isFrozen,
    bool? isRevealed,
    bool? changePinEnabled,
    bool? qrPaymentEnabled,
    bool? onlineShoppingEnabled,
    bool? tapPayEnabled,
  }) {
    return FintechCardControlState(
      isFrozen: isFrozen ?? this.isFrozen,
      isRevealed: isRevealed ?? this.isRevealed,
      changePinEnabled: changePinEnabled ?? this.changePinEnabled,
      qrPaymentEnabled: qrPaymentEnabled ?? this.qrPaymentEnabled,
      onlineShoppingEnabled: onlineShoppingEnabled ?? this.onlineShoppingEnabled,
      tapPayEnabled: tapPayEnabled ?? this.tapPayEnabled,
    );
  }
}

class CardsUiState {
  const CardsUiState({
    this.activeCardIndex = 0,
    this.spendRange = FintechSpendRange.weekly,
    this.selectedVariant = FintechCardVariant.physical,
    this.controlsByCardId = const <String, FintechCardControlState>{},
  });

  final int activeCardIndex;
  final FintechSpendRange spendRange;
  final FintechCardVariant selectedVariant;
  final Map<String, FintechCardControlState> controlsByCardId;

  FintechCardControlState controlFor(String cardId) {
    return controlsByCardId[cardId] ?? const FintechCardControlState();
  }

  CardsUiState copyWith({
    int? activeCardIndex,
    FintechSpendRange? spendRange,
    FintechCardVariant? selectedVariant,
    Map<String, FintechCardControlState>? controlsByCardId,
  }) {
    return CardsUiState(
      activeCardIndex: activeCardIndex ?? this.activeCardIndex,
      spendRange: spendRange ?? this.spendRange,
      selectedVariant: selectedVariant ?? this.selectedVariant,
      controlsByCardId: controlsByCardId ?? this.controlsByCardId,
    );
  }
}

class CardsUiNotifier extends StateNotifier<CardsUiState> {
  CardsUiNotifier() : super(const CardsUiState());

  void setActiveCardIndex(int index) {
    state = state.copyWith(activeCardIndex: index < 0 ? 0 : index);
  }

  void setSpendRange(FintechSpendRange range) {
    state = state.copyWith(spendRange: range);
  }

  void setSelectedVariant(FintechCardVariant variant) {
    state = state.copyWith(
      selectedVariant: variant,
      activeCardIndex: 0,
    );
  }

  void toggleFreeze(String cardId) {
    final current = state.controlFor(cardId);
    _updateControl(cardId, current.copyWith(isFrozen: !current.isFrozen));
  }

  void toggleReveal(String cardId) {
    final current = state.controlFor(cardId);
    _updateControl(cardId, current.copyWith(isRevealed: !current.isRevealed));
  }

  void toggleChangePin(String cardId, bool value) {
    final current = state.controlFor(cardId);
    _updateControl(cardId, current.copyWith(changePinEnabled: value));
  }

  void toggleQrPayment(String cardId, bool value) {
    final current = state.controlFor(cardId);
    _updateControl(cardId, current.copyWith(qrPaymentEnabled: value));
  }

  void toggleOnlineShopping(String cardId, bool value) {
    final current = state.controlFor(cardId);
    _updateControl(cardId, current.copyWith(onlineShoppingEnabled: value));
  }

  void toggleTapPay(String cardId, bool value) {
    final current = state.controlFor(cardId);
    _updateControl(cardId, current.copyWith(tapPayEnabled: value));
  }

  void _updateControl(String cardId, FintechCardControlState value) {
    state = state.copyWith(
      controlsByCardId: <String, FintechCardControlState>{
        ...state.controlsByCardId,
        cardId: value,
      },
    );
  }
}

final cardsUiProvider = StateNotifierProvider<CardsUiNotifier, CardsUiState>(
  (ref) => CardsUiNotifier(),
);
