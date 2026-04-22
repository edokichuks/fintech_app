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
import 'package:fintech_app/src/core/router/router.dart';
import 'package:fintech_app/src/core/utils/app_utils_exports.dart';
import 'package:fintech_app/src/features/cards/domain/notifiers/cards_ui_notifier.dart';
import 'package:fintech_app/src/features/cards/views/widgets/card_actions_row.dart';
import 'package:fintech_app/src/features/cards/views/widgets/card_settings_section.dart';
import 'package:fintech_app/src/features/cards/views/widgets/cards_error_view.dart';
import 'package:fintech_app/src/features/cards/views/widgets/cards_loading_view.dart';
import 'package:fintech_app/src/general_widgets/general_widget_exports.dart';

class CardsScreen extends ConsumerStatefulWidget {
  const CardsScreen({super.key});

  @override
  ConsumerState<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends ConsumerState<CardsScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.78);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardAsync = ref.watch(fintechDashboardStreamProvider);

    return dashboardAsync.when(
      loading: CardsLoadingView.new,
      error: (error, _) => CardsErrorView(
        message: error.toString(),
        onRetry: () => ref.invalidate(fintechDashboardStreamProvider),
      ),
      data: (snapshot) =>
          _CardsBody(pageController: _pageController, snapshot: snapshot),
    );
  }
}

class _CardsBody extends ConsumerWidget {
  const _CardsBody({required this.pageController, required this.snapshot});

  final PageController pageController;
  final FintechDashboardSnapshot snapshot;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardsUiState = ref.watch(cardsUiProvider);
    final filteredCards = snapshot.cards
        .where((card) => card.variant == cardsUiState.selectedVariant)
        .toList();
    final cards = filteredCards.isEmpty ? snapshot.cards : filteredCards;
    final activeIndex = cardsUiState.activeCardIndex >= cards.length
        ? 0
        : cardsUiState.activeCardIndex;
    final selectedCard = cards[activeIndex];
    final controls = cardsUiState.controlFor(selectedCard.id);

    return AppScaffold(
      applySafeArea: false,
      padding: EdgeInsets.zero,
      backgroundColor: FintechColors.scaffold(context),
      body: RefreshIndicator(
        color: AppColors.fintechBlue,
        backgroundColor: FintechColors.surface(context),
        onRefresh: () => _refreshCards(ref),
        child: ListView(
          padding: EdgeInsets.fromLTRB(20.w, 56.h, 20.w, 24.h),
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: AppText(
                    text: 'Your Card',
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
            SizedBox(height: 2.h),
            AppText(
              text:
                  '${snapshot.physicalCardCount} Physical Card, ${snapshot.virtualCardCount} Virtual Card',
              style: AppTextStyle.bodySmall.copyWith(
                color: FintechColors.textSecondary(context),
              ),
            ),
            SizedBox(height: FintechSpacing.xl.h),
            Wrap(
              spacing: FintechSpacing.md.w,
              runSpacing: FintechSpacing.sm.h,
              children: <Widget>[
                _VariantChip(
                  label: 'Physical Card',
                  isSelected:
                      cardsUiState.selectedVariant ==
                      FintechCardVariant.physical,
                  onTap: () {
                    ref
                        .read(cardsUiProvider.notifier)
                        .setSelectedVariant(FintechCardVariant.physical);
                    pageController.jumpToPage(0);
                  },
                ),
                _VariantChip(
                  label: 'Virtual Card',
                  isSelected:
                      cardsUiState.selectedVariant ==
                      FintechCardVariant.virtual,
                  onTap: () {
                    ref
                        .read(cardsUiProvider.notifier)
                        .setSelectedVariant(FintechCardVariant.virtual);
                    pageController.jumpToPage(0);
                  },
                ),
              ],
            ),
            SizedBox(height: FintechSpacing.xl.h),
            SizedBox(
              height: 228.h,
              child: PageView.builder(
                controller: pageController,
                itemCount: cards.length,
                onPageChanged: (index) {
                  ref.read(cardsUiProvider.notifier).setActiveCardIndex(index);
                },
                itemBuilder: (context, index) {
                  final card = cards[index];
                  final cardControls = cardsUiState.controlFor(card.id);
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: FintechStaggeredReveal(
                      delay: Duration(milliseconds: 100 * index),
                      child: FintechCardView(
                        card: card,
                        isFrozen: cardControls.isFrozen,
                        isRevealed: cardControls.isRevealed,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: FintechSpacing.md.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(cards.length, (index) {
                final isSelected = index == activeIndex;
                return AnimatedContainer(
                  duration: FintechDurations.press,
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  width: isSelected ? 18.w : 8.w,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.fintechBlue
                        : FintechColors.textMuted(context),
                    borderRadius: BorderRadius.circular(FintechRadius.pill.r),
                  ),
                );
              }),
            ),
            SizedBox(height: FintechSpacing.xl.h),
            CardActionsRow(
              controls: controls,
              onFreezeTap: () {
                ref
                    .read(cardsUiProvider.notifier)
                    .toggleFreeze(selectedCard.id);
              },
              onRevealTap: () {
                ref
                    .read(cardsUiProvider.notifier)
                    .toggleReveal(selectedCard.id);
              },
              onSecureTap: () {
                showSuccessToast(message: 'Secure card controls coming soon');
              },
            ),
            SizedBox(height: FintechSpacing.xxl.h),
            CardSettingsSection(
              controls: controls,
              onChangePin: (value) {
                ref
                    .read(cardsUiProvider.notifier)
                    .toggleChangePin(selectedCard.id, value);
              },
              onQrPayment: (value) {
                ref
                    .read(cardsUiProvider.notifier)
                    .toggleQrPayment(selectedCard.id, value);
              },
              onOnlineShopping: (value) {
                ref
                    .read(cardsUiProvider.notifier)
                    .toggleOnlineShopping(selectedCard.id, value);
              },
              onTapPay: (value) {
                ref
                    .read(cardsUiProvider.notifier)
                    .toggleTapPay(selectedCard.id, value);
              },
              onTransactionsTap: () {
                context.pushNamed(
                  AppRouter.cardTransactionScreen,
                  arguments: selectedCard,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _refreshCards(WidgetRef ref) async {
    try {
      final _ = await ref.refresh(fintechDashboardStreamProvider.future);
    } catch (_) {}
  }
}

class _VariantChip extends StatelessWidget {
  const _VariantChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      onTap: onTap,
      child: AnimatedContainer(
        duration: FintechDurations.press,
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected
              ? FintechColors.surface(context)
              : FintechColors.mutedSurface(context),
          borderRadius: BorderRadius.circular(FintechRadius.pill.r),
          border: isSelected
              ? Border.all(color: AppColors.fintechBlue)
              : Border.all(color: Colors.transparent),
        ),
        child: AppText(
          text: label,
          style: AppTextStyle.bodySmall.copyWith(
            color: isSelected
                ? FintechColors.textPrimary(context)
                : FintechColors.textSecondary(context),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
