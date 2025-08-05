

import 'package:adcrypto/backend/services/auth_service/settings_service.dart';

import '../../../backend/model/auth/fa_info_model.dart';
import '../../../backend/model/common/common_success_model.dart';
import '../../../backend/utils/api_method.dart';
import '../../../local_storage/local_storage.dart';
import '../../../routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';

class FAController extends GetxController with SettingsService{

  final otpController = TextEditingController();

  @override
  void onInit() {
    faInfoGetProcess();
    super.onInit();
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }


  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late FaInfoModel _faInfoModel;
  FaInfoModel get faInfoModel => _faInfoModel;

  ///* Get FaInfo in process
  Future<FaInfoModel> faInfoGetProcess() async {
    _isLoading.value = true;
    update();
    await faInfoProcessApi().then((value) {
      _faInfoModel = value!;
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _faInfoModel;
  }



  final _isStatusUpdateLoading = false.obs;
  bool get isStatusUpdateLoading => _isStatusUpdateLoading.value;

  late CommonSuccessModel _commonSuccessModel;
  CommonSuccessModel get commonSuccessModel => _commonSuccessModel;

  ///* CommonSuccess in process
  Future<CommonSuccessModel> faStatusUpdateProcess() async {
    _isStatusUpdateLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'status': faInfoModel.data.qrStatus == 0 ? 1: 0,
    };
    await faStatusUpdateProcessApi(body: inputBody).then((value) {
      _commonSuccessModel = value!;

      faInfoGetProcess();
      _isStatusUpdateLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isStatusUpdateLoading.value = false;
    update();
    return _commonSuccessModel;
  }




  final _isFALoading = false.obs;
  bool get isFALoading => _isFALoading.value;

  late CommonSuccessModel _fAVerifyModel;
  CommonSuccessModel get fAVerifyModel => _fAVerifyModel;

  ///* FAVerify in process
  Future<CommonSuccessModel> fAVerifyProcess() async {
    _isFALoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'otp': otpController.text,
    };
    await fAVerifyProcessApi(body: inputBody).then((value) {
      _fAVerifyModel = value!;
      LocalStorage.isLoginSuccess(isLoggedIn: true);
      Get.offAllNamed(Routes.dashboardScreen);
      _isFALoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isFALoading.value = false;
    update();
    return _fAVerifyModel;
  }
}