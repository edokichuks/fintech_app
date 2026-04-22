// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:fintech_app/src/core/utils/app_utils_exports.dart';
import 'package:fintech_app/src/general_widgets/general_widget_exports.dart';

class DashboardLoadingView extends StatelessWidget {
  const DashboardLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      applySafeArea: false,
      padding: EdgeInsets.zero,
      backgroundColor: FintechColors.scaffold(context),
      body: FintechShimmer(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(20.w, 60.h, 20.w, 24.h),
          children: <Widget>[
            Row(
              children: <Widget>[
                const FintechShimmerBox(height: 22, width: 28),
                const Spacer(),
                const FintechShimmerBox(height: 18, width: 150),
                const Spacer(),
                FintechShimmerBox(
                  height: 36.h,
                  width: 36.w,
                  radius: 18.r,
                ),
              ],
            ),
            SizedBox(height: FintechSpacing.xl.h),
            FintechShimmerBox(height: 236.h, radius: FintechRadius.card.r),
            SizedBox(height: FintechSpacing.xl.h),
            FintechShimmerBox(height: 100.h, radius: FintechRadius.panel.r),
            SizedBox(height: FintechSpacing.xl.h),
            const FintechShimmerBox(height: 24, width: 220),
            SizedBox(height: FintechSpacing.md.h),
            const FintechShimmerBox(height: 34, width: 260),
            SizedBox(height: FintechSpacing.lg.h),
            ...List<Widget>.generate(
              4,
              (_) => Padding(
                padding: EdgeInsets.only(bottom: FintechSpacing.md.h),
                child: FintechShimmerBox(height: 70.h, radius: 20.r),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
