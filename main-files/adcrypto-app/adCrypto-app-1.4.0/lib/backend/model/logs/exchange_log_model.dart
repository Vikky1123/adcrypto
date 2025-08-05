class ExchangeLogModel {
  final ExchangeLogModelData data;

  ExchangeLogModel({
    required this.data,
  });

  factory ExchangeLogModel.fromJson(Map<String, dynamic> json) => ExchangeLogModel(
    data: ExchangeLogModelData.fromJson(json["data"]),
  );
}

class ExchangeLogModelData {
  final Map<String, String> statusCode;
  final List<ExchangeLog> exchangeLog;

  ExchangeLogModelData({
    required this.statusCode,
    required this.exchangeLog,
  });

  factory ExchangeLogModelData.fromJson(Map<String, dynamic> json) => ExchangeLogModelData(
    statusCode: Map.from(json["status_code"]).map((k, v) => MapEntry<String, String>(k, v)),
    exchangeLog: List<ExchangeLog>.from(json["exchange_log"].map((x) => ExchangeLog.fromJson(x))),
  );
}

class ExchangeLog {
  final int id;
  final String type;
  final int userId;
  final int userWalletId;
  final String trxId;
  final String amount;
  final String percentCharge;
  final String fixedCharge;
  final String totalCharge;
  final String totalPayable;
  final String availableBalance;
  final String remark;
  final Details details;
  final dynamic rejectReason;
  final int status;
  final DateTime createdAt;

  ExchangeLog({
    required this.id,
    required this.type,
    required this.userId,
    required this.userWalletId,
    required this.trxId,
    required this.amount,
    required this.percentCharge,
    required this.fixedCharge,
    required this.totalCharge,
    required this.totalPayable,
    required this.availableBalance,
    required this.remark,
    required this.details,
    required this.rejectReason,
    required this.status,
    required this.createdAt,
  });

  factory ExchangeLog.fromJson(Map<String, dynamic> json) => ExchangeLog(
    id: json["id"],
    type: json["type"],
    userId: json["user_id"],
    userWalletId: json["user_wallet_id"],
    trxId: json["trx_id"],
    amount: json["amount"],
    percentCharge: json["percent_charge"],
    fixedCharge: json["fixed_charge"],
    totalCharge: json["total_charge"],
    totalPayable: json["total_payable"],
    availableBalance: json["available_balance"],
    remark: json["remark"],
    details: Details.fromJson(json["details"]),
    rejectReason: json["reject_reason"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
  );
}

class Details {
  final DetailsData data;

  Details({
    required this.data,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    data: DetailsData.fromJson(json["data"]),
  );
}

class DetailsData {
  final ErWallet senderWallet;
  final ErWallet receiverWallet;
  final double exchangeRate;
  final double sendingAmount;
  final double fixedCharge;
  final double percentCharge;
  final double totalCharge;
  final double payableAmount;
  final double getAmount;

  DetailsData({
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

  factory DetailsData.fromJson(Map<String, dynamic> json) => DetailsData(
    senderWallet: ErWallet.fromJson(json["sender_wallet"]),
    receiverWallet: ErWallet.fromJson(json["receiver_wallet"]),
    exchangeRate: json["exchange_rate"].toDouble(),
    sendingAmount: json["sending_amount"].toDouble(),
    fixedCharge: json["fixed_charge"].toDouble(),
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