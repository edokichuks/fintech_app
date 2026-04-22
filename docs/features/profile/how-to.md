# How-To: Profile Feature

> **Type:** How-to Guides — task-oriented.

## How to add a new profile field (e.g., date of birth)

1. **Update the Model**
   Add `final DateTime? dateOfBirth;` to `User` in `lib/src/domain/models/user.dart`. Run `build_runner` to update the generated JSON mapping.

2. **Update the UI (View Mode)**
   In `ProfileScreen`, add a new `ProfileDetailRow` beneath the existing fields:
   ```dart
   ProfileDetailRow(
     icon: Icons.cake,
     label: 'Date of Birth',
     value: user.dateOfBirth?.toIso8601String() ?? 'Not set',
   )
   ```

3. **Update the Edit Screen**
   In `EditProfileScreen`, add a new `AppDatePickerField` for the date of birth, mapped to the `_dobController`.

4. **Update the Payload**
   In `ProfileNotifier.updateProfile()`, ensure the `UpdateUserRequest` includes the new `dateOfBirth` field.
