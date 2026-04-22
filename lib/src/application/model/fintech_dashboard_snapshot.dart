// Dart imports:
import 'dart:math';

// Package imports:
import 'package:equatable/equatable.dart';

enum FintechHistoryFilter { weekly, monthly, today }

enum FintechCardVariant { physical, virtual }

enum FintechSpendRange { weekly, monthly }

enum FintechTransactionIcon { wallet, shopping, globe, bank, savings }

enum FintechQuickActionType { billPay, donations, deposit, more }

class FintechUserSummary extends Equatable {
  const FintechUserSummary({
    required this.firstName,
    required this.lastName,
    this.unreadNotifications = 1,
  });

  final String firstName;
  final String lastName;
  final int unreadNotifications;

  String get fullName => '$firstName $lastName';

  FintechUserSummary copyWith({
    String? firstName,
    String? lastName,
    int? unreadNotifications,
  }) {
    return FintechUserSummary(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      unreadNotifications: unreadNotifications ?? this.unreadNotifications,
    );
  }

  factory FintechUserSummary.mock({int unreadNotifications = 1}) {
    return FintechUserSummary(
      firstName: 'Tayyab',
      lastName: 'Sohail',
      unreadNotifications: unreadNotifications,
    );
  }

  factory FintechUserSummary.fromJson(Map<String, dynamic> json) {
    return FintechUserSummary(
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      unreadNotifications: (json['unreadNotifications'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'unreadNotifications': unreadNotifications,
  };

  @override
  List<Object?> get props => [firstName, lastName, unreadNotifications];
}

class FintechBankCard extends Equatable {
  const FintechBankCard({
    required this.id,
    required this.cardNumber,
    required this.holderName,
    required this.expiryLabel,
    required this.cvv,
    required this.variant,
  });

  final String id;
  final String cardNumber;
  final String holderName;
  final String expiryLabel;
  final String cvv;
  final FintechCardVariant variant;

  bool get isVirtual => variant == FintechCardVariant.virtual;

  String get maskedNumber {
    final lastFourDigits = cardNumber.substring(cardNumber.length - 4);
    return '•••• •••• •••• $lastFourDigits';
  }

  FintechBankCard copyWith({
    String? id,
    String? cardNumber,
    String? holderName,
    String? expiryLabel,
    String? cvv,
    FintechCardVariant? variant,
  }) {
    return FintechBankCard(
      id: id ?? this.id,
      cardNumber: cardNumber ?? this.cardNumber,
      holderName: holderName ?? this.holderName,
      expiryLabel: expiryLabel ?? this.expiryLabel,
      cvv: cvv ?? this.cvv,
      variant: variant ?? this.variant,
    );
  }

  factory FintechBankCard.fromJson(Map<String, dynamic> json) {
    return FintechBankCard(
      id: json['id'] as String? ?? '',
      cardNumber: json['cardNumber'] as String? ?? '',
      holderName: json['holderName'] as String? ?? '',
      expiryLabel: json['expiryLabel'] as String? ?? '',
      cvv: json['cvv'] as String? ?? '',
      variant: FintechCardVariant.values.firstWhere(
        (value) => value.name == json['variant'],
        orElse: () => FintechCardVariant.physical,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'cardNumber': cardNumber,
    'holderName': holderName,
    'expiryLabel': expiryLabel,
    'cvv': cvv,
    'variant': variant.name,
  };

  @override
  List<Object?> get props => [id, cardNumber, holderName, expiryLabel, cvv, variant];
}

class FintechSpendPoint extends Equatable {
  const FintechSpendPoint({
    required this.x,
    required this.y,
    required this.label,
  });

  final double x;
  final double y;
  final String label;

  FintechSpendPoint copyWith({
    double? x,
    double? y,
    String? label,
  }) {
    return FintechSpendPoint(
      x: x ?? this.x,
      y: y ?? this.y,
      label: label ?? this.label,
    );
  }

  factory FintechSpendPoint.fromJson(Map<String, dynamic> json) {
    return FintechSpendPoint(
      x: (json['x'] as num?)?.toDouble() ?? 0,
      y: (json['y'] as num?)?.toDouble() ?? 0,
      label: json['label'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'x': x,
    'y': y,
    'label': label,
  };

  @override
  List<Object?> get props => [x, y, label];
}

class FintechTransactionRecord extends Equatable {
  const FintechTransactionRecord({
    required this.id,
    required this.title,
    required this.occurredAt,
    required this.amount,
    required this.isCredit,
    required this.icon,
    required this.filter,
    required this.cardId,
  });

  final String id;
  final String title;
  final DateTime occurredAt;
  final double amount;
  final bool isCredit;
  final FintechTransactionIcon icon;
  final FintechHistoryFilter filter;
  final String cardId;

  FintechTransactionRecord copyWith({
    String? id,
    String? title,
    DateTime? occurredAt,
    double? amount,
    bool? isCredit,
    FintechTransactionIcon? icon,
    FintechHistoryFilter? filter,
    String? cardId,
  }) {
    return FintechTransactionRecord(
      id: id ?? this.id,
      title: title ?? this.title,
      occurredAt: occurredAt ?? this.occurredAt,
      amount: amount ?? this.amount,
      isCredit: isCredit ?? this.isCredit,
      icon: icon ?? this.icon,
      filter: filter ?? this.filter,
      cardId: cardId ?? this.cardId,
    );
  }

  factory FintechTransactionRecord.fromJson(Map<String, dynamic> json) {
    return FintechTransactionRecord(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      occurredAt: DateTime.tryParse(json['occurredAt'] as String? ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
      isCredit: json['isCredit'] as bool? ?? true,
      icon: FintechTransactionIcon.values.firstWhere(
        (value) => value.name == json['icon'],
        orElse: () => FintechTransactionIcon.wallet,
      ),
      filter: FintechHistoryFilter.values.firstWhere(
        (value) => value.name == json['filter'],
        orElse: () => FintechHistoryFilter.weekly,
      ),
      cardId: json['cardId'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'occurredAt': occurredAt.toIso8601String(),
    'amount': amount,
    'isCredit': isCredit,
    'icon': icon.name,
    'filter': filter.name,
    'cardId': cardId,
  };

  @override
  List<Object?> get props => [id, title, occurredAt, amount, isCredit, icon, filter, cardId];
}

class FintechQuickAction extends Equatable {
  const FintechQuickAction({
    required this.title,
    required this.type,
  });

  final String title;
  final FintechQuickActionType type;

  FintechQuickAction copyWith({
    String? title,
    FintechQuickActionType? type,
  }) {
    return FintechQuickAction(
      title: title ?? this.title,
      type: type ?? this.type,
    );
  }

  factory FintechQuickAction.fromJson(Map<String, dynamic> json) {
    return FintechQuickAction(
      title: json['title'] as String? ?? '',
      type: FintechQuickActionType.values.firstWhere(
        (value) => value.name == json['type'],
        orElse: () => FintechQuickActionType.more,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'type': type.name,
  };

  @override
  List<Object?> get props => [title, type];
}

class FintechDashboardSnapshot extends Equatable {
  const FintechDashboardSnapshot({
    required this.user,
    required this.totalBalance,
    required this.totalSpend,
    required this.cards,
    required this.quickActions,
    required this.transactions,
    required this.spendPoints,
    required this.generatedAt,
  });

  final FintechUserSummary user;
  final double totalBalance;
  final double totalSpend;
  final List<FintechBankCard> cards;
  final List<FintechQuickAction> quickActions;
  final List<FintechTransactionRecord> transactions;
  final List<FintechSpendPoint> spendPoints;
  final DateTime generatedAt;

  int get physicalCardCount =>
      cards.where((card) => card.variant == FintechCardVariant.physical).length;

  int get virtualCardCount =>
      cards.where((card) => card.variant == FintechCardVariant.virtual).length;

  FintechDashboardSnapshot copyWith({
    FintechUserSummary? user,
    double? totalBalance,
    double? totalSpend,
    List<FintechBankCard>? cards,
    List<FintechQuickAction>? quickActions,
    List<FintechTransactionRecord>? transactions,
    List<FintechSpendPoint>? spendPoints,
    DateTime? generatedAt,
  }) {
    return FintechDashboardSnapshot(
      user: user ?? this.user,
      totalBalance: totalBalance ?? this.totalBalance,
      totalSpend: totalSpend ?? this.totalSpend,
      cards: cards ?? this.cards,
      quickActions: quickActions ?? this.quickActions,
      transactions: transactions ?? this.transactions,
      spendPoints: spendPoints ?? this.spendPoints,
      generatedAt: generatedAt ?? this.generatedAt,
    );
  }

  factory FintechDashboardSnapshot.mock({
    Random? random,
    int tick = 0,
    DateTime? generatedAt,
  }) {
    final currentRandom = random ?? Random(1200 + tick);
    final baseTime = generatedAt ?? DateTime(2024, 12, 12, 12, 10).add(Duration(minutes: tick));
    final cards = [
      const FintechBankCard(
        id: 'physical-primary',
        cardNumber: '4532861148273466',
        holderName: 'Tayyab Sohail',
        expiryLabel: '12 / 02 / 2024',
        cvv: '663',
        variant: FintechCardVariant.physical,
      ),
      const FintechBankCard(
        id: 'physical-secondary',
        cardNumber: '4532861148271824',
        holderName: 'Tayyab Sohail',
        expiryLabel: '03 / 10 / 2026',
        cvv: '442',
        variant: FintechCardVariant.physical,
      ),
      const FintechBankCard(
        id: 'virtual-primary',
        cardNumber: '4532861148279012',
        holderName: 'Tayyab Sohail',
        expiryLabel: '09 / 09 / 2027',
        cvv: '905',
        variant: FintechCardVariant.virtual,
      ),
    ];

    final totalBalance = 1200 + tick * 16 + currentRandom.nextInt(9);
    final totalSpend = 30 + currentRandom.nextInt(6);

    return FintechDashboardSnapshot(
      user: FintechUserSummary.mock(
        unreadNotifications: tick.isEven ? 1 : 2,
      ),
      totalBalance: totalBalance.toDouble(),
      totalSpend: totalSpend.toDouble(),
      cards: cards,
      quickActions: const [
        FintechQuickAction(
          title: 'Bill Pay',
          type: FintechQuickActionType.billPay,
        ),
        FintechQuickAction(
          title: 'Donations',
          type: FintechQuickActionType.donations,
        ),
        FintechQuickAction(
          title: 'Deposit',
          type: FintechQuickActionType.deposit,
        ),
        FintechQuickAction(title: 'More', type: FintechQuickActionType.more),
      ],
      transactions: [
        FintechTransactionRecord(
          id: 'wallet-$tick',
          title: 'E wallet',
          occurredAt: baseTime,
          amount: 100,
          isCredit: true,
          icon: FintechTransactionIcon.wallet,
          filter: FintechHistoryFilter.weekly,
          cardId: cards.first.id,
        ),
        FintechTransactionRecord(
          id: 'shopping-$tick',
          title: 'Online Shopping',
          occurredAt: baseTime,
          amount: 100,
          isCredit: false,
          icon: FintechTransactionIcon.shopping,
          filter: FintechHistoryFilter.weekly,
          cardId: cards.first.id,
        ),
        FintechTransactionRecord(
          id: 'wallet-globe-$tick',
          title: 'E wallet',
          occurredAt: baseTime.subtract(const Duration(days: 1)),
          amount: 100,
          isCredit: true,
          icon: FintechTransactionIcon.globe,
          filter: FintechHistoryFilter.monthly,
          cardId: cards[1].id,
        ),
        FintechTransactionRecord(
          id: 'bank-fee-$tick',
          title: 'Banking Fee',
          occurredAt: baseTime.subtract(const Duration(days: 2)),
          amount: 100,
          isCredit: true,
          icon: FintechTransactionIcon.bank,
          filter: FintechHistoryFilter.monthly,
          cardId: cards.first.id,
        ),
        FintechTransactionRecord(
          id: 'saving-$tick',
          title: 'Saving',
          occurredAt: baseTime.subtract(const Duration(days: 3)),
          amount: 300,
          isCredit: false,
          icon: FintechTransactionIcon.savings,
          filter: FintechHistoryFilter.today,
          cardId: cards[2].id,
        ),
      ],
      spendPoints: [
        FintechSpendPoint(x: 0, y: 2.0 + currentRandom.nextDouble(), label: 'Jan'),
        FintechSpendPoint(x: 1, y: 4.2 + currentRandom.nextDouble(), label: 'Feb'),
        FintechSpendPoint(x: 2, y: 3.8 + currentRandom.nextDouble(), label: 'Mar'),
        FintechSpendPoint(x: 3, y: 5.8 + currentRandom.nextDouble(), label: 'Apr'),
        FintechSpendPoint(x: 4, y: 5.1 + currentRandom.nextDouble(), label: 'May'),
        FintechSpendPoint(x: 5, y: 6.6 + currentRandom.nextDouble(), label: 'Jun'),
      ],
      generatedAt: baseTime,
    );
  }

  factory FintechDashboardSnapshot.fromJson(Map<String, dynamic> json) {
    return FintechDashboardSnapshot(
      user: FintechUserSummary.fromJson(json['user'] as Map<String, dynamic>? ?? {}),
      totalBalance: (json['totalBalance'] as num?)?.toDouble() ?? 0,
      totalSpend: (json['totalSpend'] as num?)?.toDouble() ?? 0,
      cards: (json['cards'] as List<dynamic>? ?? [])
          .map((item) => FintechBankCard.fromJson(item as Map<String, dynamic>))
          .toList(),
      quickActions: (json['quickActions'] as List<dynamic>? ?? [])
          .map((item) => FintechQuickAction.fromJson(item as Map<String, dynamic>))
          .toList(),
      transactions: (json['transactions'] as List<dynamic>? ?? [])
          .map(
            (item) => FintechTransactionRecord.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList(),
      spendPoints: (json['spendPoints'] as List<dynamic>? ?? [])
          .map((item) => FintechSpendPoint.fromJson(item as Map<String, dynamic>))
          .toList(),
      generatedAt: DateTime.tryParse(json['generatedAt'] as String? ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  Map<String, dynamic> toJson() => {
    'user': user.toJson(),
    'totalBalance': totalBalance,
    'totalSpend': totalSpend,
    'cards': cards.map((item) => item.toJson()).toList(),
    'quickActions': quickActions.map((item) => item.toJson()).toList(),
    'transactions': transactions.map((item) => item.toJson()).toList(),
    'spendPoints': spendPoints.map((item) => item.toJson()).toList(),
    'generatedAt': generatedAt.toIso8601String(),
  };

  @override
  List<Object?> get props => [
    user,
    totalBalance,
    totalSpend,
    cards,
    quickActions,
    transactions,
    spendPoints,
    generatedAt,
  ];
}
