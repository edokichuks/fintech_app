// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import 'package:clean_flutter/src/core/utils/app_utils_exports.dart';

class AppCircularProgressIndicator extends StatefulWidget {
  const AppCircularProgressIndicator({
    super.key,
    this.color,
    this.size = 35,
  });
  final Color? color;
  final double size;

  @override
  State<AppCircularProgressIndicator> createState() =>
      AppCircularProgressIndicatorState();
}

class AppCircularProgressIndicatorState
    extends State<AppCircularProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        color: widget.color ?? AppColors.neutral50,
        animating: true,
      ),
    );
  }
}
