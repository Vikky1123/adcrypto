import 'package:adcrypto/backend/model/common/common_success_model.dart';

import '../../../widgets/others/custom_snack_bar.dart';
import '../../model/sell_crypto/sell_crypto_model.dart';
import '../../model/sell_crypto/sell_crypto_payment_info_store.dart';
import '../../model/sell_crypto/sell_crypto_store_model.dart';
import '../../utils/api_method.dart';
import '../api_endpoint.dart';

mixin SellCryptoService {
  ///* Get SellCrypto api services
  Future<SellCryptoModel?> sellCryptoProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse =
          await ApiMethod(isBasic: false).get(ApiEndpoint.sellCryptoURL);
      if (mapResponse != null) {
        SellCryptoModel result = SellCryptoModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e(
          ':ladybug::ladybug::ladybug: err from SellCrypto api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* SellCryptoStore api services
  Future<SellCryptoStoreModel?> sellCryptoStoreProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.sellCryptoStoreURL,
        body,
      );
      if (mapResponse != null) {
        SellCryptoStoreModel result =
            SellCryptoStoreModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e(
          ':ladybug::ladybug::ladybug: err from SellCryptoStore api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* SellCryptoOutsideStore api services
  Future<CommonSuccessModel?> sellCryptoOutsideStoreProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.sellCryptoOutSideStoreURL,
        body,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(
          ':ladybug::ladybug::ladybug: err from SellCryptoOutsideStore api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* SellCryptoPaymentInfoStore api services
  Future<SellCryptoPaymentInfoStoreModel?> sellCryptoPaymentInfoStoreProcessApi(
      {required Map<String, String> body,
      required List<String> pathList,
      required List<String> fieldList}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).multipartMultiFile(
        ApiEndpoint.sellCryptoPaymentInfoStoreURL,
        body,
        pathList: pathList,
        fieldList: fieldList,
      );
      if (mapResponse != null) {
        SellCryptoPaymentInfoStoreModel result =
            SellCryptoPaymentInfoStoreModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e(
          ':ladybug::ladybug::ladybug: err from SellCryptoPaymentInfoStore api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* SellConfirmStore api services
  Future<CommonSuccessModel?> sellConfirmStoreProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.sellCryptoConfirmURL,
        body,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(
          ':ladybug::ladybug::ladybug: err from SellConfirmStore api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }
}
