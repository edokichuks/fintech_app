# Explanation: Why the Fintech Feature Is Structured This Way

> **Type:** Explanation — understanding-oriented.

## Why use one shared fintech snapshot?

The dashboard, cards tab, card-transaction detail, and drawer header all render from the same simulated financial state. A shared `FintechDashboardSnapshot` keeps those surfaces coherent during live updates and avoids duplicating mock generation logic across features.


## Why split UI state away from the stream state?

The live snapshot answers data questions such as balance, cards, and transactions. Screen interaction state answers different questions such as:

- which history filter is selected
- whether the drawer is open
- which card index is active
- which local card controls are toggled

Keeping those concerns in separate notifiers avoids rebuilding or mutating the mocked data model for simple UI interactions.

## Why keep the reusable card widget generic?

The same card visual appears in the cards tab and the transaction-detail view. A shared `FintechCardView` keeps the visual consistent while centralizing the reveal/freeze presentation logic and later responsive fixes.

## Why support both system light and dark mode?

The app follows the platform theme setting so reviewers can inspect both dark and light appearances without changing product code. The screenshots are dark-first, but light-theme tokens and responsive fixes were implemented so the feature is not locked into one appearance policy. Switching to another launch policy later is a notifier decision, not a redesign.

## Why keep a deterministic demo flow?

The README media is generated from a small integration flow that walks through the same feature states every time. This avoids manually tapping through screens during recording and keeps the videos, screenshots, and implementation notes aligned with the actual app behavior.
