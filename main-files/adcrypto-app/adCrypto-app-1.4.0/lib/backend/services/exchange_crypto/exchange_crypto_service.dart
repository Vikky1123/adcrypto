import 'package:adcrypto/backend/model/common/common_success_model.dart';

import '../../../widgets/others/custom_snack_bar.dart';
import '../../model/exchange_crypto/exchange_crypto_model.dart';
import '../../model/exchange_crypto/exchange_crypto_store_model.dart';
import '../../utils/api_method.dart';
import '../api_endpoint.dart';

mixin ExchangeCryptoService{
  ///* Get ExchangeCrypto api services
  Future<ExchangeCryptoModel?> exchangeCryptoProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
          ApiEndpoint.exchangeCryptoURL
      );
      if (mapResponse != null) {
        ExchangeCryptoModel result = ExchangeCryptoModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from ExchangeCrypto api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* ExchangeCryptoStore api services
  Future<ExchangeCryptoStoreModel?> exchangeCryptoStoreProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.exchangeCryptoStoreURL,
        body,
      );
      if (mapResponse != null) {
        ExchangeCryptoStoreModel result = ExchangeCryptoStoreModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from ExchangeCryptoStore api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* ExchangeCryptoConfirm api services
  Future<CommonSuccessModel?> exchangeCryptoConfirmProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.exchangeCryptoConfirmURL,
        body,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from ExchangeCryptoConfirm api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }
}