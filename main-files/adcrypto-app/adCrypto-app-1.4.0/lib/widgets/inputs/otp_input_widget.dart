import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../backend/language/language_controller.dart';
import '../../controller/auth/sign_in/forgot_password_otp_verification_controller/forgot_password_otp_verification_controller.dart';
import '../../utils/basic_screen_imports.dart';

class ForgotPasswordOtpInputWidget extends StatelessWidget {
  const ForgotPasswordOtpInputWidget({
    super.key,
    required this.forgotPasswordFormKey,
    required this.controller,
  });

  final GlobalKey<FormState> forgotPasswordFormKey;
  final ForgotPasswordOtpVerificationController controller;

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width * 0.89,
      color: Colors.transparent,
      child: Form(
        key: forgotPasswordFormKey,
        child: PinCodeTextField(
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
            // borderWidth: Dimensions.widthSize * 0.2,
            // shape: PinCodeFieldShape.box,
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
              ? CustomColor.primaryDarkColor
              : CustomColor.primaryLightColor,
          animationDuration: const Duration(milliseconds: 300),
          errorAnimationController: controller.errorController,
          controller: controller.pinCodeController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onCompleted: (v) {},
          onChanged: (value) {
            controller.changeCurrentText(value);
          },
          beforeTextPaste: (text) {
            return true;
          },
        ),
      ),
    );
  }
}