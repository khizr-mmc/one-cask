part of 'models.dart';

class UserAuthentication extends Equatable {
  final User? user;
  final String? token;
  final String? refreshToken;

  const UserAuthentication({
    this.user,
    this.token,
    this.refreshToken,
  });

  static const empty = UserAuthentication(token: "");

  bool get isEmpty => this == UserAuthentication.empty;

  bool get isNotEmpty => this != UserAuthentication.empty;

  factory UserAuthentication.fromJson(Map<String, dynamic> json) =>
      UserAuthentication(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        token: json["access_token"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "access_token": token,
        "refresh_token": refreshToken,
      };

  UserAuthentication copyWith({
    User? user,
    String? token,
    String? refreshToken,
  }) {
    return UserAuthentication(
      user: user ?? this.user,
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  @override
  List<Object?> get props => [user, token, refreshToken];
}

class User {
  final int pk;
  final String fullName;
  final String email;
  final String phone;
  final String role;
  final String accountType;
  final Address? address;
  final bool? notificationAllowed;
  final bool isActive;
  final DateTime created;

  User({
    required this.pk,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.role,
    required this.accountType,
    required this.address,
    required this.notificationAllowed,
    required this.isActive,
    required this.created,
  });

  User copyWith({
    int? pk,
    String? fullName,
    String? email,
    String? phone,
    String? role,
    String? accountType,
    Address? address,
    bool? notificationAllowed,
    bool? isActive,
    DateTime? created,
  }) =>
      User(
        pk: pk ?? this.pk,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        role: role ?? this.role,
        accountType: accountType ?? this.accountType,
        address: address ?? this.address,
        notificationAllowed: notificationAllowed ?? this.notificationAllowed,
        isActive: isActive ?? this.isActive,
        created: created ?? this.created,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        pk: json["pk"],
        fullName: json["full_name"],
        email: json["email"],
        phone: json["phone"],
        role: json["role"],
        accountType: json["account_type"],
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        notificationAllowed: json["notification_allow"],
        isActive: json["is_active"],
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "pk": pk,
        "full_name": fullName,
        "email": email,
        "phone": phone,
        "role": role,
        "account_type": accountType,
        "address": address?.toJson(),
        "notification_allow": notificationAllowed,
        "is_active": isActive,
        "created": created.toIso8601String(),
      };

  List<Object?> get props => [
        pk,
        fullName,
        email,
        phone,
        role,
        accountType,
        address,
        isActive,
        created,
      ];
}

class Address {
  final String? address;
  final String? city;
  final String? country;
  final num? latitude;
  final num? longitude;
  final dynamic region;

  Address({
    this.address,
    this.city,
    this.country,
    this.latitude,
    this.longitude,
    this.region,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        address: json["address"],
        city: json["city"],
        country: json["country"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        region: json["region"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "city": city,
        "country": country,
        "latitude": latitude,
        "longitude": longitude,
        "region": region,
      };
}
