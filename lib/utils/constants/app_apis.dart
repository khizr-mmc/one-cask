part of 'constants.dart';

class AppApis {
  AppApis._internal();

  static final AppApis _instance = AppApis._internal();

  factory AppApis() {
    return _instance;
  }

  /// Local
  // static const String baseUrl = "";

  /// Staging
  static const String baseUrl = "";

  static const String baseApiUrl = "$baseUrl/api/";
  static const String login = 'login';
  static const String register = 'register';
  static const String logout = 'logout';

  initBaseUrlAndAuthEndpoints() {
    ApiConfig.baseUrl = baseApiUrl;
    AuthenticationEndpoints.login = login;
    AuthenticationEndpoints.register = register;
    AuthenticationEndpoints.logout = logout;
  }
}
