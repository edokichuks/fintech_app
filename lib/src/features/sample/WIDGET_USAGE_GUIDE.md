# General Widgets Usage Guide

This guide demonstrates how to use the reusable widgets in the `general_widgets` folder.

## Text Widgets

### AppText
Basic text widget with consistent styling:
```dart
AppText(
  text: 'Hello World',
  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  textAlign: TextAlign.center,
)
```

### AppCurrencyAndText
For displaying currency amounts:
```dart
AppCurrencyAndText(
  amount: '1,500.00',
  currencySymbol: '₦',
  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
)
```

## Containers

### AppContainer
Themed container with consistent styling:
```dart
AppContainer(
  height: 100,
  width: 200,
  color: AppColors.primary300.withOpacity(0.1),
  borderRadius: BorderRadius.circular(12),
  child: AppText(text: 'Content'),
)
```

## Buttons

### AppButton
Primary action button with loading states:
```dart
AppButton(
  text: 'Submit',
  onPressed: () => handleSubmit(),
  buttonStyle: AppButtonStyle.primary(),
  isLoading: isSubmitting,
  isEnabled: formIsValid,
)
```

## Input Fields

### AppTextField
Standard text input field:
```dart
AppTextField(
  controller: textController,
  label: 'Email Address',
  hintText: 'Enter your email',
  textInputAction: TextInputAction.next,
)
```

### AppPasswordField
Password input with visibility toggle:
```dart
AppPasswordField(
  label: 'Password',
  hintText: 'Enter password',
  onChanged: (value) => validatePassword(value),
)
```

## Selection Widgets

### AppDropdown
Dropdown selection widget:
```dart
AppDropdown<String>(
  label: 'Country',
  hintText: 'Select country',
  items: ['Nigeria', 'Ghana', 'Kenya'],
  initialValue: selectedCountry,
  onChanged: (value) => setState(() => selectedCountry = value),
)
```

### AppRadio
Radio button for single selection:
```dart
AppRadio<String>(
  value: 'option1',
  groupValue: selectedOption,
  onRadioChanged: (value) => setState(() => selectedOption = value),
)
```

### AppSwitch
Toggle switch widget:
```dart
AppSwitch(
  value: isEnabled,
  onChanged: (value) => setState(() => isEnabled = value),
)
```

## Feedback Widgets

### AppLoader
Loading indicator:
```dart
AppLoader(size: 40) // Default animated loader
```

### Toast Messages
Show success or error messages:
```dart
// Success toast
showSuccessToast(message: 'Operation completed successfully!');

// Error toast
showErrorToast(message: 'Something went wrong!');
```

### AppDialog
Modal dialog with actions:
```dart
showAppDialogue(
  context: context,
  title: 'Confirm Action',
  subtitle: 'Are you sure you want to proceed?',
  actions: [
    AppButton(
      text: 'Cancel',
      onPressed: () => Navigator.pop(context),
      buttonStyle: AppButtonStyle.secondary(),
    ),
    AppButton(
      text: 'Confirm',
      onPressed: () => handleConfirm(),
      buttonStyle: AppButtonStyle.primary(),
    ),
  ],
);
```

## Layout Helpers

### Spacing
Consistent spacing throughout the app:
```dart
Column(
  children: [
    Widget1(),
    Spacing.height(16), // Vertical spacing
    Row(
      children: [
        Widget2(),
        Spacing.width(12), // Horizontal spacing
        Widget3(),
      ],
    ),
  ],
)
```

## Complete Example

See `widget_samples_screen.dart` for a comprehensive example showing all widgets in action.

## Best Practices

1. **Consistent Styling**: Use the provided widgets instead of native Flutter widgets for consistent theming
2. **State Management**: Handle loading and error states appropriately
3. **Accessibility**: Widgets include built-in accessibility features
4. **Responsive Design**: All widgets use ScreenUtil for responsive sizing
5. **Theme Support**: Widgets automatically adapt to light/dark themes