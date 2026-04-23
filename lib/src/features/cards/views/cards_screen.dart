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
  @override
  Widget build(BuildContext context) {
    final dashboardAsync = ref.watch(fintechDashboardStreamProvider);

    return dashboardAsync.when(
      loading: CardsLoadingView.new,
      error: (error, _) => CardsErrorView(
        message: error.toString(),
        onRetry: () => ref.invalidate(fintechDashboardStreamProvider),
      ),
      data: (snapshot) => _CardsBody(snapshot: snapshot),
    );
  }
}

class _CardsBody extends ConsumerStatefulWidget {
  const _CardsBody({required this.snapshot});

  final FintechDashboardSnapshot snapshot;
  static const int _defaultVisibleIndex = 1;

  @override
  ConsumerState<_CardsBody> createState() => _CardsBodyState();
}

class _CardsBodyState extends ConsumerState<_CardsBody> {
  PageController? _carouselController;
  double? _carouselViewportFraction;

  @override
  void dispose() {
    _carouselController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cardsUiState = ref.watch(cardsUiProvider);
    final snapshot = widget.snapshot;
    final filteredCards = snapshot.cards
        .where((card) => card.variant == cardsUiState.selectedVariant)
        .toList();
    final cards = _cardsForCarousel(
      filteredCards.isEmpty ? snapshot.cards : filteredCards,
    );
    final activeIndex = cardsUiState.activeCardIndex >= cards.length
        ? (cards.length > 1 ? _CardsBody._defaultVisibleIndex : 0)
        : cardsUiState.activeCardIndex;
    final selectedCard = cards[activeIndex];
    final controls = cardsUiState.controlFor(selectedCard.id);
    final itemExtent = FintechCardView.cardWidth.w;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final carouselHeight = FintechCardView.cardHeight.h + 16.h;

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
                    ref
                        .read(cardsUiProvider.notifier)
                        .setActiveCardIndex(_CardsBody._defaultVisibleIndex);
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
                    ref
                        .read(cardsUiProvider.notifier)
                        .setActiveCardIndex(_CardsBody._defaultVisibleIndex);
                  },
                ),
              ],
            ),
            SizedBox(height: FintechSpacing.xl.h),
            SizedBox(
              height: carouselHeight,
              child: OverflowBox(
                minWidth: screenWidth,
                maxWidth: screenWidth,
                alignment: Alignment.center,
                child: SizedBox(
                  width: screenWidth,
                  height: carouselHeight,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final viewportFraction =
                          (itemExtent / constraints.maxWidth).clamp(0.01, 1.0);
                      final carouselController = _resolveCarouselController(
                        activeIndex: activeIndex,
                        viewportFraction: viewportFraction,
                      );
                      _syncCarouselController(carouselController, activeIndex);

                      return PageView.builder(
                        controller: carouselController,
                        clipBehavior: Clip.none,
                        itemCount: cards.length,
                        onPageChanged: (index) {
                          ref
                              .read(cardsUiProvider.notifier)
                              .setActiveCardIndex(index);
                        },
                        itemBuilder: (context, index) {
                          final card = cards[index];
                          final cardControls = cardsUiState.controlFor(card.id);
                          final isSelected = index == activeIndex;

                          return FintechStaggeredReveal(
                            delay: Duration(milliseconds: index * 100),
                            offset: const Offset(0, 0.2),
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                if (index == activeIndex) {
                                  return;
                                }

                                carouselController.animateToPage(
                                  index,
                                  duration: const Duration(milliseconds: 240),
                                  curve: Curves.easeOutCubic,
                                );
                              },
                              child: Center(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: AnimatedScale(
                                    duration: const Duration(milliseconds: 220),
                                    curve: Curves.easeOutCubic,
                                    scale: isSelected ? 1 : 0.95,
                                    child: AnimatedOpacity(
                                      duration: const Duration(
                                        milliseconds: 220,
                                      ),
                                      curve: Curves.easeOutCubic,
                                      opacity: isSelected ? 1 : 0.8,
                                      child: FintechCardView(
                                        card: card,
                                        isFrozen: cardControls.isFrozen,
                                        isRevealed: cardControls.isRevealed,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: FintechSpacing.xs.h),
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

  List<FintechBankCard> _cardsForCarousel(List<FintechBankCard> source) {
    if (source.isEmpty) {
      return widget.snapshot.cards.take(3).toList(growable: false);
    }

    if (source.length >= 3) {
      return source.take(3).toList(growable: false);
    }

    final cards = List<FintechBankCard>.from(source);
    var loopIndex = 0;

    while (cards.length < 3) {
      cards.add(source[loopIndex % source.length]);
      loopIndex++;
    }

    return cards;
  }

  PageController _resolveCarouselController({
    required int activeIndex,
    required double viewportFraction,
  }) {
    if (_carouselController != null &&
        _carouselViewportFraction == viewportFraction) {
      return _carouselController!;
    }

    _carouselController?.dispose();
    _carouselViewportFraction = viewportFraction;
    _carouselController = PageController(
      initialPage: activeIndex,
      viewportFraction: viewportFraction,
    );

    return _carouselController!;
  }

  void _syncCarouselController(PageController controller, int activeIndex) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !controller.hasClients) {
        return;
      }

      final page = controller.page;
      if (page != null && (page - page.round()).abs() > 0.01) {
        return;
      }

      final currentPage = page?.round() ?? controller.initialPage;
      if (currentPage != activeIndex) {
        controller.jumpToPage(activeIndex);
      }
    });
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
