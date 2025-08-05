class WithdrawLogModel {
  final WithdrawLogModelData data;

  WithdrawLogModel({
    required this.data,
  });

  factory WithdrawLogModel.fromJson(Map<String, dynamic> json) => WithdrawLogModel(
    data: WithdrawLogModelData.fromJson(json["data"]),
  );
}

class WithdrawLogModelData {
  final Map<String, String> statusCode;
  final List<WithdrawLog> withdrawLog;

  WithdrawLogModelData({
    required this.statusCode,
    required this.withdrawLog,
  });

  factory WithdrawLogModelData.fromJson(Map<String, dynamic> json) => WithdrawLogModelData(
    statusCode: Map.from(json["status_code"]).map((k, v) => MapEntry<String, String>(k, v)),
    withdrawLog: List<WithdrawLog>.from(json["withdraw_log"].map((x) => WithdrawLog.fromJson(x))),
  );
}

class WithdrawLog {
  final int id;
  final String type;
  final int userId;
  final int userWalletId;
  final String paymentGatewayId;
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

  WithdrawLog({
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
    required this.rejectReason,
    required this.status,
    required this.createdAt,
  });

  factory WithdrawLog.fromJson(Map<String, dynamic> json) => WithdrawLog(
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

  DetailsData({
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

  factory DetailsData.fromJson(Map<String, dynamic> json) => DetailsData(
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