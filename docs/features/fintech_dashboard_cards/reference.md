# Reference: Fintech Dashboard and Cards

> **Type:** Reference — information-oriented.

## Routes

- `AppRouter.cardsScreen`
- `AppRouter.cardTransactionScreen`
- `AppRouter.bottomNavBar`

## Screens

- `lib/src/features/home/views/home_screen.dart`
- `lib/src/features/cards/views/cards_screen.dart`
- `lib/src/features/cards/views/card_transaction_screen.dart`

## Feature Widgets

- Home
  - `dashboard_header.dart`
  - `balance_overview_card.dart`
  - `quick_actions_panel.dart`
  - `transaction_history_section.dart`
  - `fintech_profile_drawer.dart`
- Cards
  - `card_actions_row.dart`
  - `card_settings_section.dart`
  - `spend_chart_card.dart`
  - `cards_loading_view.dart`
  - `cards_error_view.dart`

## Shared Models

- `FintechDashboardSnapshot`
- `FintechUserSummary`
- `FintechBankCard`
- `FintechSpendPoint`
- `FintechTransactionRecord`
- `FintechQuickAction`

## Providers and State

- `fintechDashboardStreamProvider`
- `mockFintechDashboardServiceProvider`
- `fintechDashboardRepositoryProvider`
- `dashboardUiProvider`
- `profileDrawerUiProvider`
- `cardsUiProvider`

## Shared Reusable Widgets

- `FintechCardView`
- `FintechTransactionRow`
- `AnimatedCurrencyText`
- `FintechErrorView`
- `FintechShimmer`
- `FintechStaggeredReveal`
- `PressableScale`

## Theme and Tokens

- `AppColors`
- `FintechColors`
- `FintechSpacing`
- `FintechRadius`
- `AppTextStyle`
- `AppTheme`

## Dependencies Introduced for the Feature

- `lucide_icons_flutter`
- `fl_chart`
- `cross_file`

## Tests

- `test/unit/application/model/fintech_dashboard_snapshot_test.dart`
- `test/unit/application/repositories/fintech/fintech_dashboard_repository_test.dart`
- `test/unit/core/theme/app_theme_test.dart`
- `test/unit/features/home/views/notifiers/dashboard_ui_notifier_test.dart`
- `test/unit/features/home/views/notifiers/profile_drawer_ui_notifier_test.dart`
- `test/unit/features/cards/views/notifiers/cards_ui_notifier_test.dart`
- `test/widget/features/home/views/home_screen_test.dart`
- `test/widget/features/home/views/widgets/fintech_profile_drawer_test.dart`
- `test/widget/features/cards/views/cards_flow_test.dart`
