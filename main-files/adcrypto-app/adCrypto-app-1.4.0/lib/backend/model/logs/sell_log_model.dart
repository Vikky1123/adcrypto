class SellLogModel {
  final SellLogModelData data;

  SellLogModel({
    required this.data,
  });

  factory SellLogModel.fromJson(Map<String, dynamic> json) => SellLogModel(
    data: SellLogModelData.fromJson(json["data"]),
  );
}

class SellLogModelData {
  final Map<String, String> statusCode;
  final List<SellLog> sellLog;

  SellLogModelData({
    required this.statusCode,
    required this.sellLog,
  });

  factory SellLogModelData.fromJson(Map<String, dynamic> json) => SellLogModelData(
    statusCode: Map.from(json["status_code"]).map((k, v) => MapEntry<String, String>(k, v)),
    sellLog: List<SellLog>.from(json["sell_log"].map((x) => SellLog.fromJson(x))),
  );
}

class SellLog {
  final int id;
  final String type;
  final int userId;
  final int userWalletId;
  final dynamic paymentGatewayId;
  final String trxId;
  final String amount;
  final String percentCharge;
  final String fixedCharge;
  final String totalCharge;
  final String totalPayable;
  final dynamic availableBalance;
  final String remark;
  final Details details;
  final SellLogData data;
  final dynamic rejectReason;
  final int status;
  final DateTime createdAt;

  SellLog({
    required this.id,
    required this.type,
    required this.userId,
    required this.userWalletId,
    required this.paymentGatewayId,
    required this.trxId,
    required this.amount,
    required this.percentCharge,
    required this.fixedCharge,
    required this.totalCharge,
    required this.totalPayable,
    required this.availableBalance,
    required this.remark,
    required this.details,
    required this.data,
    required this.rejectReason,
    required this.status,
    required this.createdAt,
  });

  factory SellLog.fromJson(Map<String, dynamic> json) => SellLog(
    id: json["id"],
    type: json["type"],
    userId: json["user_id"],
    userWalletId: json["user_wallet_id"],
    paymentGatewayId: json["payment_gateway_id"],
    trxId: json["trx_id"],
    amount: json["amount"],
    percentCharge: json["percent_charge"],
    fixedCharge: json["fixed_charge"],
    totalCharge: json["total_charge"],
    totalPayable: json["total_payable"],
    availableBalance: json["available_balance"],
    remark: json["remark"],
    details: Details.fromJson(json["details"]),
    data: SellLogData.fromJson(json["data"]),
    rejectReason: json["reject_reason"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
  );
}

class SellLogData {
  final SenderWallet senderWallet;
  final Network network;
  final PaymentMethod paymentMethod;
  final OutsideAddress outsideAddress;
  final String details;
  final double amount;
  final double exchangeRate;
  final double minMaxRate;
  final double fixedCharge;
  final double percentCharge;
  final double totalCharge;
  final double totalPayable;
  final double willGet;

  SellLogData({
    required this.senderWallet,
    required this.network,
    required this.paymentMethod,
    required this.outsideAddress,
    required this.details,
    required this.amount,
    required this.exchangeRate,
    required this.minMaxRate,
    required this.fixedCharge,
    required this.percentCharge,
    required this.totalCharge,
    required this.totalPayable,
    required this.willGet,
  });

  factory SellLogData.fromJson(Map<String, dynamic> json) => SellLogData(
    senderWallet: SenderWallet.fromJson(json["sender_wallet"]),
    network: Network.fromJson(json["network"]),
    paymentMethod: PaymentMethod.fromJson(json["payment_method"]),
    outsideAddress: OutsideAddress.fromJson(json["outside_address"]),
    details: json["details"],
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
  final String name;
  final int arrivalTime;

  Network({
    required this.name,
    required this.arrivalTime,
  });

  factory Network.fromJson(Map<String, dynamic> json) => Network(
    name: json["name"],
    arrivalTime: json["arrival_time"],
  );
}

class OutsideAddress {
  // final int id;
  final String publicAddress;
  final String slug;

  OutsideAddress({
    // required this.id,
    required this.publicAddress,
    required this.slug,
  });

  factory OutsideAddress.fromJson(Map<String, dynamic> json) => OutsideAddress(
    // id: json["id"],
    publicAddress: json["public_address"],
    slug: json["slug"],
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

class Details {
  final List<GatewayInputValue> gatewayInputValues;
  final List<OutsideAddressInputValue> outsideAddressInputValues;

  Details({
    required this.gatewayInputValues,
    required this.outsideAddressInputValues,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    gatewayInputValues: List<GatewayInputValue>.from(json["gateway_input_values"].map((x) => GatewayInputValue.fromJson(x))),
    outsideAddressInputValues: List<OutsideAddressInputValue>.from(json["outside_address_input_values"].map((x) => OutsideAddressInputValue.fromJson(x))),
  );
}

class GatewayInputValue {
  final String type;
  final String label;
  final String name;
  final bool required;
  final GatewayInputValueValidation validation;
  final String value;

  GatewayInputValue({
    required this.type,
    required this.label,
    required this.name,
    required this.required,
    required this.validation,
    required this.value,
  });

  factory GatewayInputValue.fromJson(Map<String, dynamic> json) => GatewayInputValue(
    type: json["type"],
    label: json["label"],
    name: json["name"],
    required: json["required"],
    validation: GatewayInputValueValidation.fromJson(json["validation"]),
    value: json["value"],
  );
}

class GatewayInputValueValidation {
  final dynamic max;
  final List<dynamic> mimes;
  final dynamic min;
  final List<dynamic> options;
  final bool required;

  GatewayInputValueValidation({
    required this.max,
    required this.mimes,
    required this.min,
    required this.options,
    required this.required,
  });

  factory GatewayInputValueValidation.fromJson(Map<String, dynamic> json) => GatewayInputValueValidation(
    max: json["max"] ?? "",
    mimes: List<dynamic>.from(json["mimes"].map((x) => x)),
    min: json["min"] ?? "",
    options: List<dynamic>.from(json["options"].map((x) => x)),
    required: json["required"],
  );
}

class OutsideAddressInputValue {
  final String type;
  final String label;
  final String name;
  final bool required;
  final OutsideAddressInputValueValidation validation;
  final String value;

  OutsideAddressInputValue({
    required this.type,
    required this.label,
    required this.name,
    required this.required,
    required this.validation,
    required this.value,
  });

  factory OutsideAddressInputValue.fromJson(Map<String, dynamic> json) => OutsideAddressInputValue(
    type: json["type"],
    label: json["label"],
    name: json["name"],
    required: json["required"],
    validation: OutsideAddressInputValueValidation.fromJson(json["validation"]),
    value: json["value"],
  );
}

class OutsideAddressInputValueValidation {
  final dynamic max;
  final List<String> mimes;
  final dynamic min;
  final List<dynamic> options;
  final bool required;

  OutsideAddressInputValueValidation({
    required this.max,
    required this.mimes,
    required this.min,
    required this.options,
    required this.required,
  });

  factory OutsideAddressInputValueValidation.fromJson(Map<String, dynamic> json) => OutsideAddressInputValueValidation(
    max: json["max"] ?? "",
    mimes: List<String>.from(json["mimes"].map((x) => x)),
    min: json["min"] ?? "",
    options: List<dynamic>.from(json["options"].map((x) => x)),
    required: json["required"],
  );
}