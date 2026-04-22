# Explanation: Auth Feature Design

> **Type:** Explanation — understanding-oriented. Explains *why* auth is built the way it is.

---

## Why a `PageView` Instead of Separate Screens?

The registration flow is a single **linear, stateful journey**. Using a `PageView` inside one `CreateAccountScreen` rather than pushing individual named routes gives us:

- **Shared state** across steps without passing data through route arguments.
- **Animated transitions** between steps that feel like a single experience, not page navigations.
- **A single back-button handler** — pressing back moves to the previous step, never out of the flow.
- **Easier progress tracking** — the `AuthFlowHeader` reads the `PageController`'s page index directly.

The trade-off is that deep-linking into a specific step is harder — acceptable here since registration must always be completed in order.

---

## Why Are Steps Separate Widget Files?

Each step (`UserDetailsStep`, `VerifyAccountStep`, etc.) is extracted into its own file for:

- **Testability** — each step can be widget-tested in isolation with a mock `onContinue` callback.
- **Readability** — `CreateAccountScreen` stays thin and orchestration-focused.
- **Independent change** — a designer can update `WorkDetailsStep` without touching the other steps.

---

## Why `context.replaceAll` After Auth Completes?

After a user registers or logs in, the entire back stack is cleared so the user cannot press "back" and land on the auth flow from within the app. This matches standard mobile auth UX expectations and prevents users from accidentally being logged out by navigating back.

---

## Why OTP for Verification?

OTP over email was chosen (vs. phone SMS) because:
1. The app already collects a verified email at Step 1.
2. It avoids SMS provider costs and rate limits during development.
3. The pattern is easily swapped for SMS by changing the API endpoint — the UI layer remains unchanged.
