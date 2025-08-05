/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsClipartGen {
  const $AssetsClipartGen();

  /// File path: assets/clipart/confirm.png
  AssetGenImage get confirm =>
      const AssetGenImage('assets/clipart/confirm.png');

  /// File path: assets/clipart/confirmation.svg
  String get confirmation => 'assets/clipart/confirmation.svg';

  /// File path: assets/clipart/sample_profile.png
  AssetGenImage get sampleProfile =>
      const AssetGenImage('assets/clipart/sample_profile.png');

  /// List of all assets
  List<dynamic> get values => [confirm, confirmation, sampleProfile];
}

class $AssetsIconGen {
  const $AssetsIconGen();

  /// File path: assets/icon/about_us.svg
  String get aboutUs => 'assets/icon/about_us.svg';

  /// File path: assets/icon/arrow.svg
  String get arrow => 'assets/icon/arrow.svg';

  /// File path: assets/icon/bangladesh_flag.png
  AssetGenImage get bangladeshFlag =>
      const AssetGenImage('assets/icon/bangladesh_flag.png');

  /// File path: assets/icon/buy_log.svg
  String get buyLog => 'assets/icon/buy_log.svg';

  /// File path: assets/icon/camera.svg
  String get camera => 'assets/icon/camera.svg';

  /// File path: assets/icon/canada_flag.png
  AssetGenImage get canadaFlag =>
      const AssetGenImage('assets/icon/canada_flag.png');

  /// File path: assets/icon/document_upload.svg
  String get documentUpload => 'assets/icon/document_upload.svg';

  /// File path: assets/icon/drawer.svg
  String get drawer => 'assets/icon/drawer.svg';

  /// File path: assets/icon/exchange_log.svg
  String get exchangeLog => 'assets/icon/exchange_log.svg';

  /// File path: assets/icon/help_center.svg
  String get helpCenter => 'assets/icon/help_center.svg';

  /// File path: assets/icon/icon_paste.png
  AssetGenImage get iconPastePng =>
      const AssetGenImage('assets/icon/icon_paste.png');

  /// File path: assets/icon/icon_paste.svg
  String get iconPasteSvg => 'assets/icon/icon_paste.svg';

  /// File path: assets/icon/logo_bitcoin.png
  AssetGenImage get logoBitcoin =>
      const AssetGenImage('assets/icon/logo_bitcoin.png');

  /// File path: assets/icon/logo_dogecoin.png
  AssetGenImage get logoDogecoin =>
      const AssetGenImage('assets/icon/logo_dogecoin.png');

  /// File path: assets/icon/logo_ethriam.png
  AssetGenImage get logoEthriam =>
      const AssetGenImage('assets/icon/logo_ethriam.png');

  /// File path: assets/icon/logo_tether.png
  AssetGenImage get logoTether =>
      const AssetGenImage('assets/icon/logo_tether.png');

  /// File path: assets/icon/notification.svg
  String get notification => 'assets/icon/notification.svg';

  /// File path: assets/icon/privacy_and_policy.svg
  String get privacyAndPolicy => 'assets/icon/privacy_and_policy.svg';

  /// File path: assets/icon/profile.svg
  String get profile => 'assets/icon/profile.svg';

  /// File path: assets/icon/receipt.svg
  String get receipt => 'assets/icon/receipt.svg';

  /// File path: assets/icon/sample.png
  AssetGenImage get sample => const AssetGenImage('assets/icon/sample.png');

  /// File path: assets/icon/sell_log.svg
  String get sellLog => 'assets/icon/sell_log.svg';

  /// File path: assets/icon/settings.svg
  String get settings => 'assets/icon/settings.svg';

  /// File path: assets/icon/sign_out.svg
  String get signOut => 'assets/icon/sign_out.svg';

  /// File path: assets/icon/tick_mark.svg
  String get tickMark => 'assets/icon/tick_mark.svg';

  /// File path: assets/icon/unitedKingdom_flag.png
  AssetGenImage get unitedKingdomFlag =>
      const AssetGenImage('assets/icon/unitedKingdom_flag.png');

  /// File path: assets/icon/unitedState_flag.png
  AssetGenImage get unitedStateFlag =>
      const AssetGenImage('assets/icon/unitedState_flag.png');

  /// File path: assets/icon/withdraw_log.svg
  String get withdrawLog => 'assets/icon/withdraw_log.svg';

  /// List of all assets
  List<dynamic> get values => [
        aboutUs,
        arrow,
        bangladeshFlag,
        buyLog,
        camera,
        canadaFlag,
        documentUpload,
        drawer,
        exchangeLog,
        helpCenter,
        iconPastePng,
        iconPasteSvg,
        logoBitcoin,
        logoDogecoin,
        logoEthriam,
        logoTether,
        notification,
        privacyAndPolicy,
        profile,
        receipt,
        sample,
        sellLog,
        settings,
        signOut,
        tickMark,
        unitedKingdomFlag,
        unitedStateFlag,
        withdrawLog
      ];
}

class $AssetsLogoGen {
  const $AssetsLogoGen();

  /// File path: assets/logo/app_launcher.png
  AssetGenImage get appLauncher =>
      const AssetGenImage('assets/logo/app_launcher.png');

  /// File path: assets/logo/basic_icon.png
  AssetGenImage get basicIcon =>
      const AssetGenImage('assets/logo/basic_icon.png');

  /// File path: assets/logo/ios_laucnher.png
  AssetGenImage get iosLaucnher =>
      const AssetGenImage('assets/logo/ios_laucnher.png');

  /// List of all assets
  List<AssetGenImage> get values => [appLauncher, basicIcon, iosLaucnher];
}

class Assets {
  Assets._();

  static const $AssetsClipartGen clipart = $AssetsClipartGen();
  static const $AssetsIconGen icon = $AssetsIconGen();
  static const $AssetsLogoGen logo = $AssetsLogoGen();
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
