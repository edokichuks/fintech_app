# Tutorial: Walking Through the Auth Flow

> **Type:** Tutorial — learning-oriented. Follow these steps end-to-end to understand how the auth flow works as a whole.

---

## What You Will Learn

By the end of this tutorial you will understand:
- How `CreateAccountScreen` orchestrates the multi-step registration flow via a `PageView`.
- What each of the four steps does and what data it collects.
- How the form state flows from the user into the notifier and eventually to the API.

---

## Prerequisites

- The app is running (`flutter run`).
- You are on the `CreateAccountScreen` (reachable from the splash/login screen).

---

## Step 1 — User Details

The first page collects the user's **name, email, and phone number**.

Fill in all fields and tap **Continue**. The `UserDetailsStep` validates using `Validators` class — the Continue button stays disabled until all fields pass.

---

## Step 2 — Verify Account

An OTP is sent to the email entered in Step 1. Enter the **6-digit code** in the pin field.

Tap **Verify** — the notifier calls `verifyOtp()`. On success the `PageView` advances to Step 3.

---

## Step 3 — Work Details

Fill in your **employer name, job title, and monthly income**. These are required for the credit assessment.

Tap **Continue** to advance.

---

## Step 4 — Open Banking

The final step connects your bank account. Tap **Connect Bank** to launch the in-app WebView for the open banking provider.

On successful connection, the screen navigates to the home screen via `context.replaceAll(AppRouter.home)`.

---

## What to Do Next

- Read the [How-to Guide](how-to.md) to learn how to add a new step to this flow.
- Read the [Reference](reference.md) for the full list of screen classes, models, and route constants.
- Read the [Explanation](explanation.md) for the reasoning behind the `PageView` + step design.
