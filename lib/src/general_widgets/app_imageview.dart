// ignore_for_file: must_be_immutable

// Dart imports:
import 'dart:io';
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class AppImageView extends StatelessWidget {
  ///[url] is required parameter for fetching network image
  String? url;

  ///[imagePath] is required parameter for showing png,jpg,etc image
  String? imagePath;

  ///[lottiePath] is required parameter for showing lotttie Animations
  String? lottiePath;

  ///[svgPath] is required parameter for showing svg image
  String? svgPath;

  ///[file] is required parameter for fetching image file
  File? file;

  double? height;
  double? width;
  Color? color;
  bool? repeatLottieAnimation;
  BoxFit? fit;
  final String placeHolder;
  Alignment? alignment;
  VoidCallback? onTap;
  EdgeInsetsGeometry? margin;
  BorderRadiusGeometry? radius;
  BoxBorder? border;
  Function(DragStartDetails details)? onHorizontalDrag;

  ///a [AppImageView] it can be used for showing any type of images
  /// it will shows the placeholder image if image is not found on network image
  AppImageView({
    super.key,
    this.url,
    this.imagePath,
    this.svgPath,
    this.file,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.alignment,
    this.onTap,
    this.radius,
    this.margin,
    this.border,
    this.placeHolder = 'assets/images/png/image_not_found.png',
    this.onHorizontalDrag,
    this.lottiePath,
    this.repeatLottieAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment!,
            child: _buildWidget(),
          )
        : _buildWidget();
  }

  Widget _buildWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: GestureDetector(
        onTap: onTap,
        child: _buildCircleImage(),
      ),
    );
  }

  ///build the image with border radius
  _buildCircleImage() {
    if (radius != null) {
      return ClipRRect(
        borderRadius: radius ?? BorderRadius.zero,
        child: _buildImageWithBorder(),
      );
    } else {
      return _buildImageWithBorder();
    }
  }

  ///build the image with border and border radius style
  _buildImageWithBorder() {
    if (border != null) {
      return Container(
        decoration: BoxDecoration(
          border: border,
          borderRadius: radius,
        ),
        child: _buildImageView(),
      );
    } else {
      return _buildImageView();
    }
  }

  Widget _buildImageView() {
    if (svgPath != null && svgPath!.isNotEmpty) {
      return SizedBox(
        height: height,
        width: width,
        child: SvgPicture.asset(
          svgPath!,
          height: height,
          width: width,
          fit: fit ?? BoxFit.contain,
          // colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn)
          // ignore: deprecated_member_use
          color: color,
        ),
      );
    } else if (file != null && file!.path.isNotEmpty) {
      return Image.file(
        file!,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        color: color,
      );
    } else if (url != null && url!.isNotEmpty) {
      return ClipRRect(
        borderRadius: radius ?? BorderRadius.zero,
        child: CachedNetworkImage(
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
          imageUrl: url!.replaceAll(" ", '%20'),
          color: color,
          // placeholder: (context, url) => SizedBox(
          //   height: height,
          //   width: width,
          //   child: LinearProgressIndicator(
          //     color: Colors.grey.shade200,
          //     backgroundColor: Colors.grey.shade100,
          //   ),
          // ),

          progressIndicatorBuilder: (context, url, progress) {
            final rand = Random().nextDouble();

            return AnimatedOpacity(
              opacity: rand / 5,
              duration: const Duration(milliseconds: 300),
              child: Image.asset(
                placeHolder,
                height: height,
                width: width,
                fit: fit ?? BoxFit.cover,
              ),
            );
          },
          errorWidget: (context, url, error) => Image.asset(
            placeHolder,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
          ),
        ),
      );
    } else if (imagePath != null && imagePath!.isNotEmpty) {
      return Image.asset(
        imagePath!,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        color: color,
      );
    } else if (lottiePath != null && lottiePath!.isNotEmpty) {
      return Lottie.asset(
        lottiePath!,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        repeat: repeatLottieAnimation,
      );
    }
    return const SizedBox();
  }
}
