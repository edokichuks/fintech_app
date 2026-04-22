// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:clean_flutter/src/core/helpers/helper_functions.dart';
import 'package:clean_flutter/src/core/utils/app_utils_exports.dart';
import 'package:clean_flutter/src/core/utils/theme/app_text_styles.dart';

class AppText extends StatelessWidget {
  const AppText({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.overflow,
    this.padding,
    this.height,
    this.width,
    this.constraints,
  });
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final EdgeInsetsGeometry? padding;
  final double? height, width;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.displaySmall;
    return Container(
      height: height,
      width: width,
      constraints: constraints,
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        text,
        style: style ?? textStyle,
        textAlign: textAlign,
        overflow: overflow,
      ),
    );
  }
}

//THIS WIDGET IS USED IN PLACES WHERE THE NAIRA SYMBOL IS USED
class AppCurrencyAndText extends StatelessWidget {
  final String amount;
  final TextStyle? style;
  final String currencySymbol;
  final TextAlign? textAlign;
  final TextOverflow? overflow;

  const AppCurrencyAndText({
    super.key,
    required this.amount,
    this.style,
    this.currencySymbol = "₦",
    this.textAlign,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: currencySymbol,
            style: (style ?? AppTextStyle.displaySmall).copyWith(
              //THE FONT FAMILY MUST BE INTER, ON ANDROID THE "₦" SYMBOL
              //IS NOT SUPPORTED FOR THE MON SANS FONT
              fontFamily: HelperFunctions.isAndroid()
                  ? 'Inter' // or any system font that supports the Naira symbol
                  : style?.fontFamily,
            ),
          ),
          TextSpan(
            text: amount,
            style: style,
          ),
        ],
      ),
    );
  }
}
