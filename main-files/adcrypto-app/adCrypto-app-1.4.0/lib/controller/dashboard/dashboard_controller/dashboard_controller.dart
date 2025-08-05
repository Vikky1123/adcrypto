import 'package:adcrypto/backend/model/common/common_success_model.dart';

import '../../../backend/model/buy_crypto/buy_crypto_model.dart';
import '../../../backend/services/auth_service/settings_service.dart';
import '../../../backend/utils/api_method.dart';
import '../../../local_storage/local_storage.dart';
import '../../../routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../views/dashboard/currency_detail/currency_detail_screen.dart';

class DashBoardController extends GetxController with SettingsService{

  void viewMore() {
    Get.toNamed(Routes.viewMoreScreen);
  }

  void viewDetail(Currency currency) {
    Get.to(CurrencyDetailScreen(currency: currency,));
  }


  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late CommonSuccessModel _logOutModel;
  CommonSuccessModel get logOutModel => _logOutModel;

  ///* LogOut in process
  Future<CommonSuccessModel> logOutProcess() async {
    _isLoading.value = true;
    update();

    await logOutProcessApi(body: {}).then((value) {
      _logOutModel = value!;

      LocalStorage.logout();
      Get.offAllNamed(Routes.signInScreen);

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _logOutModel;
  }


}