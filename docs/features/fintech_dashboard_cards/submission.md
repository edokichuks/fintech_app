# Submission Notes: Fintech Dashboard and Cards

> **Type:** Submission evidence — reviewer-oriented.

## Required Delivery Items

- Public repository: push this project to a public GitHub repository and submit that repository URL.
- README setup instructions: included in `README.md`.
- Implementation notes: included in `README.md` and the feature docs in this directory.
- Emulator/simulator recordings: included in `docs/features/fintech_dashboard_cards/media/`.
- Dark and light screenshot sets: included in `docs/features/fintech_dashboard_cards/images/`.

## Demo Videos

- Android emulator: `docs/features/fintech_dashboard_cards/media/android-emulator-demo.mp4`
- iOS simulator: `docs/features/fintech_dashboard_cards/media/ios-simulator-demo.mp4`

The videos walk through the dashboard, transaction filters, profile drawer, notification toggle, card overview, freeze/reveal controls, virtual card tab, card settings, transaction detail, spend range toggle, and transaction-history section.

## Screenshots

- Dark mode screenshots: `docs/features/fintech_dashboard_cards/images/dark/`
- Light mode screenshots: `docs/features/fintech_dashboard_cards/images/light/`

Each set includes more than five screenshots covering dashboard, drawer, cards, revealed card state, settings, and transaction detail.

## Device Notes

- Android recording was captured from the connected Android emulator.
- iOS recording was captured from an iPhone 16 Pro simulator.
- The wireless `chuks iPhone` device was detected by Flutter, but command-line screen video capture is available for iOS simulators in this environment, not for wireless physical-device capture.

## Reproducibility

The deterministic media flow lives in `integration_test/fintech_demo_flow_test.dart`. It overrides random mock errors and drives the UI through the same states used in the README evidence.
