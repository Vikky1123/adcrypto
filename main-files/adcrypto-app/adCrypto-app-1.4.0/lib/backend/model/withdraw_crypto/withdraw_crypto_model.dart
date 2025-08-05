class WithdrawCryptoModel {
  final Data data;

  WithdrawCryptoModel({
    required this.data,
  });

  factory WithdrawCryptoModel.fromJson(Map<String, dynamic> json) => WithdrawCryptoModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final List<Currency> currencies;
  final TransactionFees transactionFees;
  final CurrencyImagePaths currencyImagePaths;

  Data({
    required this.currencies,
    required this.transactionFees,
    required this.currencyImagePaths,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currencies: List<Currency>.from(json["currencies"].map((x) => Currency.fromJson(x))),
    transactionFees: TransactionFees.fromJson(json["transaction_fees"]),
    currencyImagePaths: CurrencyImagePaths.fromJson(json["currency_image_paths"]),
  );
}

class Currency {
  final int id;
  final String name;
  final String code;
  final String symbol;
  final String flag;
  final String rate;
  final List<Wallet> wallets;

  Currency({
    required this.id,
    required this.name,
    required this.code,
    required this.symbol,
    required this.flag,
    required this.rate,
    required this.wallets,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    symbol: json["symbol"],
    flag: json["flag"],
    rate: json["rate"],
    wallets: List<Wallet>.from(json["wallets"].map((x) => Wallet.fromJson(x))),
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

class CurrencyImagePaths {
  final String baseUrl;
  final String pathLocation;
  final String defaultImage;

  CurrencyImagePaths({
    required this.baseUrl,
    required this.pathLocation,
    required this.defaultImage,
  });

  factory CurrencyImagePaths.fromJson(Map<String, dynamic> json) => CurrencyImagePaths(
    baseUrl: json["base_url"],
    pathLocation: json["path_location"],
    defaultImage: json["default_image"],
  );
}

class TransactionFees {
  final int id;
  final int adminId;
  final String slug;
  final String title;
  final String fixedCharge;
  final String percentCharge;
  final String minLimit;
  final String maxLimit;
  final int status;

  TransactionFees({
    required this.id,
    required this.adminId,
    required this.slug,
    required this.title,
    required this.fixedCharge,
    required this.percentCharge,
    required this.minLimit,
    required this.maxLimit,
    required this.status,
  });

  factory TransactionFees.fromJson(Map<String, dynamic> json) => TransactionFees(
    id: json["id"],
    adminId: json["admin_id"],
    slug: json["slug"],
    title: json["title"],
    fixedCharge: json["fixed_charge"],
    percentCharge: json["percent_charge"],
    minLimit: json["min_limit"],
    maxLimit: json["max_limit"],
    status: json["status"],
  );
}