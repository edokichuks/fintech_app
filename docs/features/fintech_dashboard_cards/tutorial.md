# Tutorial: Exploring the Fintech Dashboard Feature

> **Type:** Tutorial — learning-oriented.

## What You Will Learn

By the end of this tutorial, you will understand:

- How the dashboard home consumes the shared fintech snapshot.
- How the profile drawer is opened and managed.
- How the cards tab and card-transaction detail fit together.

## Prerequisites

- Dependencies are installed with `flutter pub get`.
- The app is launched with `flutter run`.
- The default route opens the bottom navigation shell.

## Step 1 — Open the Dashboard Home

Launch the app. The first tab renders `HomeScreen`, which watches `fintechDashboardStreamProvider`.

The screen shows:

- the welcome header
- the balance overview card
- the quick actions strip
- the filtered transaction history list

## Step 2 — Open the Profile Drawer

Tap the menu icon in the home header.

This updates `profileDrawerUiProvider` and slides the drawer in from the left. The dashboard scales and shifts so the drawer overlays it like the reference design.

From the drawer you can:

- inspect the profile summary
- toggle app notifications
- switch to the cards tab with **Credit Card**

## Step 3 — Move to the Cards Tab

Tap the cards bottom-nav item, or tap **Credit Card** in the drawer.

`CardsScreen` renders:

- the physical/virtual variant selector
- the horizontal card pager
- the card action shortcuts
- the card settings list

## Step 4 — Open Card Transaction Detail

Tap **Card Transactions** from the settings list on the cards tab.

The app navigates through `AppRouter.cardTransactionScreen` and shows:

- the selected card
- the spend chart card
- the card-specific transaction list

## Step 5 — Review the Recorded Evidence

The README includes Android emulator and iOS simulator recordings of this same flow. Dark and light screenshot sets are stored under `docs/features/fintech_dashboard_cards/images/` so reviewers can inspect both theme modes without rerunning the app.

## What to Do Next

- See [How-To](how-to.md) for extending mock data or adjusting theme behavior.
- See [Reference](reference.md) for routes, providers, and core widgets.
