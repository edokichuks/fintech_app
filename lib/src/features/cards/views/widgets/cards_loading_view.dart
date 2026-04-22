// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:fintech_app/src/core/utils/app_utils_exports.dart';
import 'package:fintech_app/src/general_widgets/general_widget_exports.dart';

class CardsLoadingView extends StatelessWidget {
  const CardsLoadingView({super.key});

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
            const FintechShimmerBox(height: 28, width: 160),
            SizedBox(height: FintechSpacing.xs.h),
            const FintechShimmerBox(height: 18, width: 180),
            SizedBox(height: FintechSpacing.xl.h),
            const FintechShimmerBox(height: 36, width: 220, radius: 18),
            SizedBox(height: FintechSpacing.xl.h),
            FintechShimmerBox(height: 200.h, radius: FintechRadius.card.r),
            SizedBox(height: FintechSpacing.xl.h),
            const FintechShimmerBox(height: 80, radius: 20),
            SizedBox(height: FintechSpacing.xl.h),
            const FintechShimmerBox(height: 26, width: 150),
            SizedBox(height: FintechSpacing.md.h),
            ...List<Widget>.generate(
              5,
              (_) => Padding(
                padding: EdgeInsets.only(bottom: FintechSpacing.md.h),
                child: FintechShimmerBox(height: 66.h, radius: 18.r),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
