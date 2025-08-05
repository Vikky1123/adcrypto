import 'dart:async';

import 'package:adcrypto/local_storage/local_storage.dart';

import '../../routes/routes.dart';
import '../../utils/basic_screen_imports.dart';

class OnboardController extends GetxController{

  RxDouble svg1 = 0.5.obs;
  RxDouble svg2 = 1.0.obs;
  RxBool animated = true.obs;

  late String fileId;
  late String logoWithText;

  @override
  void onInit() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (animated.value) {
        svg1.value = 1.0;
        svg2.value = 0.5;
        animated.value = false;
      } else if (!animated.value) {
        svg1.value = 0.2;
        svg2.value = 0.9;
        animated.value = true;
      } else {
        svg1.value = 0.5;
        svg2.value = 0.1;
      }
    });
    super.onInit();


  }

  void goToSignInScreen() {
   Get.offAllNamed(Routes.signInScreen);
   LocalStorage.saveOnboardDoneOrNot(isOnBoardDone: true);

  }

}