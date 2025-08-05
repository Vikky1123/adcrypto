class SellCryptoPaymentInfoStoreModel {
  final SellCryptoPaymentInfoStoreModelData data;

  SellCryptoPaymentInfoStoreModel({
    required this.data,
  });

  factory SellCryptoPaymentInfoStoreModel.fromJson(Map<String, dynamic> json) => SellCryptoPaymentInfoStoreModel(
    data: SellCryptoPaymentInfoStoreModelData.fromJson(json["data"]),
  );
}

class SellCryptoPaymentInfoStoreModelData {
  final PurpleData data;
  final Details details;
  final ImagePaths imagePaths;

  SellCryptoPaymentInfoStoreModelData({
    required this.data,
    required this.details,
    required this.imagePaths,
  });

  factory SellCryptoPaymentInfoStoreModelData.fromJson(Map<String, dynamic> json) => SellCryptoPaymentInfoStoreModelData(
    data: PurpleData.fromJson(json["data"]),
    details: Details.fromJson(json["details"]),
    imagePaths: ImagePaths.fromJson(json["image_paths"]),
  );
}

class PurpleData {
  final int id;
  final String type;
  final String identifier;
  final dynamic gatewayCode;
  final dynamic currencyCode;
  final FluffyData data;

  PurpleData({
    required this.id,
    required this.type,
    required this.identifier,
    required this.gatewayCode,
    required this.currencyCode,
    required this.data,
  });

  factory PurpleData.fromJson(Map<String, dynamic> json) => PurpleData(
    id: json["id"],
    type: json["type"],
    identifier: json["identifier"],
    gatewayCode: json["gateway_code"] ?? "",
    currencyCode: json["currency_code"] ?? "",
    data: FluffyData.fromJson(json["data"]),
  );
}

class FluffyData {
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

  FluffyData({
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

  factory FluffyData.fromJson(Map<String, dynamic> json) => FluffyData(
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
  // final String id;
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
  final List<GatewayInputValue> outsideAddressInputValues;

  Details({
    required this.gatewayInputValues,
    required this.outsideAddressInputValues,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    gatewayInputValues: List<GatewayInputValue>.from(json["gateway_input_values"].map((x) => GatewayInputValue.fromJson(x))),
    outsideAddressInputValues: List<GatewayInputValue>.from(json["outside_address_input_values"].map((x) => GatewayInputValue.fromJson(x))),
    // outsideAddressInputValues: List<dynamic>.from(json["outside_address_input_values"].map((x) => x)),
  );
}

class GatewayInputValue {
  final String type;
  final String label;
  final String name;
  final bool required;
  final Validation validation;
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
    validation: Validation.fromJson(json["validation"]),
    value: json["value"],
  );
}



class Validation {
  final dynamic max;
  final List<dynamic> mimes;
  final dynamic min;
  final List<dynamic> options;
  final bool required;

  Validation({
    required this.max,
    required this.mimes,
    required this.min,
    required this.options,
    required this.required,
  });

  factory Validation.fromJson(Map<String, dynamic> json) => Validation(
    max: json["max"].toString(),
    mimes: List<dynamic>.from(json["mimes"].map((x) => x)),
    min: json["min"].toString(),
    options: List<dynamic>.from(json["options"].map((x) => x)),
    required: json["required"],
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



enum PreviewType{image, text}

class DynamicPreview{
  final String name, value;
  final PreviewType type;

  DynamicPreview({required this.name, required this.value, required this.type});
}