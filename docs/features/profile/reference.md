# Reference: Profile Feature

> **Type:** Reference — information-oriented.

## Screens & Widgets
- `ProfileScreen` (`lib/src/features/profile/views/profile_screen.dart`): Main viewing screen.
- `EditProfileScreen` (`lib/src/features/profile/views/edit_profile_screen.dart`): Form screen for updates.
- `ProfileDetailRow` (`lib/src/features/profile/views/widgets/profile_detail_row.dart`): Reusable display row.

## Routes
- `AppRouter.profile`
- `AppRouter.editProfile`

## Notifiers & State
- `profileNotifierProvider` (`ProfileNotifier`): Manages fetching and updating profile state.
- State: `AsyncValue<User>`

## Dependencies
- `image_picker`: Used for updating the avatar.
- `cached_network_image`: Used for displaying the user avatar.

## Key AppColors Used
- `AppColors.profileCardBackground`
- `AppColors.avatarBorder`
