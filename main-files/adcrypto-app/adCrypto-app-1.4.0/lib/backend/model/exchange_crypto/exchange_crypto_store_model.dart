class ExchangeCryptoStoreModel{
  final ExchangeCryptoStoreModelData data;

  ExchangeCryptoStoreModel({
    required this.data,
  });

  factory ExchangeCryptoStoreModel.fromJson(Map<String, dynamic> json) => ExchangeCryptoStoreModel(
    data: ExchangeCryptoStoreModelData.fromJson(json["data"]),
  );
}

class ExchangeCryptoStoreModelData {
  final PurpleData data;

  ExchangeCryptoStoreModelData({
    required this.data,
  });

  factory ExchangeCryptoStoreModelData.fromJson(Map<String, dynamic> json) => ExchangeCryptoStoreModelData(
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
  final ErWallet senderWallet;
  final ErWallet receiverWallet;
  final double exchangeRate;
  final double sendingAmount;
  final int fixedCharge;
  final double percentCharge;
  final double totalCharge;
  final double payableAmount;
  final double getAmount;

  FluffyData({
    required this.senderWallet,
    required this.receiverWallet,
    required this.exchangeRate,
    required this.sendingAmount,
    required this.fixedCharge,
    required this.percentCharge,
    required this.totalCharge,
    required this.payableAmount,
    required this.getAmount,
  });

  factory FluffyData.fromJson(Map<String, dynamic> json) => FluffyData(
    senderWallet: ErWallet.fromJson(json["sender_wallet"]),
    receiverWallet: ErWallet.fromJson(json["receiver_wallet"]),
    exchangeRate: json["exchange_rate"].toDouble(),
    sendingAmount: json["sending_amount"].toDouble(),
    fixedCharge: json["fixed_charge"],
    percentCharge: json["percent_charge"].toDouble(),
    totalCharge: json["total_charge"].toDouble(),
    payableAmount: json["payable_amount"].toDouble(),
    getAmount: json["get_amount"].toDouble(),
  );
}

class ErWallet {
  final int id;
  final String name;
  final String code;
  final String rate;
  final String balance;

  ErWallet({
    required this.id,
    required this.name,
    required this.code,
    required this.rate,
    required this.balance,
  });

  factory ErWallet.fromJson(Map<String, dynamic> json) => ErWallet(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    rate: json["rate"],
    balance: json["balance"],
  );
}