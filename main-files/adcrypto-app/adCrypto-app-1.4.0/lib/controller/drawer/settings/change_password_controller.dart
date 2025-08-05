import 'package:adcrypto/backend/model/common/common_success_model.dart';

import '../../../../utils/basic_screen_imports.dart';
import '../../../backend/services/auth_service/settings_service.dart';
import '../../../backend/utils/api_method.dart';
import '../../../routes/routes.dart';

class ChangePasswordController extends GetxController with SettingsService{
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();


  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late CommonSuccessModel _passwordChangeModel;
  CommonSuccessModel get passwordChangeModel => _passwordChangeModel;

  ///* PasswordChange in process
  Future<CommonSuccessModel> passwordChangeProcess() async {
    _isLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'current_password': oldPasswordController.text,
      'password': newPasswordController.text,
      'password_confirmation': confirmNewPasswordController.text,
    };
    await passwordChangeProcessApi(body: inputBody).then((value) {
      _passwordChangeModel = value!;

      Get.offAllNamed(Routes.dashboardScreen);

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _passwordChangeModel;
  }
}