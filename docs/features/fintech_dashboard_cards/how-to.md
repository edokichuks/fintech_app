# How-To: Fintech Dashboard and Cards

> **Type:** How-to Guides — task-oriented.

## How to change the mock update cadence

1. Open `lib/src/application/repositories/fintech/fintech_dashboard_repository.dart`.
2. Update `MockFintechDashboardService.updateInterval`.
3. Keep the initial load delay and error simulation aligned with the assessment requirements unless the feature contract changes.

## How to change the default theme policy

1. Open `lib/src/core/utils/theme/theme_notifier/theme_notifier_state.dart`.
2. Change the initial `themeMode`.
3. If you want system-following behavior, update the default to `ThemeMode.system`.
4. Keep `AppTheme.lightTheme` and `AppTheme.darkTheme` in sync so both themes remain production-ready.

## How to add a new drawer action

1. Open `lib/src/features/home/views/widgets/fintech_profile_drawer.dart`.
2. Add a new `_DrawerTile` or `_DrawerSwitchTile`.
3. If the action needs navigation, register the route first in `lib/src/core/router/router.dart`.
4. If the action needs persisted or shared UI state, add it to `profileDrawerUiProvider`.

## How to add another card setting toggle

1. Open `lib/src/features/cards/views/notifiers/cards_ui_notifier.dart`.
2. Add the field to `FintechCardControlState`.
3. Add the notifier method that mutates that field for a card id.
4. Render the corresponding tile in `lib/src/features/cards/views/widgets/card_settings_section.dart`.
5. Add unit coverage for the notifier and widget coverage for the screen state.

## How to modify the shared dashboard snapshot

1. Open `lib/src/application/model/fintech_dashboard_snapshot.dart`.
2. Add the field to the model and its `copyWith`, `toJson`, and `fromJson`.
3. Update `FintechDashboardSnapshot.mock()` so tests and mock flows still produce complete data.
4. Update any affected widgets and tests that consume the snapshot.
