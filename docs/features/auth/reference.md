# Reference: Auth Feature

> **Type:** Reference — information-oriented. A quick-lookup index of everything in the auth feature.

---

## Screens & Widgets

| File | Class | Description |
|---|---|---|
| `views/create_account_screen.dart` | `CreateAccountScreen` | Root `PageView` host for all registration steps |
| `views/steps/user_details_step.dart` | `UserDetailsStep` | Step 1 — name, email, phone |
| `views/steps/verify_account_step.dart` | `VerifyAccountStep` | Step 2 — OTP verification |
| `views/steps/work_details_step.dart` | `WorkDetailsStep` | Step 3 — employer, job title, income |
| `views/steps/open_banking_step.dart` | `OpenBankingStep` | Step 4 — bank account connection |

---

## Route

```dart
AppRouter.createAccount   // '/createAccount'
```

Navigation into the screen:
```dart
context.pushNamed(AppRouter.createAccount);
// or, after logout, clear the stack:
context.replaceAll(AppRouter.createAccount);
```

---

## Notifier & State

| Item | Location |
|---|---|
| Notifier | `lib/src/application/notifiers/auth_notifier.dart` |
| State class | `lib/src/application/notifiers/auth_notifier.dart` |
| Provider | `authProvider` (file scope in notifier file) |

---

## Key AppColors Used

| Purpose | Token |
|---|---|
| Primary button | `AppColors.primary300` |
| Background | `AppColors.light` / `AppColors.dark` |
| Error text | `AppColors.error` |

---

## Form Validators Used

All fields use `Validators` from `lib/src/core/helpers/app_validations.dart`:

| Field | Validator |
|---|---|
| Email | `Validators.email` |
| Phone | `Validators.phone` |
| OTP | `Validators.otp` |
| Income | `Validators.required` |
