class SellCryptoStoreModel {
  final SellCryptoStoreModelData data;

  SellCryptoStoreModel({
    required this.data,
  });

  factory SellCryptoStoreModel.fromJson(Map<String, dynamic> json) => SellCryptoStoreModel(
    data: SellCryptoStoreModelData.fromJson(json["data"]),
  );
}

class SellCryptoStoreModelData {
  final PurpleData data;
  final String desc;
  final String desc2;
  final List<PaymentField> paymentGatewayFields;
  final String slug;
  final List<PaymentField> paymentProofFields;

  SellCryptoStoreModelData({
    required this.data,
    required this.desc,
    required this.desc2,
    required this.paymentGatewayFields,
    required this.slug,
    required this.paymentProofFields,
  });

  factory SellCryptoStoreModelData.fromJson(Map<String, dynamic> json) => SellCryptoStoreModelData(
    data: PurpleData.fromJson(json["data"]),
    desc: json["desc"] ?? "",
    desc2: json["payment_proof_desc"] ?? "",
    paymentGatewayFields: List<PaymentField>.from(json["payment_gateway_fields"].map((x) => PaymentField.fromJson(x))),
    slug: json["slug"] ?? "",
    paymentProofFields: List<PaymentField>.from((json["payment_proof_fields"] ?? []).map((x) => PaymentField.fromJson(x))),
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
  final Network network;
  final PaymentMethod paymentMethod;
  final double amount;
  final double exchangeRate;
  final double minMaxRate;
  final double fixedCharge;
  final double percentCharge;
  final double totalCharge;
  final double totalPayable;
  final double willGet;

  FluffyData({
    required this.senderWallet,
    required this.network,
    required this.paymentMethod,
    required this.amount,
    required this.exchangeRate,
    required this.minMaxRate,
    required this.fixedCharge,
    required this.percentCharge,
    required this.totalCharge,
    required this.totalPayable,
    required this.willGet,
  });

  factory FluffyData.fromJson(Map<String, dynamic> json) => FluffyData(
    senderWallet: SenderWallet.fromJson(json["sender_wallet"]),
    network: Network.fromJson(json["network"]),
    paymentMethod: PaymentMethod.fromJson(json["payment_method"]),
    amount: json["amount"].toDouble(),
    exchangeRate: json["exchange_rate"].toDouble(),
    minMaxRate: json["min_max_rate"].toDouble(),
    fixedCharge: json["fixed_charge"].toDouble(),
    percentCharge: json["percent_charge"].toDouble(),
    totalCharge: json["total_charge"].toDouble(),
    totalPayable: json["total_payable"].toDouble(),
    willGet: json["will_get"].toDouble(),
  );
}

class Network {
  final int id;
  final String name;
  final int arrivalTime;

  Network({
    required this.id,
    required this.name,
    required this.arrivalTime,
  });

  factory Network.fromJson(Map<String, dynamic> json) => Network(
    id: json["id"],
    name: json["name"],
    arrivalTime: json["arrival_time"],
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

class SenderWallet {
  final String type;
  final int walletId;
  final int currencyId;
  final String name;
  final String code;
  final double rate;
  final double balance;

  SenderWallet({
    required this.type,
    required this.walletId,
    required this.currencyId,
    required this.name,
    required this.code,
    required this.rate,
    required this.balance,
  });

  factory SenderWallet.fromJson(Map<String, dynamic> json) => SenderWallet(
    type: json["type"],
    walletId: json["wallet_id"],
    currencyId: json["currency_id"],
    name: json["name"],
    code: json["code"],
    rate: json["rate"].toDouble(),
    balance: json["balance"].toDouble(),
  );
}

class PaymentField {
  final String type;
  final String label;
  final String name;
  final bool required;
  final Validation validation;

  PaymentField({
    required this.type,
    required this.label,
    required this.name,
    required this.required,
    required this.validation,
  });

  factory PaymentField.fromJson(Map<String, dynamic> json) => PaymentField(
    type: json["type"] ?? "",
    label: json["label"] ?? "",
    name: json["name"] ?? "",
    required: json["required"] ?? false,
    validation: Validation.fromJson(json["validation"]),
  );
}

class Validation {
  final dynamic max;
  final List<String> mimes;
  final dynamic min;
  final List<String> options;
  final bool required;

  Validation({
    required this.max,
    required this.mimes,
    required this.min,
    required this.options,
    required this.required,
  });

  factory Validation.fromJson(Map<String, dynamic> json) => Validation(
    max: json["max"] ?? "",
    mimes: List<String>.from(json["mimes"].map((x) => x) ?? []),
    min: json["min"] ?? "",
    options: List<String>.from(json["options"].map((x) => x) ?? []),
    required: json["required"] ?? false,
  );
}