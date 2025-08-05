class BuyCryptoModel {
  final Data data;

  BuyCryptoModel({
    required this.data,
  });

  factory BuyCryptoModel.fromJson(Map<String, dynamic> json) => BuyCryptoModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final List<String> walletType;
  final List<Currency> currencies;
  final List<PaymentGateway> paymentGateway;
  final ImagePaths currencyImagePaths;
  final ImagePaths paymentImagePaths;

  Data({
    required this.walletType,
    required this.currencies,
    required this.paymentGateway,
    required this.currencyImagePaths,
    required this.paymentImagePaths,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    walletType: List<String>.from(json["wallet_type"].map((x) => x)),
    currencies: List<Currency>.from(json["currencies"].map((x) => Currency.fromJson(x))),
    paymentGateway: List<PaymentGateway>.from(json["payment_gateway"].map((x) => PaymentGateway.fromJson(x))),
    currencyImagePaths: ImagePaths.fromJson(json["currency_image_paths"]),
    paymentImagePaths: ImagePaths.fromJson(json["payment_image_paths"]),
  );
}

class Currency {
  final int id;
  final String name;
  final String code;
  final String symbol;
  final String flag;
  final String rate;
  final List<Network> networks;
  final List<Wallet> wallet;

  Currency({
    required this.id,
    required this.name,
    required this.code,
    required this.symbol,
    required this.flag,
    required this.rate,
    required this.networks,
    required this.wallet,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    symbol: json["symbol"],
    flag: json["flag"],
    rate: json["rate"],
    networks: List<Network>.from(json["networks"].map((x) => Network.fromJson(x))),
    wallet: List<Wallet>.from(json["wallet"].map((x) => Wallet.fromJson(x))),
  );
}

class Network {
  final int id;
  final int currencyId;
  final int networkId;
  final String name;
  final int arrivalTime;

  Network({
    required this.id,
    required this.currencyId,
    required this.networkId,
    required this.name,
    required this.arrivalTime,
  });

  factory Network.fromJson(Map<String, dynamic> json) => Network(
    id: json["id"],
    currencyId: json["currency_id"],
    networkId: json["network_id"],
    name: json["name"],
    arrivalTime: json["arrival_time"],
  );
}

class Wallet {
  final int id;
  final int userId;
  final int currencyId;
  final String publicAddress;
  final String balance;

  Wallet({
    required this.id,
    required this.userId,
    required this.currencyId,
    required this.publicAddress,
    required this.balance,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
    id: json["id"],
    userId: json["user_id"],
    currencyId: json["currency_id"],
    publicAddress: json["public_address"],
    balance: json["balance"],
  );
}

class ImagePaths {
  final String baseUrl;
  final String pathLocation;
  final String defaultImage;

  ImagePaths({
    required this.baseUrl,
    required this.pathLocation,
    required this.defaultImage,
  });

  factory ImagePaths.fromJson(Map<String, dynamic> json) => ImagePaths(
    baseUrl: json["base_url"],
    pathLocation: json["path_location"],
    defaultImage: json["default_image"],
  );
}

class PaymentGateway {
  final int id;
  final int paymentGatewayId;
  final String name;
  final String alias;
  final String currencyCode;
  final String currencySymbol;
  final String image;
  final String minLimit;
  final String maxLimit;
  final String percentCharge;
  final String fixedCharge;
  final String rate;
  final DateTime createdAt;
  final DateTime updatedAt;

  PaymentGateway({
    required this.id,
    required this.paymentGatewayId,
    required this.name,
    required this.alias,
    required this.currencyCode,
    required this.currencySymbol,
    required this.image,
    required this.minLimit,
    required this.maxLimit,
    required this.percentCharge,
    required this.fixedCharge,
    required this.rate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PaymentGateway.fromJson(Map<String, dynamic> json) => PaymentGateway(
    id: json["id"],
    paymentGatewayId: json["payment_gateway_id"],
    name: json["name"],
    alias: json["alias"],
    currencyCode: json["currency_code"],
    currencySymbol: json["currency_symbol"] ?? "",
    image: json["image"] ?? "",
    minLimit: json["min_limit"],
    maxLimit: json["max_limit"],
    percentCharge: json["percent_charge"],
    fixedCharge: json["fixed_charge"],
    rate: json["rate"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}