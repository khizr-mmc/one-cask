import 'dart:async';
import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cache/cache.dart';
import 'package:flutter/foundation.dart';
import 'package:general_repository/general_repository.dart';

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthenticationRepository {
  /// {@macro authentication_repository}
  AuthenticationRepository(
    this.generalRepository, {
    CacheClient? cache,
  }) : _cache = cache ?? CacheClient();

  final GeneralRepository generalRepository;
  final CacheClient _cache;

  /// User cache key.
  /// Should only be used for testing purposes.
  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  @visibleForTesting
  final StreamController<UserAuthentication> userAuth =
      StreamController<UserAuthentication>();

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
  Stream<UserAuthentication> get user async* {
    var userJson = _cache.read<String>(key: userCacheKey);
    yield userJson == null
        ? UserAuthentication.empty
        : UserAuthentication.fromJson(jsonDecode(userJson));
    yield* userAuth.stream.map((user) {
      _cache.write<String>(
        key: userCacheKey,
        value: jsonEncode(user.toJson()),
      );
      return user;
    });
  }

  /// Returns the current cached user.
  /// Defaults to [User.empty] if there is no cached user.
  UserAuthentication get currentUser {
    var userJson = _cache.read<String>(key: userCacheKey);
    return userJson == null
        ? UserAuthentication.empty
        : UserAuthentication.fromJson(jsonDecode(userJson));
  }

  /// Starts the Sign In Flow.
  Future<void> login(String email, String password, String fcmToken) async {
    String encodedBody = jsonEncode(
      {
        "account_type": "Email",
        "email": email,
        "password": password,
        "fcm": fcmToken,
      },
    );

    var responseJson = await generalRepository.post(
      handle: AuthenticationEndpoints.login,
      body: encodedBody,
    );

    userAuth.add(UserAuthentication.fromJson(responseJson["data"]));
  }

  Future<void> employeeLogin(
      String email, String password, String fcmToken) async {
    String encodedBody = jsonEncode({
      "account_type": "Email",
      "email": email,
      "password": password,
      "fcm": fcmToken,
    });

    var responseJson = await generalRepository.post(
      handle: AuthenticationEndpoints.employeeLogin,
      body: encodedBody,
    );

    userAuth.add(UserAuthentication.fromJson(responseJson["data"]));
  }

  void updateTokens(String accessToken, String refreshToken) async {
    var updatedUserAuth = currentUser.copyWith(
      token: accessToken,
      refreshToken: refreshToken,
    );

    userAuth.add(updatedUserAuth);
  }

  Future<void> register(String fullname, String email, String phone,
      String password, String fcmToken) async {
    String encodedBody = jsonEncode({
      "account_type": "Email",
      "fullname": fullname,
      "email": email,
      "password": password,
      "phone": phone,
      "fcm": fcmToken,
    });

    var responseJson = await generalRepository.post(
      handle: AuthenticationEndpoints.register,
      body: encodedBody,
    );

    userAuth.add(UserAuthentication.fromJson(responseJson["data"]));
  }

  // add Location
  Future<void> addLocation(String address, String city, String country,
      double latitude, double longitude, String region) async {
    String encodedBody = jsonEncode({
      "key": "location",
      "address": address,
      "country": country,
      "city": city,
      "latitude": latitude,
      "longitude": longitude,
      "region": region,
    });

    await generalRepository
        .post(
      handle: AuthenticationEndpoints.metaData,
      body: encodedBody,
    )
        .then((_) {
      var updatedUserAuth = currentUser.copyWith(
        user: currentUser.user?.copyWith(
          address: Address(
            address: address,
            city: city,
            country: country,
            latitude: latitude,
            longitude: longitude,
            region: region,
          ),
        ),
      );

      userAuth.add(UserAuthentication.empty);
      userAuth.add(updatedUserAuth);
    });
  }

  Future<void> updateProfileInfo(
      String? userName, String? email, String? phone) async {
    Map<String, String> fields = {
      "key": "profile",
    };
    if (userName != null && userName != currentUser.user?.fullName) {
      fields["username"] = userName;
    }
    if (email != null && email != currentUser.user?.email) {
      fields["email"] = email;
    }
    if (phone != null && phone != currentUser.user?.phone) {
      fields["phone"] = phone;
    }

    String encodedBody = jsonEncode(fields);

    var responseJson = await generalRepository.patch(
      handle: AuthenticationEndpoints.updateProfile,
      body: encodedBody,
    );

    var updatedUserAuth = currentUser.copyWith(
      user: currentUser.user?.copyWith(
        fullName: userName,
        email: email,
        phone: phone,
      ),
      token: responseJson["data"]["access_token"] ?? currentUser.token,
      refreshToken:
          responseJson["data"]["refresh_token"] ?? currentUser.refreshToken,
    );

    userAuth.add(UserAuthentication.empty);
    userAuth.add(updatedUserAuth);
  }

  // Update Location
  Future<void> updateLocation(String address, String city, String country,
      double latitude, double longitude, String region) async {
    String encodedBody = jsonEncode({
      "key": "address",
      "address": address,
      "country": country,
      "city": city,
      "latitude": latitude,
      "longitude": longitude,
      "region": region,
    });

    await generalRepository
        .patch(
      handle: AuthenticationEndpoints.updateProfile,
      body: encodedBody,
    )
        .then((_) {
      var updatedUserAuth = currentUser.copyWith(
        user: currentUser.user?.copyWith(
          address: Address(
            address: address,
            city: city,
            country: country,
            latitude: latitude,
            longitude: longitude,
            region: region,
          ),
        ),
      );

      userAuth.add(UserAuthentication.empty);
      userAuth.add(updatedUserAuth);
    });
  }

  Future<void> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    String encodedBody = jsonEncode({
      "key": "password",
      "current_password": currentPassword,
      "new_password": newPassword,
    });

    await generalRepository.patch(
      handle: AuthenticationEndpoints.updateProfile,
      body: encodedBody,
    );
  }

  Future<void> forgotPasswordEmailSent(String email) async {
    String encodedBody = jsonEncode({
      "email": email,
    });

    await generalRepository.patch(
      handle: AuthenticationEndpoints.forgotPassword,
      body: encodedBody,
    );
  }

  Future<void> forgotPasswordOtpVerify(String email, int otp) async {
    String encodedBody = jsonEncode({"email": email, "otp": otp});

    await generalRepository.patch(
      handle: AuthenticationEndpoints.verifyOtp,
      body: encodedBody,
    );
  }

  Future<void> forgotPassword(String email, String password) async {
    String encodedBody = jsonEncode({
      "email": email,
      "password": password,
    });

    await generalRepository.patch(
      handle: AuthenticationEndpoints.resetPassword,
      body: encodedBody,
    );
  }

  //employee toggle push notification
  Future<void> employeeTogglePushNotification(
      bool isPushNotificationEnabled) async {
    String encodedBody = jsonEncode({
      "notification": isPushNotificationEnabled,
    });

    await generalRepository
        .put(
      handle: AuthenticationEndpoints.employeePushNotification,
      body: encodedBody,
    )
        .then((_) {
      var updatedUserAuth = currentUser.copyWith(
        user: currentUser.user?.copyWith(
          notificationAllowed: isPushNotificationEnabled,
        ),
      );

      userAuth.add(UserAuthentication.empty);
      userAuth.add(updatedUserAuth);
    });
  }

  //user toggle push notification
  Future<void> userTogglePushNotification(
      bool isPushNotificationEnabled) async {
    String encodedBody = jsonEncode({
      "key": "notification",
      "set": isPushNotificationEnabled,
    });

    await generalRepository
        .patch(
      handle: AuthenticationEndpoints.userPushNotification,
      body: encodedBody,
    )
        .then((_) {
      var updatedUserAuth = currentUser.copyWith(
        user: currentUser.user?.copyWith(
          notificationAllowed: isPushNotificationEnabled,
        ),
      );

      userAuth.add(UserAuthentication.empty);
      userAuth.add(updatedUserAuth);
    });
  }

  // user delete account
  Future<void> userDeleteAccount() async {
    await generalRepository
        .delete(
      handle: AuthenticationEndpoints.userDeleteAccount,
    )
        .then((_) {
      userAuth.add(UserAuthentication.empty);
    });
  }

  
   /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  void logout() {
    generalRepository.post(
      handle: AuthenticationEndpoints.logout,
    );

    userAuth.add(UserAuthentication.empty);
  }

  void clearUser() {
    userAuth.add(UserAuthentication.empty);
  }

  /// disposes the userAuth stream
  void dispose() => userAuth.close();
}
