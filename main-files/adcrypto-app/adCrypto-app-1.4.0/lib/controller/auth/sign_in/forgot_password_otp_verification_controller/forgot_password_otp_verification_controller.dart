import 'dart:async';
import 'package:adcrypto/backend/model/common/common_success_model.dart';

import '../../../../backend/services/auth_service/auth_service.dart';
import '../../../../backend/utils/api_method.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/basic_screen_imports.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../sign_in_controller/sign_in_controller.dart';

class ForgotPasswordOtpVerificationController extends GetxController
    with AuthService {
  final otpInputFieldController = TextEditingController();
  final pinCodeController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  var currentText = ''.obs;
  StreamSubscription? streamSubscription;

  changeCurrentText(value) {
    currentText.value = value;
  }

  @override
  void dispose() {
    pinCodeController.clear();
    errorController!.close(); // close the errorController stream
    streamSubscription?.cancel(); // cancel the stream subscription
    super.dispose();
  }

  @override
  void onInit() {
    errorController = StreamController<
        ErrorAnimationType>.broadcast(); // create a broadcast stream
    timerInit();
    super.onInit();
  }

  timerInit() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (minuteRemaining.value != 0) {
        secondsRemaining.value--;
        if (secondsRemaining.value == 0) {
          secondsRemaining.value = 59;
          minuteRemaining.value = 0;
        }
      } else if (minuteRemaining.value == 0 && secondsRemaining.value != 0) {
        secondsRemaining.value--;
      } else {
        enableResend.value = true;
      }
    });
  }

  RxInt secondsRemaining = 59.obs;
  RxInt minuteRemaining = 00.obs;
  RxBool enableResend = false.obs;
  Timer? timer;

  resendCode() {
    timer?.cancel();
    secondsRemaining.value = 59;
    enableResend.value = false;
    timerInit();
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late CommonSuccessModel _forgotPassVerifyModel;
  CommonSuccessModel get forgotPassVerifyModel => _forgotPassVerifyModel;

  ///* ForgotPassVerify in process
  Future<CommonSuccessModel> forgotPassVerifyProcess() async {
    _isLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'token': Get.find<SignInController>().forgetPasswordModel.data.token,
      'code': pinCodeController.text
    };
    await forgotPassVerifyProcessApi(body: inputBody).then((value) {
      _forgotPassVerifyModel = value!;

      Get.toNamed(Routes.resetPasswordScreen);

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _forgotPassVerifyModel;
  }

  final _isResendLoading = false.obs;
  bool get isResendLoading => _isResendLoading.value;

  late CommonSuccessModel _resendOTPModel;
  CommonSuccessModel get resendOTPModel => _resendOTPModel;

  ///* Get ResendOTP in process
  Future<CommonSuccessModel> resendOTPProcess() async {
    _isResendLoading.value = true;
    update();
    await resendOTPProcessApi(
            token: Get.find<SignInController>().forgetPasswordModel.data.token)
        .then((value) {
      _resendOTPModel = value!;

      resendCode();

      _isResendLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isResendLoading.value = false;
    update();
    return _resendOTPModel;
  }
}
