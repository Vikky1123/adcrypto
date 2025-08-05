import 'dart:ui';
import 'package:adcrypto/backend/utils/custom_loading_api.dart';
import 'package:flutter/gestures.dart';

import '../../../../backend/language/language_controller.dart';
import '../../../../controller/auth/sign_in/sign_in_controller/sign_in_controller.dart';
import '../../../../controller/basic_settings_controller.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/buttons/outside_click_listener.dart';
import '../../../../widgets/inputs/password_input_widget.dart';
import '../../../../widgets/others/app_logo_widget.dart';
import '../../../../widgets/others/title_subtitle_widget.dart';

class SignInScreenMobile extends StatelessWidget {
  SignInScreenMobile({super.key});

  final signInformKey = GlobalKey<FormState>();
  final forgotPasswordFormKey = GlobalKey<FormState>();
  final controller = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: CustomStyle.screenGradientBG,
      child: Scaffold(
        backgroundColor: CustomColor.transparentColor,
        body: _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.marginSizeVertical),
      child: ListView(
        children: [
          _appLogoWidget(context),
          _welcomeTextWidget(context),
          _inputAndButtonWidget(context),
          _doNotHaveAnAccount(context),
        ],
      ),
    );
  }

  _appLogoWidget(BuildContext context) {
    return const AppLogoWidget();
  }

  _welcomeTextWidget(BuildContext context) {
    return TitleSubtitleWidget(
      title: Get.find<BasicSettingsController>()
          .basicSettingsModel
          .data
          .login
          .first
          .title,
      subTitle: Get.find<BasicSettingsController>()
          .basicSettingsModel
          .data
          .login
          .first
          .heading,
    );
  }

  _inputAndButtonWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSize,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _loginWidget(context),
          _forgotPasswordWidget(context),
          _buttonWidget(context),
        ],
      ),
    );
  }

  _loginWidget(BuildContext context) {
    return Form(
      key: signInformKey,
      child: Padding(
        padding: EdgeInsets.only(top: Dimensions.paddingSize * 1.5),
        child: Column(
          children: [
            PrimaryTextInputWidget(
              keyboardType: TextInputType.emailAddress,
              hintText: Strings.enterEmailAddress.tr,
              controller: controller.emailController,
              borderColor: Get.isDarkMode
                  ? CustomColor.primaryDarkTextColor.withOpacity(.15)
                  : CustomColor.primaryLightTextColor.withOpacity(.15),
              color: Get.isDarkMode
                  ? CustomColor.primaryDarkColor.withOpacity(.08)
                  : CustomColor.primaryLightColor.withOpacity(.08),
              labelText: Strings.emailAddress,
            ),
            verticalSpace(Dimensions.heightSize),
            PasswordInputWidget(
              hintText: Strings.enterPassword.tr,
              controller: controller.passwordController,
              borderColor: Get.isDarkMode
                  ? CustomColor.primaryDarkTextColor.withOpacity(.15)
                  : CustomColor.primaryLightTextColor.withOpacity(.15),
              color: Get.isDarkMode
                  ? CustomColor.primaryBGDarkColor
                  : CustomColor.primaryBGLightColor,
              labelText: Strings.password,
            ),
          ],
        ),
      ),
    );
  }

  _forgotPasswordWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: Dimensions.paddingSize * .20,
          bottom: Dimensions.paddingSize * .5),
      child: GestureDetector(
        onTap: () {
          _showForgotPasswordDialog(context);
        },
        child: Row(
          mainAxisAlignment: mainEnd,
          children: [
            CustomTitleHeadingWidget(
              text: Strings.forgotPassword.tr,
              style: CustomStyle.lightHeading5TextStyle.copyWith(
                  color: CustomColor.primaryLightColor,
                  fontSize: Dimensions.headingTextSize4,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  _showForgotPasswordDialog(BuildContext context) {
    return Get.dialog(
      FractionallySizedBox(
        widthFactor: 1.1,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5,
            sigmaY: 5,
          ),
          child: Container(
            color: Colors.white.withOpacity(.05),
            child: OutsideClickListener(
              onTap: () {
                debugPrint("Close Dialog Pressed");
                Get.close(1);
              },
              child: Dialog(
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: CustomColor.dialogColor,
                        borderRadius: BorderRadius.circular(Dimensions.radius),
                      ),
                      padding: EdgeInsets.only(
                        top: Dimensions.paddingSize * 0.75,
                        bottom: Dimensions.paddingSize * 0.75,
                      ),
                      child: Form(
                        key: forgotPasswordFormKey,
                        child: Column(
                          mainAxisSize: mainMin,
                          crossAxisAlignment: crossStart,
                          children: [
                            SizedBox(
                              child: TitleSubtitleWidget(
                                title: Strings.forgotPassword.tr,
                                subTitle:
                                    Strings.enterYourEmailToResetPassword.tr,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: Dimensions.marginBetweenInputBox,
                                top: Dimensions.marginBetweenInputBox,
                                right: Dimensions.marginSizeHorizontal,
                                left: Dimensions.marginSizeHorizontal,
                              ),
                              child: PrimaryTextInputWidget(
                                controller:
                                    controller.forgotPasswordEmailController,
                                hintText: Strings.enterEmailAddress.tr,
                                labelText: Strings.emailAddress.tr,
                                keyboardType: TextInputType.emailAddress,
                                borderColor: Get.isDarkMode
                                    ? CustomColor.primaryDarkTextColor
                                        .withOpacity(.15)
                                    : CustomColor.primaryLightTextColor
                                        .withOpacity(.15),
                                color: Get.isDarkMode
                                    ? CustomColor.primaryBGDarkColor
                                    : CustomColor.primaryBGLightColor,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        Dimensions.marginSizeHorizontal),
                                child: Obx(
                                  () => controller.isForgetLoading
                                      ? const CustomLoadingAPI()
                                      : PrimaryButton(
                                          title: Strings
                                              .forgotPasswordSecondary.tr,
                                          onPressed: () {
                                            if (forgotPasswordFormKey
                                                .currentState!
                                                .validate()) {
                                              controller
                                                  .forgetPasswordProcess();
                                            }
                                          },
                                          borderColor: Get.isDarkMode
                                              ? CustomColor.primaryDarkColor
                                              : CustomColor.primaryLightColor,
                                          buttonColor: Get.isDarkMode
                                              ? CustomColor.primaryDarkColor
                                              : CustomColor.primaryLightColor,
                                        ),
                                )),
                            verticalSpace(Dimensions.heightSize),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      // top: -32,
                      child: InkWell(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius * 10),
                        onTap: () {
                          debugPrint("Close Dialog Pressed");
                          Get.close(1);
                        },
                        child: CircleAvatar(
                          radius: Dimensions.radius * 1.2,
                          backgroundColor: CustomColor.primaryLightColor,
                          child: const Icon(
                            Icons.close_rounded,
                            color: CustomColor.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return Column(
      children: [
        verticalSpace(Dimensions.heightSize * 1.58),
        Obx(() => controller.isLoading
            ? const CustomLoadingAPI()
            : PrimaryButton(
                title: Strings.signIn.tr,
                fontWeight: FontWeight.w700,
                buttonTextColor: CustomColor.primaryBGLightColor,
                fontSize: Dimensions.headingTextSize3,
                onPressed: () {
                  if (signInformKey.currentState!.validate()) {
                    controller.goToDashboardScreen();
                  }
                },
                borderColor: CustomColor.primaryLightColor,
                buttonColor: CustomColor.primaryLightColor,
              )),
        verticalSpace(Dimensions.heightSize * 1.58),
      ],
    );
  }

  _doNotHaveAnAccount(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: Get.find<LanguageSettingController>().isLoading ? "": Get.find<LanguageSettingController>().getTranslation(Strings.doNotHaveAnAccount.tr),
              style: CustomStyle.lightHeading4TextStyle.copyWith(
                  color: CustomColor.primaryLightTextColor.withOpacity(.60),
                  fontWeight: FontWeight.w500),
            ),
            WidgetSpan(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingHorizontalSize * 0.08,
                ),
              ),
            ),
            TextSpan(
              text: Get.find<LanguageSettingController>().isLoading ? "": Get.find<LanguageSettingController>().getTranslation(Strings.signUp.tr),
              style: CustomStyle.lightHeading4TextStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  color: CustomColor.primaryLightColor),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  controller.goToSignUpScreen();
                },
            )
          ],
        ),
      ),
    );
  }
}
