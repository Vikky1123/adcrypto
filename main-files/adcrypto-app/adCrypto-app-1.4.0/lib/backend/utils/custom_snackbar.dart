import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../language/language_controller.dart';

class CustomSnackBar {
  static success(String message) {
    return Get.snackbar('Success', Get.find<LanguageSettingController>().isLoading ? "": Get.find<LanguageSettingController>().getTranslation(message),
        backgroundColor: Colors.green, colorText: Colors.white);
  }

  static error(String message) {
    return Get.snackbar('Alert', Get.find<LanguageSettingController>().isLoading ? "": Get.find<LanguageSettingController>().getTranslation(message),
        backgroundColor: Colors.red, colorText: Colors.white);
  }
}
