class BuyCryptoStoreModel {
  final BuyCryptoStoreModelData data;

  BuyCryptoStoreModel({
    required this.data,
  });

  factory BuyCryptoStoreModel.fromJson(Map<String, dynamic> json) => BuyCryptoStoreModel(
    data: BuyCryptoStoreModelData.fromJson(json["data"]),
  );
}

class BuyCryptoStoreModelData {
  final PurpleData data;

  BuyCryptoStoreModelData({
    required this.data,
  });

  factory BuyCryptoStoreModelData.fromJson(Map<String, dynamic> json) => BuyCryptoStoreModelData(
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
  final Wallet wallet;
  final Network network;
  final PaymentMethod paymentMethod;
  final double amount;
  final double exchangeRate;
  final double minMaxRate;
  final int fixedCharge;
  final double percentCharge;
  final double totalCharge;
  final double payableAmount;
  final double willGet;

  FluffyData({
    required this.wallet,
    required this.network,
    required this.paymentMethod,
    required this.amount,
    required this.exchangeRate,
    required this.minMaxRate,
    required this.fixedCharge,
    required this.percentCharge,
    required this.totalCharge,
    required this.payableAmount,
    required this.willGet,
  });

  factory FluffyData.fromJson(Map<String, dynamic> json) => FluffyData(
    wallet: Wallet.fromJson(json["wallet"]),
    network: Network.fromJson(json["network"]),
    paymentMethod: PaymentMethod.fromJson(json["payment_method"]),
    amount: json["amount"].toDouble(),
    exchangeRate: json["exchange_rate"].toDouble(),
    minMaxRate: json["min_max_rate"].toDouble(),
    fixedCharge: json["fixed_charge"],
    percentCharge: json["percent_charge"].toDouble(),
    totalCharge: json["total_charge"].toDouble(),
    payableAmount: json["payable_amount"].toDouble(),
    willGet: json["will_get"].toDouble(),
  );
}

class Network {
  final String name;
  final int arrivalTime;
  final String fees;

  Network({
    required this.name,
    required this.arrivalTime,
    required this.fees,
  });

  factory Network.fromJson(Map<String, dynamic> json) => Network(
    name: json["name"],
    arrivalTime: json["arrival_time"],
    fees: json["fees"],
  );
}

class PaymentMethod {
  final int id;
  final String name;
  final String code;
  final String alias;
  final String rate;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.code,
    required this.alias,
    required this.rate,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    alias: json["alias"],
    rate: json["rate"],
  );
}

class Wallet {
  final String type;
  final int walletId;
  final int currencyId;
  final String name;
  final String code;
  final String rate;
  final String balance;
  final String address;

  Wallet({
    required this.type,
    required this.walletId,
    required this.currencyId,
    required this.name,
    required this.code,
    required this.rate,
    required this.balance,
    required this.address,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
    type: json["type"],
    walletId: json["wallet_id"],
    currencyId: json["currency_id"],
    name: json["name"],
    code: json["code"],
    rate: json["rate"],
    balance: json["balance"],
    address: json["address"] ?? "",
  );
}