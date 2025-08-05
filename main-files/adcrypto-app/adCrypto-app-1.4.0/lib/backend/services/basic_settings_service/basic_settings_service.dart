
import '../../../widgets/others/custom_snack_bar.dart';
import '../../model/settings/basic_settings_model.dart';
import '../../model/settings/country_list_model.dart';
import '../../utils/api_method.dart';
import '../api_endpoint.dart';

mixin BasicSettingsService{

  ///* Get BasicSettings api services
  Future<BasicSettingsModel?> basicSettingsGetProcessApi(String code) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: true).get(
        "${ApiEndpoint.basicSettingsUrl}?lang=$code"
      );
      if (mapResponse != null) {
        BasicSettingsModel result = BasicSettingsModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from BasicSettings api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* Get CountryList api services
  Future<CountryListModel?> countryListGetProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: true).get(
        ApiEndpoint.countryListUrl,
      );
      if (mapResponse != null) {
        CountryListModel result = CountryListModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from CountryList api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }
}