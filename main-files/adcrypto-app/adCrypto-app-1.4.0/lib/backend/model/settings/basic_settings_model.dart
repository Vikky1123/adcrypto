class BasicSettingsModel {
  final Data data;

  BasicSettingsModel({
    required this.data,
  });

  factory BasicSettingsModel.fromJson(Map<String, dynamic> json) => BasicSettingsModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final List<DefaultCurrency> defaultCurrency;
  final List<BasicSetting> basicSettings;
  final List<SplashScreen> splashScreen;
  final List<OnboardScreen> onboardScreen;
  final ImagePath basicImagePath;
  final ImagePath appImagePath;
  final List<Login> login;
  final List<Login> register;
  final String privacyPolicyLink;
  final String aboutPageLink;
  final String contactPageLink;

  Data({
    required this.defaultCurrency,
    required this.basicSettings,
    required this.splashScreen,
    required this.onboardScreen,
    required this.basicImagePath,
    required this.appImagePath,
    required this.login,
    required this.register,
    required this.privacyPolicyLink,
    required this.aboutPageLink,
    required this.contactPageLink
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    defaultCurrency: List<DefaultCurrency>.from(json["default_currency"].map((x) => DefaultCurrency.fromJson(x))),
    basicSettings: List<BasicSetting>.from(json["basic_settings"].map((x) => BasicSetting.fromJson(x))),
    login: List<Login>.from(json["login"].map((x) => Login.fromJson(x))),
    register: List<Login>.from(json["register"].map((x) => Login.fromJson(x))),
    splashScreen: List<SplashScreen>.from(json["splash_screen"].map((x) => SplashScreen.fromJson(x))),
    onboardScreen: List<OnboardScreen>.from(json["onboard_screen"].map((x) => OnboardScreen.fromJson(x))),
    basicImagePath: ImagePath.fromJson(json["basic_image_path"]),
    appImagePath: ImagePath.fromJson(json["app_image_path"]),
    privacyPolicyLink: json["privacy_policy_link"],
    aboutPageLink: json["about_page_link"],
    contactPageLink: json["contact_page_link"],
  );
}

class ImagePath {
  final String baseUrl;
  final String pathLocation;
  final String defaultImage;

  ImagePath({
    required this.baseUrl,
    required this.pathLocation,
    required this.defaultImage,
  });

  factory ImagePath.fromJson(Map<String, dynamic> json) => ImagePath(
    baseUrl: json["base_url"],
    pathLocation: json["path_location"],
    defaultImage: json["default_image"],
  );
}

class BasicSetting {
  final int id;
  final String siteName;
  final String baseColor;
  final String siteLogoDark;
  final String siteLogo;
  final String siteFavDark;
  final String siteFav;
  final DateTime createdAt;

  BasicSetting({
    required this.id,
    required this.siteName,
    required this.baseColor,
    required this.siteLogoDark,
    required this.siteLogo,
    required this.siteFavDark,
    required this.siteFav,
    required this.createdAt,
  });

  factory BasicSetting.fromJson(Map<String, dynamic> json) => BasicSetting(
    id: json["id"],
    siteName: json["site_name"],
    baseColor: json["base_color"],
    siteLogoDark: json["site_logo_dark"],
    siteLogo: json["site_logo"],
    siteFavDark: json["site_fav_dark"],
    siteFav: json["site_fav"],
    createdAt: DateTime.parse(json["created_at"]),
  );
}

class DefaultCurrency {
  final int id;
  final dynamic country;
  final String name;
  final String code;
  final String symbol;

  DefaultCurrency({
    required this.id,
    required this.country,
    required this.name,
    required this.code,
    required this.symbol,
  });

  factory DefaultCurrency.fromJson(Map<String, dynamic> json) => DefaultCurrency(
    id: json["id"],
    country: json["country"],
    name: json["name"],
    code: json["code"],
    symbol: json["symbol"],
  );
}

class OnboardScreen {
  final int id;
  final String title;
  final String subTitle;
  final String image;
  final int status;
  final int lastEditBy;
  final DateTime createdAt;

  OnboardScreen({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.image,
    required this.status,
    required this.lastEditBy,
    required this.createdAt,
  });

  factory OnboardScreen.fromJson(Map<String, dynamic> json) => OnboardScreen(
    id: json["id"],
    title: json["title"],
    subTitle: json["sub_title"],
    image: json["image"],
    status: json["status"],
    lastEditBy: json["last_edit_by"],
    createdAt: DateTime.parse(json["created_at"]),
  );
}

class SplashScreen {
  final int id;
  final String version;
  final String splashScreenImage;
  final DateTime createdAt;

  SplashScreen({
    required this.id,
    required this.version,
    required this.splashScreenImage,
    required this.createdAt,
  });

  factory SplashScreen.fromJson(Map<String, dynamic> json) => SplashScreen(
    id: json["id"],
    version: json["version"],
    splashScreenImage: json["splash_screen_image"],
    createdAt: DateTime.parse(json["created_at"]),
  );
}

class Login {
  final String image;
  final String title;
  final String heading;

  Login({
    required this.image,
    required this.title,
    required this.heading,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    image: json["image"],
    title: json["title"],
    heading: json["heading"],
  );
}