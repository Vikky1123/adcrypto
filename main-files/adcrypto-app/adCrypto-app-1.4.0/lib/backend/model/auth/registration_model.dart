class RegistrationModel {
  final Message message;
  final Data data;

  RegistrationModel({
    required this.message,
    required this.data,
  });

  factory RegistrationModel.fromJson(Map<String, dynamic> json) => RegistrationModel(
    message: Message.fromJson(json["message"]),
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final bool emailVerification;
  final bool kycVerification;
  final String token;

  Data({
    required this.emailVerification,
    required this.kycVerification,
    required this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    emailVerification: json["email_verification"],
    kycVerification: json["kyc_verification"],
    token: json["token"],
  );
}

class Message {
  final List<String> success;

  Message({
    required this.success,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    success: List<String>.from(json["success"].map((x) => x)),
  );
}