import 'package:adcrypto/backend/model/common/common_success_model.dart';

import '../../../backend/services/auth_service/settings_service.dart';
import '../../../backend/utils/api_method.dart';
import '../../../local_storage/local_storage.dart';
import '../../../routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';

class SettingsController extends GetxController with SettingsService{


  goToKYCScreen() {
   Get.toNamed(Routes.kycFormScreen);
  }

  goToTwoFASecurityScreen() {
   Get.toNamed(Routes.twoFASecurityScreen);
  }

  goToChangePasswordScreen() {
    Get.toNamed(Routes.changePasswordScreen);
  }


  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late CommonSuccessModel _deleteAccountModel;
  CommonSuccessModel get deleteAccountModel => _deleteAccountModel;

  ///* DeleteAccount in process
  Future<CommonSuccessModel> deleteAccountProcess() async {
    _isLoading.value = true;
    update();

    await deleteAccountProcessApi(body: {}).then((value) {
      _deleteAccountModel = value!;
      _isLoading.value = false;
      LocalStorage.logout();
      Get.offAllNamed(Routes.signInScreen);
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _deleteAccountModel;
  }
}