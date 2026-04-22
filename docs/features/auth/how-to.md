# How-To: Auth Feature

> **Type:** How-to Guides — task-oriented. Each guide solves a specific goal.

---

## How to Add a New Step to the Registration Flow

1. **Create the step widget** in `lib/src/features/auth/views/steps/my_new_step.dart`. It must be a `ConsumerWidget` with a `VoidCallback onContinue` parameter.

2. **Add the widget to the `PageView`** in `create_account_screen.dart`:
   ```dart
   PageView(
     controller: _pageController,
     children: [
       UserDetailsStep(onContinue: _nextPage),
       VerifyAccountStep(onContinue: _nextPage),
       MyNewStep(onContinue: _nextPage),   // ← add here
       WorkDetailsStep(onContinue: _nextPage),
       OpenBankingStep(),
     ],
   )
   ```

3. **Update the progress indicator** in `AuthFlowHeader` — increment the `totalSteps` value and verify the current step index displays correctly.

4. **Wire up state** — if the new step collects data, add fields to the auth notifier state and call the appropriate notifier method on submit.

---

## How to Change the OTP Length

In `verify_account_step.dart`, update the `length` parameter on `PinCodeTextField`:
```dart
PinCodeTextField(
  length: 6,   // ← change this
  ...
)
```

Also update the validation in the auth notifier to match the new length.

---

## How to Navigate After Auth Completes

In `open_banking_step.dart`, find the success callback and update the route:
```dart
// ✅ Current
context.replaceAll(AppRouter.home);

// If you need to redirect somewhere else:
context.replaceAll(AppRouter.onboarding);
```

Always use `context.replaceAll` after auth to clear the entire navigation stack.

---

## How to Skip a Step for Existing Users

Pass a `shouldSkip` flag into the `PageView` orchestrator and call `_pageController.nextPage()` programmatically when the screen mounts:

```dart
@override
void initState() {
  super.initState();
  if (widget.shouldSkipVerification) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _nextPage());
  }
}
```
