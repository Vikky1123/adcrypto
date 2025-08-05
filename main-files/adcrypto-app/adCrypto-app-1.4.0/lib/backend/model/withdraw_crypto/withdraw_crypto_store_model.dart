class WithdrawCryptoStoreModel {
  final WithdrawCryptoStoreModelData data;

  WithdrawCryptoStoreModel({
    required this.data,
  });

  factory WithdrawCryptoStoreModel.fromJson(Map<String, dynamic> json) => WithdrawCryptoStoreModel(
    data: WithdrawCryptoStoreModelData.fromJson(json["data"]),
  );
}

class WithdrawCryptoStoreModelData {
  final PurpleData data;

  WithdrawCryptoStoreModelData({
    required this.data,
  });

  factory WithdrawCryptoStoreModelData.fromJson(Map<String, dynamic> json) => WithdrawCryptoStoreModelData(
    data: PurpleData.fromJson(json["data"]),
  );
}

class PurpleData {
  final String type;
  final String identifier;
  final FluffyData data;

  PurpleData({
    required this.type,
    required this.identifier,
    required this.data,
  });

  factory PurpleData.fromJson(Map<String, dynamic> json) => PurpleData(
    type: json["type"],
    identifier: json["identifier"],
    data: FluffyData.fromJson(json["data"]),
  );
}

class FluffyData {
  final SenderWallet senderWallet;
  final ReceiverWallet receiverWallet;
  final double amount;
  final double fixedCharge;
  final double percentCharge;
  final double totalCharge;
  final double senderExRate;
  final double exchangeRate;
  final double payableAmount;
  final double willGet;

  FluffyData({
    required this.senderWallet,
    required this.receiverWallet,
    required this.amount,
    required this.fixedCharge,
    required this.percentCharge,
    required this.totalCharge,
    required this.senderExRate,
    required this.exchangeRate,
    required this.payableAmount,
    required this.willGet,
  });

  factory FluffyData.fromJson(Map<String, dynamic> json) => FluffyData(
    senderWallet: SenderWallet.fromJson(json["sender_wallet"]),
    receiverWallet: ReceiverWallet.fromJson(json["receiver_wallet"]),
    amount: json["amount"].toDouble(),
    fixedCharge: json["fixed_charge"].toDouble(),
    percentCharge: json["percent_charge"].toDouble(),
    totalCharge: json["total_charge"].toDouble(),
    senderExRate: json["sender_ex_rate"].toDouble(),
    exchangeRate: json["exchange_rate"].toDouble(),
    payableAmount: json["payable_amount"].toDouble(),
    willGet: json["will_get"].toDouble(),
  );
}

class ReceiverWallet {
  final String address;
  final String code;
  final String rate;

  ReceiverWallet({
    required this.address,
    required this.code,
    required this.rate,
  });

  factory ReceiverWallet.fromJson(Map<String, dynamic> json) => ReceiverWallet(
    address: json["address"],
    code: json["code"],
    rate: json["rate"],
  );
}

class SenderWallet {
  final int id;
  final String name;
  final String code;
  final String rate;

  SenderWallet({
    required this.id,
    required this.name,
    required this.code,
    required this.rate,
  });

  factory SenderWallet.fromJson(Map<String, dynamic> json) => SenderWallet(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    rate: json["rate"],
  );
}