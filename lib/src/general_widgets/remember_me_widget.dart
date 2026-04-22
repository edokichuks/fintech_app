// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:clean_flutter/src/application/repositories/user/user_repository_impl.dart';
import 'package:clean_flutter/src/core/extensions/theme_extensions.dart';
import 'package:clean_flutter/src/core/utils/app_colors.dart';

class RememberMeWidget extends ConsumerWidget {
  const RememberMeWidget({
    super.key,
    required this.onCheck,
    required this.onForgotPasswordTapped,
  });
  final ValueChanged<bool> onCheck;
  final VoidCallback onForgotPasswordTapped;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            AppCheckBox(
              onCheck: onCheck,
              initialValue: ref.read(userRepositoryProvider).getRememberMe(),
            ),
            const SizedBox(width: 8.59),
            Text(
              'Keep me in',
              style: context.textTheme.s16w400
                  .copyWith(color: AppColors.neutral200),
            ),
          ],
        ),
        InkWell(
          onTap: onForgotPasswordTapped,
          child: Text('Forget Passsword?',
              style: context.textTheme.s16w400
                  .copyWith(color: AppColors.primary300)),
        ),
      ],
    );
  }
}

class AppCheckBox extends StatefulWidget {
  const AppCheckBox(
      {super.key,
      required this.onCheck,
      this.checkBoxColor = const Color(0XFF929292), //AppColors.neutral200,
      this.initialValue});
  final ValueChanged<bool> onCheck;
  final Color checkBoxColor;
  final bool? initialValue;

  @override
  State<AppCheckBox> createState() => _AssetizeCheckBoxState();
}

class _AssetizeCheckBoxState extends State<AppCheckBox> {
  late bool _checked;

  @override
  void initState() {
    super.initState();
    _checked = widget.initialValue ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20.w,
      height: 10.h,
      child: Checkbox(
        activeColor: AppColors.primary300,
        side: BorderSide(
          color: widget.checkBoxColor,
        ),
        value: _checked,
        onChanged: (value) {
          setState(() {
            _checked = value!;
          });
          widget.onCheck.call(_checked);
        },
      ),
    );
  }
}
