import 'package:get/get.dart';


import '../controller/auth/sign_in/sign_in_controller/sign_in_controller.dart';
import '../controller/auth/sign_up/sign_up_controller/sign_up_controller.dart';
import '../controller/splash_screen_controller.dart';


class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
    Get.put(SignUpController());
    Get.put(SignInController());
  }
}
