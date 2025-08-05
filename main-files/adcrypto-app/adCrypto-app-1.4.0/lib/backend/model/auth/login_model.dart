class LoginModel {
  final Data data;

  LoginModel({
    required this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final bool emailVerification;
  final bool kycVerification;
  final UserData userData;

  Data({
    required this.emailVerification,
    required this.kycVerification,
    required this.userData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    emailVerification: json["email_verification"],
    kycVerification: json["kyc_verification"],
    userData: UserData.fromJson(json["user_data"]),
  );
}

class UserData {
  final String token;
  final User user;

  UserData({
    required this.token,
    required this.user,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    token: json["token"],
    user: User.fromJson(json["user"]),
  );
}

class User {
  final int emailVerified;
  final int smsVerified;
  final int kycVerified;
  final int twoFactorStatus;

  User({
    required this.emailVerified,
    required this.smsVerified,
    required this.kycVerified,
    required this.twoFactorStatus,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    emailVerified: json["email_verified"],
    smsVerified: json["sms_verified"],
    kycVerified: json["kyc_verified"],
    twoFactorStatus: json["two_factor_status"],
  );
}