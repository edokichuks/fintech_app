// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:fintech_app/src/application/model/fintech_dashboard_snapshot.dart';

void main() {
  group('FintechDashboardSnapshot', () {
    test('mock returns deterministic fintech content', () {
      final snapshot = FintechDashboardSnapshot.mock(tick: 2);

      expect(snapshot.user.fullName, 'Tayyab Sohail');
      expect(snapshot.cards, hasLength(3));
      expect(snapshot.quickActions, hasLength(4));
      expect(snapshot.transactions, isNotEmpty);
      expect(snapshot.spendPoints, hasLength(6));
      expect(snapshot.physicalCardCount, 2);
      expect(snapshot.virtualCardCount, 1);
    });

    test('copyWith updates selected fields only', () {
      final snapshot = FintechDashboardSnapshot.mock(tick: 1);
      final updated = snapshot.copyWith(
        totalBalance: 2400,
        user: snapshot.user.copyWith(firstName: 'Amina'),
      );

      expect(updated.totalBalance, 2400);
      expect(updated.user.firstName, 'Amina');
      expect(updated.cards, snapshot.cards);
      expect(updated.transactions, snapshot.transactions);
    });

    test('toJson and fromJson preserve serialized values', () {
      final snapshot = FintechDashboardSnapshot.mock(tick: 3);

      final serialized = snapshot.toJson();
      final restored = FintechDashboardSnapshot.fromJson(serialized);

      expect(restored, snapshot);
    });
  });

  group('FintechBankCard', () {
    test('maskedNumber exposes only the last four digits', () {
      const card = FintechBankCard(
        id: 'card-1',
        cardNumber: '4532861148273466',
        holderName: 'Tayyab Sohail',
        expiryLabel: '12 / 02 / 2024',
        cvv: '663',
        variant: FintechCardVariant.physical,
      );

      expect(card.maskedNumber, '•••• •••• •••• 3466');
      expect(card.isVirtual, isFalse);
    });
  });
}
