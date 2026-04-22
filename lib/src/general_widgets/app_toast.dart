// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Project imports:
import 'package:fintech_app/src/core/utils/app_utils_exports.dart';

showSuccessToast({required String message, Color? backgroundColor}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: backgroundColor ?? AppColors.defaultBackgroundDark,
    textColor: AppColors.white,
    fontSize: 16.0.sp,
  );
}

showErrorToast({required String message}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: AppColors.danger200,
    textColor: AppColors.white,
    fontSize: 16.0.sp,
  );
}
