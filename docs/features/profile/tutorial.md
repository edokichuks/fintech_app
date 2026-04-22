# Tutorial: Updating User Profile

> **Type:** Tutorial — learning-oriented.

## What You Will Learn
By the end of this tutorial, you will understand:
- How the `ProfileScreen` fetches and displays user data.
- How the edit flow works and updates the backend.
- How Riverpod state is refreshed after a successful update.

## Prerequisites
- User is logged in and has an active session.
- App is navigated to the profile tab.

## Step 1 — Viewing the Profile
When the `ProfileScreen` loads, it watches the `profileNotifierProvider`. This triggers an API call yielding a `User` model, which is displayed at the top of the screen (avatar, name, email).

## Step 2 — Entering Edit Mode
Tap the "Edit" button. This navigates to the `EditProfileScreen`, passing the current `User` object as an argument so the text fields can be pre-filled.

## Step 3 — Saving Changes
Change the name or phone number and tap "Save". 
The screen calls `ref.read(profileNotifierProvider.notifier).updateProfile(newData)`. 
A loading overlay is shown. Once the API returns a success response, the screen pops back and the previous screen automatically rebuilds with the new data.

## What to Do Next
- See [How-To](how-to.md) for adding new profile fields.
- Check the [Reference](reference.md) for the exact API endpoints used.
