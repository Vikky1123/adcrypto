import 'package:adcrypto/backend/model/common/common_success_model.dart';

import '../../../widgets/others/custom_snack_bar.dart';
import '../../model/withdraw_crypto/withdraw_crypto_check_model.dart';
import '../../model/withdraw_crypto/withdraw_crypto_model.dart';
import '../../model/withdraw_crypto/withdraw_crypto_store_model.dart';
import '../../utils/api_method.dart';
import '../api_endpoint.dart';

mixin WithdrawCryptoService{
  ///* Get WithdrawCrypto api services
  Future<WithdrawCryptoModel?> withdrawCryptoProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
          ApiEndpoint.withdrawCryptoURL
      );
      if (mapResponse != null) {
        WithdrawCryptoModel result = WithdrawCryptoModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from WithdrawCrypto api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* WithdrawCryptoStore api services
  Future<WithdrawCryptoStoreModel?> withdrawCryptoStoreProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.withdrawCryptoStoreURL,
        body,
      );
      if (mapResponse != null) {
        WithdrawCryptoStoreModel result = WithdrawCryptoStoreModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from WithdrawCryptoStore api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* WithdrawCryptoConfirm api services
  Future<CommonSuccessModel?> withdrawCryptoConfirmProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.withdrawCryptoConfirmURL,
        body,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from WithdrawCryptoConfirm api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* Get WithdrawCryptoCheck api services
  Future<WithdrawCryptoCheckModel?> withdrawCryptoCheckProcessApi(String walletId) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
          "${ApiEndpoint.withdrawCryptoCheckURL}?wallet_address=$walletId"
      );
      if (mapResponse != null) {
        WithdrawCryptoCheckModel result = WithdrawCryptoCheckModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from WithdrawCryptoCheck api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }
}