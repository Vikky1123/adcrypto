import 'dart:async';

import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../backend/model/common/common_success_model.dart';
import '../../../../backend/services/auth_service/auth_service.dart';
import '../../../../backend/utils/api_method.dart';
import '../../../../local_storage/local_storage.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../views/congratulation/congratulation_screen.dart';

class SignUpOtpVerificationController extends GetxController with AuthService{
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

  void listenToStream() {
    // cancel any existing subscription
    streamSubscription?.cancel();

    // listen to the stream
    streamSubscription = errorController!.stream.listen((errorAnimationType) {
      // do something with the error
    });
  }


  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late CommonSuccessModel _registerVerifyModel;
  CommonSuccessModel get registerVerifyModel => _registerVerifyModel;

  ///* RegisterVerify in process
  Future<CommonSuccessModel> registerVerifyProcess() async {
    _isLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'code': pinCodeController.text,
    };
    await registerVerifyProcessApi(body: inputBody).then((value) {
      _registerVerifyModel = value!;

      LocalStorage.isLoginSuccess(isLoggedIn: true);

      Get.to(
            () => const CongratulationScreen(
          route: Routes.dashboardScreen,
          subTitle: Strings.signUpCongratulationSubtitle,
        ),
      );

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _registerVerifyModel;
  }

  final _isResendLoading = false.obs;
  bool get isResendLoading => _isResendLoading.value;

  late CommonSuccessModel _registerResendModel;
  CommonSuccessModel get registerResendModel => _registerResendModel;


  ///* Get RegisterResend in process
  Future<CommonSuccessModel> registerResendProcess() async {
    _isResendLoading.value = true;
    update();
    await registerResendProcessApi().then((value) {
      _registerResendModel = value!;
      resendCode();
      _isResendLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isResendLoading.value = false;
    update();
    return _registerResendModel;
  }
}