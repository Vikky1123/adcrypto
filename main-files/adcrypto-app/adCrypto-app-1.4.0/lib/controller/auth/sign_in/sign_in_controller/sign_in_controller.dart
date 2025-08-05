import '../../../../backend/model/auth/forgot_password_model.dart';
import '../../../../backend/model/auth/login_model.dart';
import '../../../../backend/services/auth_service/auth_service.dart';
import '../../../../backend/utils/api_method.dart';
import '../../../../local_storage/local_storage.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/basic_screen_imports.dart';

class SignInController extends GetxController with AuthService{
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final forgotPasswordEmailController = TextEditingController();



  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  goToResetPasswordScreen() {
    Get.toNamed(Routes.resetPasswordScreen);
  }

  goToSignUpScreen() {
    Get.toNamed(Routes.signUpScreen);
  }


  goToDashboardScreen() {
    loginProcess();
  }

  final _isLoading = false.obs;
  late LoginModel _loginModel;

  bool get isLoading => _isLoading.value;
  LoginModel get loginModel => _loginModel;

  ///* Login in process
  Future<LoginModel> loginProcess() async {
    _isLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'email': emailController.text,
      'password': passwordController.text,
    };

    await loginProcessApi(body: inputBody).then((value) {
      _loginModel = value!;

      var data = _loginModel.data.userData.user;
      LocalStorage.saveToken(token: _loginModel.data.userData.token);

      if(data.emailVerified == 1){
        if(data.kycVerified == 0 && _loginModel.data.kycVerification){
          Get.toNamed(Routes.kycFormScreen);
        }
        else{
          if(data.twoFactorStatus == 0){
            LocalStorage.isLoginSuccess(isLoggedIn: true);
            Get.offAllNamed(Routes.dashboardScreen);
          }else{
            Get.toNamed(Routes.faOtpVerificationScreen);
          }

        }
      }
      else{
        Get.toNamed(Routes.signUpOtpScreen);
      }


      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _loginModel;
  }

  final _isForgetLoading = false.obs;
  bool get isForgetLoading => _isForgetLoading.value;

  late ForgetPasswordModel _forgetPasswordModel;
  ForgetPasswordModel get forgetPasswordModel => _forgetPasswordModel;

  ///* ForgetPassword in process
  Future<ForgetPasswordModel> forgetPasswordProcess() async {
    _isForgetLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'credentials': forgotPasswordEmailController.text,
    };
    await forgetPasswordProcessApi(body: inputBody).then((value) {
      _forgetPasswordModel = value!;

      Get.toNamed(Routes.forgotPasswordOtpScreen);


      _isForgetLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isForgetLoading.value = false;
    update();
    return _forgetPasswordModel;
  }
}