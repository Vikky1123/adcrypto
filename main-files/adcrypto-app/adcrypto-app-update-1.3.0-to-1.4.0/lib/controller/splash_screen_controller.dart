
import 'package:adcrypto/local_storage/local_storage.dart';
import 'package:get/get.dart';

import '../backend/utils/navigator_plug.dart';
import '../routes/routes.dart';

class SplashController extends GetxController {
  final navigatorPlug = NavigatorPlug();

  @override
  void onReady() {
    super.onReady();
    navigatorPlug.startListening(
      seconds: 3,
      onChanged: () {
        LocalStorage.isLoggedIn()
            ? Get.offAndToNamed(Routes.dashboardScreen)
            : Get.offAndToNamed(
          LocalStorage.isOnBoardDone()
              ? Routes.signInScreen
              : Routes.onboardScreen,
        );
      },
    );
  }

  @override
  void onClose() {
    navigatorPlug.stopListening();
    super.onClose();
  }
}