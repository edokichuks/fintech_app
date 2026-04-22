// ignore_for_file: use_key_in_widget_constructors

// Flutter imports:
import 'package:flutter/material.dart';

class Spacing extends StatelessWidget {
  final double height;
  final double width;

  const Spacing.height(this.height) : width = 0;

//HEIGHT FROM EXTRA SMALL TO EXTRA LARGE FROM DESIGN
  const Spacing.heightXXS() : this.height(2);
  const Spacing.heightXS() : this.height(4);
  const Spacing.heightS() : this.height(8);
  const Spacing.heightM() : this.height(16);
  const Spacing.heightL() : this.height(32);
  const Spacing.heightXL() : this.height(64);
  const Spacing.heightXXL() : this.height(128);
  const Spacing.heightXXXL() : this.height(258);

  const Spacing.width(this.width) : height = 0;

  const Spacing.widthXXS() : this.width(2);
  const Spacing.widthXS() : this.width(4);
  const Spacing.widthS() : this.width(8);
  const Spacing.widthM() : this.width(16);
  const Spacing.widthL() : this.width(32);
  const Spacing.widthXL() : this.width(64);
  const Spacing.widthXXL() : this.width(128);
  const Spacing.widthXXXL() : this.width(258);
  const Spacing.empty()
      : width = 0,
        height = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height, width: width);
  }
}
