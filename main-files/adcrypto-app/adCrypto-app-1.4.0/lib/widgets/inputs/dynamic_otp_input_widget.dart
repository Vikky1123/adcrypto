// ignore: file_names
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../backend/language/language_controller.dart';
import '../../utils/basic_screen_imports.dart';

class OtpInputWidget extends StatelessWidget {
  const OtpInputWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width * 0.89,
      color: Colors.transparent,
      child: PinCodeTextField(
        controller: controller,
        appContext: context,
        backgroundColor: Colors.transparent,
        textStyle: TextStyle(
          color: CustomColor.primaryLightColor,
        ),
        pastedTextStyle: TextStyle(
          color: Colors.orange.shade600,
          fontWeight: FontWeight.bold,
        ),
        length: 6,
        obscureText: false,
        blinkWhenObscuring: true,
        animationType: AnimationType.fade,
        validator: (String? value) {
          if (value!.isEmpty) {
            return Get.find<LanguageSettingController>().isLoading ? "": Get.find<LanguageSettingController>().getTranslation(Strings.pleaseFillOutTheField);
          } else {
            return null;
          }
        },
        errorTextMargin: const EdgeInsets.only(top: 4),
        pinTheme: PinTheme(
          fieldOuterPadding: const EdgeInsets.only(
              bottom: 4
          ),
          borderWidth: 0, // No border width
          shape: PinCodeFieldShape.underline,
          fieldHeight: 52,
          fieldWidth: 47,
          activeFillColor: Colors.transparent,
          inactiveColor: CustomColor.primaryLightTextColor.withOpacity(0.15),
          activeColor: CustomColor.primaryLightColor,
          selectedColor: CustomColor.primaryLightColor,

          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius * 0.8),
            topRight: Radius.circular(Dimensions.radius * 0.8),
          ),
        ),
        cursorColor: Get.isDarkMode
            ? CustomColor.whiteColor
            : CustomColor.secondaryDarkColor,
        animationDuration: const Duration(milliseconds: 300),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onCompleted: (v) {},
        beforeTextPaste: (text) {
          return true;
        },
      ),
    );
  }
}