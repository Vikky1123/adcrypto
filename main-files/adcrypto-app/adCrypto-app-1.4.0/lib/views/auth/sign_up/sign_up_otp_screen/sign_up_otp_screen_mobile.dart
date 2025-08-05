import 'package:adcrypto/backend/utils/custom_loading_api.dart';

import '../../../../backend/language/language_controller.dart';
import '../../../../controller/auth/sign_up/sign_up_controller/sign_up_controller.dart';
import '../../../../controller/auth/sign_up/sign_up_otp_verification_controller/sign_up_otp_verification_controller.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/inputs/sign_up_otp_input_widget.dart';
import '../../../../widgets/others/custom_back_button.dart';
import '../../../../widgets/others/title_subtitle_widget.dart';

class SignUpOtpScreenMobile extends StatelessWidget {
  SignUpOtpScreenMobile({super.key});

  final signUpOtpFormKey = GlobalKey<FormState>();
  final signUpController = Get.put(SignUpController());
  final controller = Get.put(SignUpOtpVerificationController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: CustomStyle.screenGradientBG,
      child: Scaffold(
        backgroundColor: CustomColor.transparentColor,
        appBar: AppBar(
          backgroundColor: CustomColor.transparentColor,
          leading: CustomBackButton(
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        _otpWidget(context),
      ],
    );
  }

  _otpWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.radius * 4),
          topRight: Radius.circular(Dimensions.radius * 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          _otpVerificationEmailTextWidget(context),
          _otpInputWidget(context),
          _timerWidget(context),
          _buttonWidget(context),
        ],
      ),
    );
  }

  //otp verification subString and user provided email text widget
  _otpVerificationEmailTextWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: Dimensions.paddingVerticalSize * 3,
          right: Dimensions.paddingVerticalSize * .5),
      child: TitleSubtitleWidget(
        title: Strings.emailVerification.tr,
        subTitle: "${Get.find<LanguageSettingController>().isLoading ? "" : Get.find<LanguageSettingController>().getTranslation(Strings.enterVerificationCodeTextOne)} ${signUpController.emailController.text.tr} ${Get.find<LanguageSettingController>().isLoading ? "" : Get.find<LanguageSettingController>().getTranslation(Strings.enterSignUpVerificationCodeTextTwo)}",
      ),
    );
  }

  //otp input widget
  _otpInputWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: Dimensions.heightSize * 2, left: Dimensions.widthSize * 2),
      child: SignUpOtpInputWidget(
        signUpOtpFormKey: signUpOtpFormKey,
        controller: controller,
      ),
    );
  }

  _timerWidget(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TitleHeading4Widget(
                text: Strings.didNotGetCode,
                color: CustomColor.whiteColor.withOpacity(.6),
              ),
              verticalSpace(Dimensions.widthSize * 4),
              horizontalSpace(Dimensions.widthSize),
              TitleHeading4Widget(
                text:
                    ' 0${controller.minuteRemaining.value}:${controller.secondsRemaining.value}',
                color: Get.isDarkMode
                    ? CustomColor.whiteColor
                    : CustomColor.primaryLightColor,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          controller.secondsRemaining.value > 0
              ? SizedBox(
                  height: Dimensions.heightSize,
                )
              : _textAndTextButtonWidget(context),
        ],
      ),
    );
  }

  _textAndTextButtonWidget(BuildContext context) {
    return Obx(() => controller.isResendLoading
        ? const CustomLoadingAPI()
        : Container(
            decoration: BoxDecoration(
                color: Get.isDarkMode
                    ? CustomColor.whiteColor
                    : CustomColor.primaryLightColor.withOpacity(.20),
                borderRadius: BorderRadius.circular(Dimensions.radius * 2.5)),
            margin: EdgeInsets.only(
                top: Dimensions.marginSizeVertical * 1.5,
                bottom: Dimensions.marginSizeVertical),
            padding: EdgeInsets.symmetric(
                vertical: Dimensions.heightSize,
                horizontal: Dimensions.widthSize * 2),
            child: InkWell(
              onTap: controller.registerResendProcess,
              child: CustomTitleHeadingWidget(
                text: Strings.resend.tr,
                style: Get.isDarkMode
                    ? CustomStyle.darkHeading5TextStyle.copyWith(
                        color: CustomColor.primaryDarkColor,
                        fontSize: Dimensions.headingTextSize4)
                    : CustomStyle.lightHeading5TextStyle.copyWith(
                        color: CustomColor.primaryLightColor,
                        fontSize: Dimensions.headingTextSize4),
              ),
            ),
          ));
  }

  _buttonWidget(context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            vertical: Dimensions.marginSizeVertical,
            horizontal: Dimensions.paddingHorizontalSize),
        child: Obx(
          () => controller.isLoading
              ? const CustomLoadingAPI()
              : PrimaryButton(
                  title: Strings.submit.tr,
                  onPressed: () {
                    if (signUpOtpFormKey.currentState!.validate()) {
                      controller.registerVerifyProcess();
                    }
                  },
                  borderColor: Get.isDarkMode
                      ? CustomColor.primaryDarkColor
                      : CustomColor.primaryLightColor,
                  buttonColor: Get.isDarkMode
                      ? CustomColor.primaryDarkColor
                      : CustomColor.primaryLightColor,
                ),
        ));
  }
}
