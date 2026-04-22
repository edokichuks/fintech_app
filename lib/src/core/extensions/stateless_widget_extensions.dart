// Flutter imports:
import 'package:flutter/cupertino.dart';

extension StatefulExtension on StatelessWidget {
  Widget addTapGesture({required VoidCallback onTap, bool isEnabled = true}) {
    return GestureDetector(
      onTap: isEnabled ? onTap : () {},
      child: this,
    );
  }

  Widget addSizedBox({double? width, double? height}) {
    return SizedBox(
      width: width,
      height: height,
      child: this,
    );
  }
}
