class ProfileModel {
  final Data data;

  ProfileModel({
    required this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final UserInfo userInfo;
  final ImagePaths imagePaths;

  Data({
    required this.userInfo,
    required this.imagePaths,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userInfo: UserInfo.fromJson(json["user_info"]),
    imagePaths: ImagePaths.fromJson(json["image_paths"]),
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

class UserInfo {
  final int id;
  final String firstname;
  final String lastname;
  final String username;
  final String email;
  final String mobileCode;
  final String mobile;
  final String image;
  final String dateOfBirth;
  final String country;
  final String city;
  final String state;
  final String zip;
  final String address;

  UserInfo({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.email,
    required this.mobileCode,
    required this.mobile,
    required this.image,
    required this.dateOfBirth,
    required this.country,
    required this.city,
    required this.state,
    required this.zip,
    required this.address,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    id: json["id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    username: json["username"],
    email: json["email"],
    mobileCode: json["mobile_code"] ?? "",
    mobile: json["mobile"] ?? "",
    image: json["image"] ?? "",
    dateOfBirth: json["date_of_birth"] ?? "",
    country: json["country"],
    city: json["city"],
    state: json["state"],
    zip: json["zip"],
    address: json["address"],
  );
}