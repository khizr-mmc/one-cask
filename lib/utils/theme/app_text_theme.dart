part of 'theme.dart';

class AppTextTheme {
  AppTextTheme._internal({
    this.latoFontFamily = "Lato",
    this.ebGaramondFontFamily = "EBGaramond",
  }) : _latoBaseTextStyle = TextStyle(
         fontFamily: latoFontFamily,
         fontWeight: AppFontWeight.medium,
         height: 1.2,
       ),
       _ebGaramondBaseTextStyle = TextStyle(
         fontFamily: ebGaramondFontFamily,
         fontWeight: AppFontWeight.medium,
         height: 1.2,
       );

  static final AppTextTheme _instance = AppTextTheme._internal();

  factory AppTextTheme() {
    return _instance;
  }

  final String latoFontFamily;
  final String ebGaramondFontFamily;
  final TextStyle _latoBaseTextStyle;
  final TextStyle _ebGaramondBaseTextStyle;

  // Lato styles
  TextStyle get latoHeadingText => _latoBaseTextStyle.copyWith(
    fontSize: 24,
    fontWeight: AppFontWeight.extraBold,
  );

  TextStyle get latoSubHeadingText =>
      _latoBaseTextStyle.copyWith(fontSize: 18, fontWeight: AppFontWeight.bold);

  TextStyle get latoBodyText => _latoBaseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: AppFontWeight.medium,
  );


  // Lato body large
  TextStyle get latoBodyLargeText => _latoBaseTextStyle.copyWith(
    fontSize: 16,
    fontWeight: AppFontWeight.regular,
  );

  // Lato body small
  TextStyle get latoBodySmallText => _latoBaseTextStyle.copyWith(
    fontSize: 12,
    fontWeight: AppFontWeight.regular,
  );

  TextStyle get latoLightText => _latoBaseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: AppFontWeight.regular,
  );

  // EB Garamond Heading Large
  TextStyle get ebGaramondHeadingLargeText => _ebGaramondBaseTextStyle.copyWith(
    fontSize: 32,
    fontWeight: AppFontWeight.medium,
  );

  // EB Garamond button Large
  TextStyle get ebGaramondButtonLargeText => _ebGaramondBaseTextStyle.copyWith(
    fontSize: 16,
    fontWeight: AppFontWeight.semiBold,
  );

  // title Large
  TextStyle get ebGaramondTitleLargeText => _ebGaramondBaseTextStyle.copyWith(
    fontSize: 22,
    fontWeight: AppFontWeight.medium,
  );

  // EB Garamond styles
  TextStyle get ebGaramondHeadingText => _ebGaramondBaseTextStyle.copyWith(
    fontSize: 24,
    fontWeight: AppFontWeight.extraBold,
  );

  TextStyle get ebGaramondSubHeadingText => _ebGaramondBaseTextStyle.copyWith(
    fontSize: 18,
    fontWeight: AppFontWeight.bold,
  );

  TextStyle get ebGaramondBodyText => _ebGaramondBaseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: AppFontWeight.medium,
  );

  TextStyle get ebGaramondLightText => _ebGaramondBaseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: AppFontWeight.regular,
  );

  // Add this getter for ThemeData compatibility
  String get fontFamily => latoFontFamily;
}
