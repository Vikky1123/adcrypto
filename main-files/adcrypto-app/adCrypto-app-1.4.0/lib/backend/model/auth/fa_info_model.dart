class FaInfoModel {
  final Data data;

  FaInfoModel({
    required this.data,
  });

  factory FaInfoModel.fromJson(Map<String, dynamic> json) => FaInfoModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final String qrCode;
  final String qrSecrete;
  final int qrStatus;
  final String alert;

  Data({
    required this.qrCode,
    required this.qrSecrete,
    required this.qrStatus,
    required this.alert,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    qrCode: json["qr_code"],
    qrSecrete: json["qr_secrete"],
    qrStatus: json["qr_status"],
    alert: json["alert"],
  );
}