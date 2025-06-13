part of 'theme.dart';

class AppIcons {
  AppIcons._internal();

  static final AppIcons _instance = AppIcons._internal();

  factory AppIcons() {
    return _instance;
  }

  IconData get close => Icons.close_rounded;
  IconData get imageError => Icons.image_not_supported_rounded;
  IconData get circle => Icons.circle_rounded;
  IconData get backArrow => Icons.arrow_back;
  IconData get message => Icons.message_rounded;
  IconData get reviews => Icons.reviews;
  IconData get location => Icons.location_on;
  IconData get calendar => Icons.calendar_month;
  IconData get money => Icons.monetization_on;
  IconData get moneyFlag => Icons.monetization_on;
  IconData get check => Icons.check_circle_rounded;
  IconData get formatQuote => Icons.format_quote;
  IconData get star => Icons.star_rounded;
  //visiblity
  IconData get visibility => Icons.visibility_rounded;
  IconData get visibilityOff => Icons.visibility_off_rounded;
  //scan
  IconData get scan => Icons.qr_code_scanner_rounded;
  //collection
  IconData get collection => Icons.grid_view;
  //shop
  IconData get shop => Icons.liquor;
  //settings
  IconData get settings => Icons.settings_rounded;
  // notification
  IconData get notification => Icons.notifications_none_rounded;
  // add
  IconData get add => Icons.add;
  // radio
  IconData get radio => Icons.radio_button_checked_rounded;
  // keyboardArrowDown
  IconData get keyboardArrowDown => Icons.keyboard_arrow_down;
  // attech file
  IconData get attachFile => Icons.attach_file;
}
