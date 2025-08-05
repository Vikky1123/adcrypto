class BuyCryptoAutomaticModel {
  final Data data;

  BuyCryptoAutomaticModel({
    required this.data,
  });

  factory BuyCryptoAutomaticModel.fromJson(Map<String, dynamic> json) => BuyCryptoAutomaticModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final String redirectUrl;

  Data({
    required this.redirectUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    redirectUrl: json["redirect_url"],
  );
}