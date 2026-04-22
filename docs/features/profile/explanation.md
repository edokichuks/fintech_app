# Explanation: Profile Feature

> **Type:** Explanation — understanding-oriented.

## Why did we split View and Edit into two screens?
Initially, inline editing was considered to reduce navigation. However, profile updates require validation and API calls that can fail. By isolating the edit form in a dedicated `EditProfileScreen`, we guarantee that the main `ProfileScreen` only ever renders validated, confirmed data from the server. It also simplifies the state logic in the UI.

## Why use AsyncValue for the profile state?
The profile data is fetched remotely and can experience loading or error states. Riverpod's `AsyncValue` forces the UI to explicitly handle `loading` and `error` states, preventing accidental null-reference crashes when attempting to render a profile that hasn't loaded yet.
