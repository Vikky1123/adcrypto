import '../../../widgets/others/custom_snack_bar.dart';
import '../../model/buy_crypto/buy_crypto_automatic_model.dart';
import '../../model/buy_crypto/buy_crypto_manual_model.dart';
import '../../model/buy_crypto/buy_crypto_model.dart';
import '../../model/buy_crypto/buy_crypto_store_model.dart';
import '../../model/buy_crypto/buy_crypto_tatum_model.dart';
import '../../model/common/common_success_model.dart';
import '../../utils/api_method.dart';
import '../api_endpoint.dart';

mixin BuyCryptoService{

  ///* Get BuyCrypto api services
  Future<BuyCryptoModel?> buyCryptoProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
          ApiEndpoint.buyCryptoURL
      );
      if (mapResponse != null) {
        BuyCryptoModel result = BuyCryptoModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from BuyCrypto api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* BuyCryptoStore api services
  Future<BuyCryptoStoreModel?> buyCryptoStoreProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.buyCryptoStoreURL,
        body,
      );
      if (mapResponse != null) {
        BuyCryptoStoreModel result = BuyCryptoStoreModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from BuyCryptoStore api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* BuyCryptoSubmit api services for Automatic
  Future<BuyCryptoAutomaticModel?> buyCryptoAutomaticSubmitProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.buyCryptoSubmitURL,
        body,
      );
      if (mapResponse != null) {
        BuyCryptoAutomaticModel result = BuyCryptoAutomaticModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from BuyCryptoSubmit api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* BuyCryptoTatum api services
  Future<BuyCryptoTatumModel?> buyCryptoTatumProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.buyCryptoSubmitURL,
        body,
      );
      if (mapResponse != null) {
        BuyCryptoTatumModel result = BuyCryptoTatumModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from BuyCryptoTatum api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* BuyCryptoTatumSubmit api services
  Future<CommonSuccessModel?> buyCryptoTatumSubmitProcessApi(
      {required Map<String, dynamic> body, required url}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        url,
        body,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from BuyCryptoTatumSubmit api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* Get BuyCryptoManual api services
  Future<BuyCryptoManualModel?> buyCryptoManualProcessApi(String alias) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
          "${ApiEndpoint.buyCryptoManualURL}?alias=$alias"
      );
      if (mapResponse != null) {
        BuyCryptoManualModel result = BuyCryptoManualModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from BuyCryptoManual api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* BuyCryptoManualSubmit api services
  Future<CommonSuccessModel?> buyCryptoManualSubmitProcessApi(
      {required Map<String, String> body,
        required List<String> pathList,
        required List<String> fieldList}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).multipartMultiFile(
        ApiEndpoint.buyCryptoManualSubmitURL,
        body,
        pathList: pathList,
        fieldList: fieldList,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from BuyCryptoManualSubmit api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }
}