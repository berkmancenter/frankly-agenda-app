class AppAsset {
  static const AppAsset background = AppAsset('media/bg_image.png');

  // Logo images
  static const AppAsset kLogoIconPng = AppAsset('media/logo-icon.png');
  static const AppAsset kLogoPng = AppAsset('media/logo.png');
  static const AppAsset kLogoSvg = AppAsset('media/logo.svg');

  final String path;
  final bool isSvg;

  @Deprecated('Use dedicated constructor')
  const AppAsset(this.path) : isSvg = false;
}
