// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:fintech_app/src/core/utils/app_colors.dart';
import 'package:fintech_app/src/core/utils/theme/app_text_styles.dart';
import 'package:fintech_app/src/general_widgets/spacing.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: const Column(
            children: [TodoCard(), Spacing.heightL(), TodoBackgroundCard()],
          ),
        ),
      ),
    );
  }
}

class TodoCard extends StatelessWidget {
  const TodoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 220.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary400.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Background Base Color (Deep Blue)
          Container(
            color: const Color(0xFF1E5BB5), // A strong deep blue base
          ),

          // Mesh Gradient Glowing Orbs
          // Top Left - Light Blue
          Positioned(
            top: -50.h,
            left: -50.w,
            child: Container(
              width: 150.w,
              height: 150.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF5AB6FF).withOpacity(0.8),
              ),
            ),
          ),

          // Bottom Right - Soft Purple
          Positioned(
            bottom: -60.h,
            right: -20.w,
            child: Container(
              width: 180.w,
              height: 180.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF8675FF).withOpacity(0.9),
              ),
            ),
          ),

          // Center Right Glow - White/Cyan
          Positioned(
            top: 20.h,
            right: -30.w,
            child: Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ),

          // Bottom Left - Deep Indigo/Purple
          Positioned(
            bottom: -20.h,
            left: -30.w,
            child: Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF6B4EEA).withOpacity(0.7),
              ),
            ),
          ),

          // Apply Blur to create Mesh Effect
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
              child: Container(color: Colors.transparent),
            ),
          ),

          // Card Content
          Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        "PRIORITY",
                        style: AppTextStyle.labelMedium.copyWith(
                          color: Colors.white,
                          fontSize: 10.sp,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    Icon(Icons.more_horiz, color: Colors.white, size: 24.sp),
                  ],
                ),
                const Spacer(),
                Text(
                  "Complete KYC Verification",
                  style: AppTextStyle.titleLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacing.heightS(),
                Text(
                  "Unlock full account limits and features.",
                  style: AppTextStyle.bodySmall.copyWith(
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                const Spacing.heightM(),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: Colors.white.withOpacity(0.8),
                      size: 16.sp,
                    ),
                    const Spacing.widthS(),
                    Text(
                      "Takes 2 mins",
                      style: AppTextStyle.labelMedium.copyWith(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12.sp,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: const Color(0xFF1E5BB5),
                        size: 14.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TodoBackgroundCard extends StatelessWidget {
  const TodoBackgroundCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 220.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF8B80D8), Color(0xFF4A47A3)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4A47A3).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            top: -60.h,
            right: -40.w,
            child: Container(
              width: 250.w,
              height: 250.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF130E56),
              ),
            ),
          ),
          Positioned(
            bottom: -80.h,
            left: -60.w,
            child: Container(
              width: 240.w,
              height: 240.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF70D4FF), Color(0xFF0073D4)],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -40.h,
            right: 10.w,
            child: Container(
              width: 140.w,
              height: 140.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF70D4FF), Color(0xFF0073D4)],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
