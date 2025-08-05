import 'package:adcrypto/backend/utils/custom_loading_api.dart';
import 'package:adcrypto/widgets/others/custom_snack_bar.dart';
import 'package:flutter/gestures.dart';

import '../../../../backend/language/language_controller.dart';
import '../../../../controller/auth/sign_up/sign_up_controller/sign_up_controller.dart';
import '../../../../controller/basic_settings_controller.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/inputs/password_input_widget.dart';
import '../../../../widgets/others/app_logo_widget.dart';
import '../../../../widgets/others/check_box_widget.dart';
import '../../../../widgets/others/title_subtitle_widget.dart';

class SignUpScreenMobile extends StatelessWidget {
  SignUpScreenMobile({super.key});

  final signUpFormKey = GlobalKey<FormState>();
  final controller = Get.put(SignUpController());

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

  //body widget
  _bodyWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: Dimensions.marginSizeVertical * .25,
      ),
      child: ListView(
        children: [
          _appLogoWidget(context),
          _welcomeTextWidget(context),
          _inputAndButtonWidget(context),
          _alreadyHaveAnAccount(context),
          verticalSpace(Dimensions.marginSizeVertical * .8)
        ],
      ),
    );
  }

  //app logo widget
  _appLogoWidget(BuildContext context) {
    return const AppLogoWidget();
  }

  //sign up welcome text widget
  _welcomeTextWidget(BuildContext context) {
    return TitleSubtitleWidget(
      title: Get.find<BasicSettingsController>().basicSettingsModel.data.register.first.title,
      subTitle: Get.find<BasicSettingsController>().basicSettingsModel.data.register.first.heading,
    );
  }

  //input And Button Widget contain sign up input form, privacy policy check , button widget
  _inputAndButtonWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingHorizontalSize * .75,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _signUpWidget(context),
          _privacyPolicyWidget(context),
          _buttonWidget(context),
        ],
      ),
    );
  }

  //sign up input widget for taking input first name last name email password
  _signUpWidget(BuildContext context) {
    return Form(
      key: signUpFormKey,
      child: Padding(
        padding: EdgeInsets.only(top: Dimensions.paddingSize),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: PrimaryTextInputWidget(
                    hintText: Strings.enterFirstName.tr,
                    controller: controller.firstNameController,
                    borderColor: Get.isDarkMode
                        ? CustomColor.primaryDarkTextColor.withOpacity(.15)
                        : CustomColor.primaryLightTextColor.withOpacity(.15),
                    color: Get.isDarkMode
                        ? CustomColor.primaryDarkColor.withOpacity(.08)
                        : CustomColor.primaryLightColor.withOpacity(.08),
                    labelText: Strings.firstName.tr,
                  ),
                ),
                horizontalSpace(Dimensions.widthSize),
                Expanded(
                  child: PrimaryTextInputWidget(
                    hintText: Strings.enterLastName.tr,
                    controller: controller.lastNameController,
                    borderColor: Get.isDarkMode
                        ? CustomColor.primaryDarkTextColor.withOpacity(.15)
                        : CustomColor.primaryLightTextColor.withOpacity(.15),
                    color: Get.isDarkMode
                        ? CustomColor.primaryDarkColor.withOpacity(.08)
                        : CustomColor.primaryLightColor.withOpacity(.08),
                    labelText: Strings.lastName.tr,
                  ),
                ),
              ],
            ),
            verticalSpace(Dimensions.heightSize),
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

  //privacy policy widget for agreeing with privacy
  _privacyPolicyWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: Dimensions.paddingSize * .5, left: Dimensions.paddingSize * .10),
      child: FittedBox(
        child: Row(
          crossAxisAlignment: crossStart,
          children: [
            CheckBoxWidget(
              isChecked: controller.isSelected,
              onChecked: (value) {
                controller.isSelected.value = value;
              },
            ),
          ],
        ),
      ),
    );
  }

  //sign up button widget
  _buttonWidget(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: Dimensions.marginSizeVertical),
          child: Obx(() => controller.isLoading ? const CustomLoadingAPI(): PrimaryButton(
            title: Strings.signUp.tr,
            fontWeight: FontWeight.normal,
            buttonTextColor: Get.isDarkMode
                ? CustomColor.primaryDarkTextColor
                : CustomColor.primaryLightTextColor,
            fontSize: Dimensions.headingTextSize3 * .88,
            onPressed: () {
              if (signUpFormKey.currentState!.validate()) {
                if (controller.isSelected.value == true) {
                  controller.registrationProcess();
                } else {
                  CustomSnackBar.error(
                      Strings.pleaseAcceptTermsAndConditions.tr);
                }
              }
            },
            borderColor: Get.isDarkMode
                ? CustomColor.primaryDarkColor
                : CustomColor.primaryLightColor,
            buttonColor: Get.isDarkMode
                ? CustomColor.primaryDarkColor
                : CustomColor.primaryLightColor,
          )),
        ),
      ],
    );
  }

  //already have an account and sign up button widget
  _alreadyHaveAnAccount(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: Get.find<LanguageSettingController>().isLoading ? "": Get.find<LanguageSettingController>().getTranslation(Strings.alreadyHaveAnAccount.tr),
              style: Get.isDarkMode
                  ? CustomStyle.darkHeading5TextStyle.copyWith(
                      color: CustomColor.primaryDarkTextColor.withOpacity(.30),
                      fontWeight: FontWeight.w600)
                  : CustomStyle.lightHeading5TextStyle.copyWith(
                      color: CustomColor.primaryLightTextColor.withOpacity(.30),
                      fontWeight: FontWeight.w600),
            ),
            WidgetSpan(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSize * 0.15,
                ),
              ),
            ),
            TextSpan(
              text: Get.find<LanguageSettingController>().isLoading ? "": Get.find<LanguageSettingController>().getTranslation(Strings.signIn.tr),
              style: Get.isDarkMode
                  ? CustomStyle.darkHeading5TextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: CustomColor.primaryDarkColor)
                  : CustomStyle.lightHeading5TextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: CustomColor.primaryLightColor),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  controller.goToSignInScreen();
                },
            )
          ],
        ),
      ),
    );
  }
}