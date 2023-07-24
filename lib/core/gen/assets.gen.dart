/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsFontGen {
  const $AssetsFontGen();

  /// File path: assets/font/Roboto-Black.ttf
  String get robotoBlack => 'assets/font/Roboto-Black.ttf';

  /// File path: assets/font/Roboto-Bold.ttf
  String get robotoBold => 'assets/font/Roboto-Bold.ttf';

  /// File path: assets/font/Roboto-Light.ttf
  String get robotoLight => 'assets/font/Roboto-Light.ttf';

  /// File path: assets/font/Roboto-Medium.ttf
  String get robotoMedium => 'assets/font/Roboto-Medium.ttf';

  /// File path: assets/font/Roboto-Regular.ttf
  String get robotoRegular => 'assets/font/Roboto-Regular.ttf';

  /// List of all assets
  List<String> get values =>
      [robotoBlack, robotoBold, robotoLight, robotoMedium, robotoRegular];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/avatar1.png
  AssetGenImage get avatar1 => const AssetGenImage('assets/icons/avatar1.png');

  /// File path: assets/icons/avatar2.png
  AssetGenImage get avatar2 => const AssetGenImage('assets/icons/avatar2.png');

  /// File path: assets/icons/avatar3.png
  AssetGenImage get avatar3 => const AssetGenImage('assets/icons/avatar3.png');

  /// File path: assets/icons/avatar4.png
  AssetGenImage get avatar4 => const AssetGenImage('assets/icons/avatar4.png');

  /// List of all assets
  List<AssetGenImage> get values => [avatar1, avatar2, avatar3, avatar4];
}

class Assets {
  Assets._();

  static const $AssetsFontGen font = $AssetsFontGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

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
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
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

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
