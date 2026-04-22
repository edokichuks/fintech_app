// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static TextStyle _arimo({
    required double fontSize,
    required FontWeight fontWeight,
    required double height,
    double? letterSpacing,
  }) {
    return GoogleFonts.arimo(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  //HEADER on Design
  static final headlineLarge = _arimo(
    fontSize: 40.sp,
    fontWeight: FontWeight.w800,
    height: 1.20,
  );
  //HEADER 1 on Design
  static final headlineSmall = _arimo(
    fontSize: 28.sp,
    fontWeight: FontWeight.w800,
    height: 1.25,
  );
  //HEADER 2 on Design
  static final titleLarge = _arimo(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    height: 1.20,
  );
  //HEADER 3 on Design
  static final bodyLarge = _arimo(
    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
    height: 1.50,
  );
  //HEADER 4 on Design
  static final bodyMedium = _arimo(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    height: 1.50,
  );
  //HEADER 5 on Design
  static final bodySmall = _arimo(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 1.40,
  );
  //HEADER 6 on Design
  static final displaySmall = _arimo(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    height: 1.40,
  );

  //EXTRAS
  static final labelLarge = _arimo(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    height: 1.40,
  );
  static final labelMedium = _arimo(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    height: 1.40,
  );

  static final titleMedium = _arimo(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    height: 1.20,
  );
  static final titleSmall = _arimo(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 1.40,
  );
}
