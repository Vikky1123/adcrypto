class WithdrawCryptoCheckModel {
  final Message message;
  final Data data;

  WithdrawCryptoCheckModel({
    required this.message,
    required this.data,
  });

  factory WithdrawCryptoCheckModel.fromJson(Map<String, dynamic> json) => WithdrawCryptoCheckModel(
    message: Message.fromJson(json["message"]),
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final String walletAddress;
  final String rate;
  final String code;

  Data({
    required this.walletAddress,
    required this.rate,
    required this.code,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    walletAddress: json["wallet_address"],
    rate: json["rate"],
    code: json["code"],
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