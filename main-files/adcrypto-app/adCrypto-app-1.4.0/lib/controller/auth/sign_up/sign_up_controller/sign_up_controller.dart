
import '../../../../backend/model/auth/registration_model.dart';
import '../../../../backend/services/auth_service/auth_service.dart';
import '../../../../backend/utils/api_method.dart';
import '../../../../local_storage/local_storage.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../views/congratulation/congratulation_screen.dart';

class SignUpController extends GetxController with AuthService{
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool isSelected = false.obs;

  goToSignInScreen(){
    Get.toNamed(Routes.signInScreen);
  }


  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late RegistrationModel _registrationModel;
  RegistrationModel get registrationModel => _registrationModel;

  ///* Registration in process
  Future<RegistrationModel> registrationProcess() async {
    _isLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'first_name': firstNameController.text,
      'last_name': lastNameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'policy': isSelected.value ? "on" : ""
    };
    await registrationProcessApi(body: inputBody).then((value) {
      _registrationModel = value!;

      var data = _registrationModel.data;


      LocalStorage.saveToken(token: data.token);

      if(data.emailVerification){
        Get.toNamed(Routes.signUpOtpScreen);
      }
      else{
          LocalStorage.isLoginSuccess(isLoggedIn: true);
          Get.to(
                () => const CongratulationScreen(
              route: Routes.dashboardScreen,
              subTitle: Strings.signUpCongratulationSubtitle,
            ),
          );

      }


      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _registrationModel;
  }

}