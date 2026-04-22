// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsAnimationsGen {
  const $AssetsAnimationsGen();

  /// File path: assets/animations/.gitkeep
  String get aGitkeep => 'assets/animations/.gitkeep';

  /// File path: assets/animations/success_animation.json
  String get successAnimation => 'assets/animations/success_animation.json';

  /// List of all assets
  List<String> get values => [aGitkeep, successAnimation];
}

class $AssetsAudioGen {
  const $AssetsAudioGen();

  /// File path: assets/audio/.gitkeep
  String get aGitkeep => 'assets/audio/.gitkeep';

  /// List of all assets
  List<String> get values => [aGitkeep];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/.gitkeep
  String get aGitkeep => 'assets/images/.gitkeep';

  /// Directory path: assets/images/png
  $AssetsImagesPngGen get png => const $AssetsImagesPngGen();

  /// Directory path: assets/images/svg
  $AssetsImagesSvgGen get svg => const $AssetsImagesSvgGen();

  /// List of all assets
  List<String> get values => [aGitkeep];
}

class $AssetsJsonGen {
  const $AssetsJsonGen();

  /// File path: assets/json/nigerian_banks.json
  String get nigerianBanks => 'assets/json/nigerian_banks.json';

  /// List of all assets
  List<String> get values => [nigerianBanks];
}

class $AssetsImagesPngGen {
  const $AssetsImagesPngGen();

  /// File path: assets/images/png/.gitkeep
  String get aGitkeep => 'assets/images/png/.gitkeep';

  /// File path: assets/images/png/home_background.png
  AssetGenImage get homeBackground =>
      const AssetGenImage('assets/images/png/home_background.png');

  /// File path: assets/images/png/profileimg.png
  AssetGenImage get profileimg =>
      const AssetGenImage('assets/images/png/profileimg.png');

  /// List of all assets
  List<dynamic> get values => [aGitkeep, homeBackground, profileimg];
}

class $AssetsImagesSvgGen {
  const $AssetsImagesSvgGen();

  /// File path: assets/images/svg/.gitkeep
  String get aGitkeep => 'assets/images/svg/.gitkeep';

  /// File path: assets/images/svg/bankingFee.svg
  String get bankingFee => 'assets/images/svg/bankingFee.svg';

  /// File path: assets/images/svg/barcode.svg
  String get barcode => 'assets/images/svg/barcode.svg';

  /// File path: assets/images/svg/billsPay.svg
  String get billsPay => 'assets/images/svg/billsPay.svg';

  /// File path: assets/images/svg/card_active.svg
  String get cardActive => 'assets/images/svg/card_active.svg';

  /// File path: assets/images/svg/card_inactive.svg
  String get cardInactive => 'assets/images/svg/card_inactive.svg';

  /// File path: assets/images/svg/delete.svg
  String get delete => 'assets/images/svg/delete.svg';

  /// File path: assets/images/svg/deposit.svg
  String get deposit => 'assets/images/svg/deposit.svg';

  /// File path: assets/images/svg/discard.svg
  String get discard => 'assets/images/svg/discard.svg';

  /// File path: assets/images/svg/dishistory.svg
  String get dishistory => 'assets/images/svg/dishistory.svg';

  /// File path: assets/images/svg/dishome.svg
  String get dishome => 'assets/images/svg/dishome.svg';

  /// File path: assets/images/svg/disprofile.svg
  String get disprofile => 'assets/images/svg/disprofile.svg';

  /// File path: assets/images/svg/donations.svg
  String get donations => 'assets/images/svg/donations.svg';

  /// File path: assets/images/svg/eWallet.svg
  String get eWallet => 'assets/images/svg/eWallet.svg';

  /// File path: assets/images/svg/encard.svg
  String get encard => 'assets/images/svg/encard.svg';

  /// File path: assets/images/svg/hint_icon.svg
  String get hintIcon => 'assets/images/svg/hint_icon.svg';

  /// File path: assets/images/svg/history_active.svg
  String get historyActive => 'assets/images/svg/history_active.svg';

  /// File path: assets/images/svg/history_inactive.svg
  String get historyInactive => 'assets/images/svg/history_inactive.svg';

  /// File path: assets/images/svg/home_active.svg
  String get homeActive => 'assets/images/svg/home_active.svg';

  /// File path: assets/images/svg/home_inactive.svg
  String get homeInactive => 'assets/images/svg/home_inactive.svg';

  /// File path: assets/images/svg/master.svg
  String get master => 'assets/images/svg/master.svg';

  /// File path: assets/images/svg/more.svg
  String get more => 'assets/images/svg/more.svg';

  /// File path: assets/images/svg/onlineShopping.svg
  String get onlineShopping => 'assets/images/svg/onlineShopping.svg';

  /// File path: assets/images/svg/padlock.svg
  String get padlock => 'assets/images/svg/padlock.svg';

  /// File path: assets/images/svg/profile_active.svg
  String get profileActive => 'assets/images/svg/profile_active.svg';

  /// File path: assets/images/svg/profile_inactive.svg
  String get profileInactive => 'assets/images/svg/profile_inactive.svg';

  /// File path: assets/images/svg/secure.svg
  String get secure => 'assets/images/svg/secure.svg';

  /// List of all assets
  List<String> get values => [
    aGitkeep,
    bankingFee,
    barcode,
    billsPay,
    cardActive,
    cardInactive,
    delete,
    deposit,
    discard,
    dishistory,
    dishome,
    disprofile,
    donations,
    eWallet,
    encard,
    hintIcon,
    historyActive,
    historyInactive,
    homeActive,
    homeInactive,
    master,
    more,
    onlineShopping,
    padlock,
    profileActive,
    profileInactive,
    secure,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsAnimationsGen animations = $AssetsAnimationsGen();
  static const $AssetsAudioGen audio = $AssetsAudioGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsJsonGen json = $AssetsJsonGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
