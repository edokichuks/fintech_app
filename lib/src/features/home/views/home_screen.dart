// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:fintech_app/src/application/model/fintech_dashboard_snapshot.dart';
import 'package:fintech_app/src/application/repositories/fintech/fintech_dashboard_repository.dart';
import 'package:fintech_app/src/core/utils/app_utils_exports.dart';
import 'package:fintech_app/src/features/home/domain/notifiers/dashboard_ui_notifier.dart';
import 'package:fintech_app/src/features/home/domain/notifiers/profile_drawer_ui_notifier.dart';
import 'package:fintech_app/src/features/home/views/widgets/balance_overview_card.dart';
import 'package:fintech_app/src/features/home/views/widgets/dashboard_error_view.dart';
import 'package:fintech_app/src/features/home/views/widgets/dashboard_header.dart';
import 'package:fintech_app/src/features/home/views/widgets/dashboard_loading_view.dart';
import 'package:fintech_app/src/features/home/views/widgets/fintech_profile_drawer.dart';
import 'package:fintech_app/src/features/home/views/widgets/quick_actions_panel.dart';
import 'package:fintech_app/src/features/home/views/widgets/transaction_history_section.dart';
import 'package:fintech_app/src/general_widgets/general_widget_exports.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(fintechDashboardStreamProvider);
    final drawerState = ref.watch(profileDrawerUiProvider);

    return dashboardAsync.when(
      loading: DashboardLoadingView.new,
      error: (error, _) => DashboardErrorView(
        message: error.toString(),
        onRetry: () => ref.invalidate(fintechDashboardStreamProvider),
      ),
      data: (snapshot) =>
          _DashboardContent(snapshot: snapshot, drawerOpen: drawerState.isOpen),
    );
  }
}

class _DashboardContent extends ConsumerWidget {
  const _DashboardContent({required this.snapshot, required this.drawerOpen});

  final FintechDashboardSnapshot snapshot;
  final bool drawerOpen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardUiState = ref.watch(dashboardUiProvider);
    final filteredTransactions = snapshot.transactions
        .where(
          (transaction) =>
              transaction.filter == dashboardUiState.selectedFilter,
        )
        .toList();
    final visibleTransactions = filteredTransactions.isEmpty
        ? snapshot.transactions.take(4).toList()
        : filteredTransactions;

    return AppScaffold(
      applySafeArea: false,
      padding: EdgeInsets.zero,
      backgroundColor: FintechColors.scaffold(context),
      body: Stack(
        children: <Widget>[
          AnimatedSlide(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,
            offset: drawerOpen ? const Offset(0.14, 0) : Offset.zero,
            child: AnimatedScale(
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeOutCubic,
              scale: drawerOpen ? 0.96 : 1,
              alignment: Alignment.centerLeft,
              child: RefreshIndicator(
                color: AppColors.fintechBlue,
                backgroundColor: FintechColors.surface(context),
                onRefresh: () => _refreshDashboard(ref),
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: DashboardHeader(
                        title: 'Welcome ${snapshot.user.fullName}',
                        unreadNotifications: snapshot.user.unreadNotifications,
                        onMenuTap: () {
                          ref
                              .read(profileDrawerUiProvider.notifier)
                              .toggleDrawer();
                        },
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 24.h),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(<Widget>[
                          FintechStaggeredReveal(
                            child: BalanceOverviewCard(
                              balance: snapshot.totalBalance,
                            ),
                          ),
                          SizedBox(height: FintechSpacing.xxl.h),
                          FintechStaggeredReveal(
                            delay: FintechDurations.stagger,
                            child: QuickActionsPanel(
                              actions: snapshot.quickActions,
                            ),
                          ),
                          SizedBox(height: FintechSpacing.xxl.h),
                          FintechStaggeredReveal(
                            delay: FintechDurations.stagger * 2,
                            child: TransactionHistorySection(
                              transactions: visibleTransactions,
                              selectedFilter: dashboardUiState.selectedFilter,
                              onFilterChanged: (filter) {
                                ref
                                    .read(dashboardUiProvider.notifier)
                                    .setSelectedFilter(filter);
                              },
                            ),
                          ),
                          SizedBox(height: 28.h),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          IgnorePointer(
            ignoring: !drawerOpen,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 240),
              opacity: drawerOpen ? 1 : 0,
              child: GestureDetector(
                onTap: () => ref.read(profileDrawerUiProvider.notifier).close(),
                child: Container(color: FintechColors.scrim(context)),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,
            left: drawerOpen ? 0 : -300.w,
            top: 0,
            bottom: 0,
            child: FintechProfileDrawer(user: snapshot.user),
          ),
        ],
      ),
    );
  }

  Future<void> _refreshDashboard(WidgetRef ref) async {
    ref.read(profileDrawerUiProvider.notifier).close();
    try {
      final _ = await ref.refresh(fintechDashboardStreamProvider.future);
    } catch (_) {}
  }
}
