part of 'constants.dart';

class AppImages {
  AppImages._internal();

  static final AppImages _instance = AppImages._internal();

  factory AppImages() {
    return _instance;
  }

  static const String oneCask = 'assets/images/one_cask.png';
  //background image
  static const String background = 'assets/images/background.png';
  // bolte
  static const String bolte = 'assets/images/bolte.png';
  // genuine-icon
  static const String genuineIcon = 'assets/images/genuine-icon.png';
}
