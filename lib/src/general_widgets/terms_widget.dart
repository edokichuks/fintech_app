// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:fintech_app/src/core/extensions/theme_extensions.dart';
import '../core/utils/app_colors.dart';

class TermsWidget extends StatelessWidget {
  const TermsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Read through our ",
          style: context.textTheme.s14w500.copyWith(
            color: AppColors.neutral300,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            "Terms of service",
            style: context.textTheme.s14w500.copyWith(
              color: AppColors.primary300,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
