// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

// Project imports:
import 'package:fintech_app/src/application/model/fintech_dashboard_snapshot.dart';
import 'package:fintech_app/src/application/repositories/fintech/fintech_dashboard_repository.dart';
import 'package:fintech_app/src/core/extensions/extension_exports.dart';
import 'package:fintech_app/src/core/utils/app_utils_exports.dart';
import 'package:fintech_app/src/features/cards/domain/notifiers/cards_ui_notifier.dart';
import 'package:fintech_app/src/features/cards/views/widgets/cards_error_view.dart';
import 'package:fintech_app/src/features/cards/views/widgets/cards_loading_view.dart';
import 'package:fintech_app/src/features/cards/views/widgets/spend_chart_card.dart';
import 'package:fintech_app/src/general_widgets/general_widget_exports.dart';

class CardTransactionScreen extends ConsumerWidget {
  const CardTransactionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(fintechDashboardStreamProvider);

    return dashboardAsync.when(
      loading: CardsLoadingView.new,
      error: (error, _) => CardsErrorView(
        message: error.toString(),
        onRetry: () => ref.invalidate(fintechDashboardStreamProvider),
      ),
      data: (snapshot) => _CardTransactionBody(snapshot: snapshot),
    );
  }
}

class _CardTransactionBody extends ConsumerWidget {
  const _CardTransactionBody({required this.snapshot});

  final FintechDashboardSnapshot snapshot;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routeCard =
        ModalRoute.of(context)?.settings.arguments as FintechBankCard?;
    final selectedCard = routeCard ?? snapshot.cards.first;
    final cardControls = ref.watch(cardsUiProvider).controlFor(selectedCard.id);
    final selectedRange = ref.watch(cardsUiProvider).spendRange;
    final transactions = snapshot.transactions
        .where((transaction) => transaction.cardId == selectedCard.id)
        .toList();
    final visibleTransactions = transactions.isEmpty
        ? snapshot.transactions.take(2).toList()
        : transactions.take(3).toList();

    return AppScaffold(
      applySafeArea: false,
      padding: EdgeInsets.zero,
      backgroundColor: FintechColors.scaffold(context),
      body: RefreshIndicator(
        color: AppColors.fintechBlue,
        backgroundColor: FintechColors.surface(context),
        onRefresh: () => _refreshCardTransactions(ref),
        child: ListView(
          padding: EdgeInsets.fromLTRB(20.w, 56.h, 20.w, 24.h),
          children: <Widget>[
            Row(
              children: <Widget>[
                PressableScale(
                  onTap: () => context.pop(),
                  child: Icon(
                    LucideIcons.chevronLeft400,
                    color: FintechColors.textPrimary(context),
                    size: 22.r,
                  ),
                ),
                SizedBox(width: FintechSpacing.md.w),
                Expanded(
                  child: AppText(
                    text: 'Card Transaction',
                    style: AppTextStyle.headlineSmall.copyWith(
                      color: FintechColors.textPrimary(context),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Icon(
                  LucideIcons.ellipsis400,
                  color: FintechColors.textPrimary(context),
                  size: 20.r,
                ),
              ],
            ),
            SizedBox(height: FintechSpacing.xl.h),
            FintechStaggeredReveal(
              child: FintechCardView(
                card: selectedCard,
                isFrozen: cardControls.isFrozen,
                isRevealed: cardControls.isRevealed,
              ),
            ),
            SizedBox(height: FintechSpacing.xl.h),
            FintechStaggeredReveal(
              delay: FintechDurations.stagger,
              child: SpendChartCard(
                totalSpend: snapshot.totalSpend,
                points: snapshot.spendPoints,
                selectedRange: selectedRange,
                onRangeChanged: (range) {
                  ref.read(cardsUiProvider.notifier).setSpendRange(range);
                },
              ),
            ),
            SizedBox(height: FintechSpacing.xl.h),
            Row(
              children: <Widget>[
                Expanded(
                  child: AppText(
                    text: 'Transaction History',
                    style: AppTextStyle.titleLarge.copyWith(
                      color: FintechColors.textPrimary(context),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                AppText(
                  text: 'See all',
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.fintechBlue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            SizedBox(height: FintechSpacing.md.h),
            ...visibleTransactions.map(
              (transaction) => FintechTransactionRow(transaction: transaction),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _refreshCardTransactions(WidgetRef ref) async {
    try {
      final _ = await ref.refresh(fintechDashboardStreamProvider.future);
    } catch (_) {}
  }
}
