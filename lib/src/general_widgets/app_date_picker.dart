// Flutter imports:
import 'package:clean_flutter/src/core/helpers/helper_functions.dart';
import 'package:clean_flutter/src/core/utils/app_utils_exports.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:

Future<String?> showAppDatePicker({
  required BuildContext context,
  String? dateFormat,
}) async {
  DateTime initialDate = DateTime(2006, 10, 21);
  final currentDate = DateTime.now();
  //THE USER CAN'T BE LESS THAN 18 YEARS OLD
  final DateTime minOfEighteenYearsOld = DateTime(
    currentDate.year - 18,
    currentDate.month,
    currentDate.day,
  );
  String formattedDate = '';
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime.utc(1900),
    lastDate: minOfEighteenYearsOld,
    builder: (context, child) {
      final theme = Theme.of(context);
      final isDarkMode = theme.brightness == Brightness.dark;
      return Theme(
        data: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(primary: AppColors.primary50),
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(isDarkMode
                ? AppColors.defaultBackgroundLight
                : AppColors.defaultBackgroundDark),
          )),
          textTheme: TextTheme(
            headlineSmall: AppTextStyle.headlineLarge.copyWith(fontSize: 20.sp),
            titleLarge: AppTextStyle.headlineLarge.copyWith(fontSize: 18.sp),
            bodyLarge: AppTextStyle.bodyLarge.copyWith(fontSize: 16.sp),
          ),
        ),
        child: child!,
      );
    },
  );

  if (pickedDate != null) {
    formattedDate = HelperFunctions.formatDate(
            dateTime: pickedDate, dateFormat: dateFormat) ??
        '';
    return formattedDate;
  }
  return null;
}

Future<String?> showAppTimePicker({
  required BuildContext context,
}) async {
  final TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (context, child) {
      final theme = Theme.of(context);
      final isDarkMode = theme.brightness == Brightness.dark;
      return Theme(
        data: theme.copyWith(
          colorScheme:
              theme.colorScheme.copyWith(primary: AppColors.primary300),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              foregroundColor: WidgetStatePropertyAll(isDarkMode
                  ? AppColors.defaultBackgroundLight
                  : AppColors.primary100),
            ),
          ),
          textTheme: TextTheme(
            headlineSmall: AppTextStyle.headlineLarge.copyWith(fontSize: 20.sp),
            titleLarge: AppTextStyle.headlineLarge.copyWith(fontSize: 18.sp),
            bodyLarge: AppTextStyle.bodyLarge.copyWith(fontSize: 16.sp),
          ),
          timePickerTheme: TimePickerThemeData(
            backgroundColor: theme.scaffoldBackgroundColor,
            hourMinuteTextColor: theme.colorScheme.onSurface,
            dayPeriodTextColor: theme.colorScheme.onSurface,
            dayPeriodColor: AppColors.primary100,
            hourMinuteColor: AppColors.primary100,
          ),
        ),
        child: child!,
      );
    },
    // Force the picker to open in input mode (digital)
    initialEntryMode: TimePickerEntryMode.input,
  );

  if (pickedTime != null) {
    // Get current date and combine with picked time
    final now = DateTime.now();
    final selectedDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    // Return ISO 8601 format for backend
    return selectedDateTime.toUtc().toIso8601String();
  }

  return null;
}
