

import 'package:get/get.dart';

import '../backend/model/settings/basic_settings_model.dart';
import '../backend/model/settings/country_list_model.dart';
import '../backend/services/basic_settings_service/basic_settings_service.dart';
import '../backend/utils/api_method.dart';
import '../extensions/custom_extensions.dart';
import '../utils/custom_color.dart';

class BasicSettingsController extends GetxController with BasicSettingsService{

  RxString splashScreen  = "".obs;
  RxString onboardScreen  = "".obs;
  RxString onboardScreenTitle  = "".obs;
  RxString onboardScreenSubTitle  = "".obs;

  RxString  siteLogo = "".obs;
  RxString  siteLogoDark = "".obs;

  RxString  siteFav = "".obs;
  RxString  siteFavDark = "".obs;

  @override
  void onInit() {
    basicSettingsGetProcess("en");
    super.onInit();
  }

  /// >> set loading process & BasicSettings Model
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late BasicSettingsModel _basicSettingsModel;
  BasicSettingsModel get basicSettingsModel => _basicSettingsModel;

  ///* Get BasicSettings in process
  Future<BasicSettingsModel> basicSettingsGetProcess(String code) async {
    _isLoading.value = true;
    update();
    await basicSettingsGetProcessApi(code).then((value) {
      _basicSettingsModel = value!;

      var imagePath = _basicSettingsModel.data.appImagePath;
      splashScreen.value = "${imagePath.baseUrl}/${imagePath.pathLocation}/${_basicSettingsModel.data.splashScreen.first.splashScreenImage}";
      onboardScreen.value = "${imagePath.baseUrl}/${imagePath.pathLocation}/${_basicSettingsModel.data.onboardScreen.first.image}";
      onboardScreenTitle.value = _basicSettingsModel.data.onboardScreen.first.title;
      onboardScreenSubTitle.value = _basicSettingsModel.data.onboardScreen.first.subTitle;

      var iconPath = _basicSettingsModel.data.basicImagePath;
      siteLogo.value = "${iconPath.baseUrl}/${iconPath.pathLocation}/${_basicSettingsModel.data.basicSettings.first.siteLogo}";
      siteLogoDark.value = "${iconPath.baseUrl}/${iconPath.pathLocation}/${_basicSettingsModel.data.basicSettings.first.siteLogoDark}";
      siteFav.value = "${iconPath.baseUrl}/${iconPath.pathLocation}/${_basicSettingsModel.data.basicSettings.first.siteFav}";
      siteFavDark.value = "${iconPath.baseUrl}/${iconPath.pathLocation}/${_basicSettingsModel.data.basicSettings.first.siteFavDark}";

      CustomColor.primaryLightColor = HexColor(_basicSettingsModel.data.basicSettings.first.baseColor);
      CustomColor.primaryDarkColor = HexColor(_basicSettingsModel.data.basicSettings.first.baseColor);


      _isLoading.value = false;
      countryListGetProcess();
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _basicSettingsModel;
  }



  late CountryListModel _countryListModel;
  CountryListModel get countryListModel => _countryListModel;

  Future<CountryListModel> countryListGetProcess() async {
    // _isLoading.value = true;
    // update();
    await countryListGetProcessApi().then((value) {
      _countryListModel = value!;
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    // _isLoading.value = false;
    // update();
    return _countryListModel;
  }
}