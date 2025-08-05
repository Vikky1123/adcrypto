import 'package:adcrypto/backend/utils/custom_loading_api.dart';

import '../../../../controller/drawer/settings/change_password_controller.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/inputs/password_input_widget.dart';
import '../../../../widgets/others/custom_back_button.dart';

class ChangePasswordScreenMobile extends StatelessWidget {
  ChangePasswordScreenMobile({super.key});

  final controller = Get.put(ChangePasswordController());

  final changePasswordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: CustomStyle.screenGradientBG,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColor.gradientColorTop,
          leading: CustomBackButton(
            onTap: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: TitleHeading3Widget(
            text: Strings.changePassword.tr,
          ),
        ),
        backgroundColor: CustomColor.transparentColor,
        body: _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize),
      children: [
        _passwordInputWidget(context),
        _buttonWidget(context),
      ],
    );
  }

  _passwordInputWidget(BuildContext context) {
    return Form(
      key: changePasswordFormKey,
      child: Padding(
        padding: EdgeInsets.only(top: Dimensions.paddingSize),
        child: Column(
          children: [
            PasswordInputWidget(
              hintText: Strings.enterOldPassword.tr,
              controller: controller.oldPasswordController,
              borderColor: Get.isDarkMode
                  ? CustomColor.primaryDarkTextColor.withOpacity(.15)
                  : CustomColor.primaryLightTextColor.withOpacity(.15),
              color: Get.isDarkMode
                  ? CustomColor.primaryBGDarkColor
                  : CustomColor.primaryBGLightColor,
              labelText: Strings.oldPassword,
            ),
            verticalSpace(Dimensions.heightSize),
            PasswordInputWidget(
              hintText: Strings.enterNewPassword.tr,
              controller: controller.newPasswordController,
              borderColor: Get.isDarkMode
                  ? CustomColor.primaryDarkTextColor.withOpacity(.15)
                  : CustomColor.primaryLightTextColor.withOpacity(.15),
              color: Get.isDarkMode
                  ? CustomColor.primaryBGDarkColor
                  : CustomColor.primaryBGLightColor,
              labelText: Strings.newPassword,
            ),
            verticalSpace(Dimensions.heightSize),
            PasswordInputWidget(
              hintText: Strings.enterConfirmPassword.tr,
              controller: controller.confirmNewPasswordController,
              borderColor: Get.isDarkMode
                  ? CustomColor.primaryDarkTextColor.withOpacity(.15)
                  : CustomColor.primaryLightTextColor.withOpacity(.15),
              color: Get.isDarkMode
                  ? CustomColor.primaryBGDarkColor
                  : CustomColor.primaryBGLightColor,
              labelText: Strings.confirmPassword,
            ),
          ],
        ),
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(top: Dimensions.marginSizeVertical * 1.5),
            child: Obx(
              () => controller.isLoading
                  ? const CustomLoadingAPI()
                  : PrimaryButton(
                      title: Strings.changePassword.tr,
                      fontWeight: FontWeight.normal,
                      buttonTextColor: Get.isDarkMode
                          ? CustomColor.primaryBGDarkColor
                          : CustomColor.primaryBGLightColor,
                      fontSize: Dimensions.headingTextSize3 * .88,
                      onPressed: () {
                        if (changePasswordFormKey.currentState!.validate()) {
                          controller.passwordChangeProcess();
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
      ],
    );
  }
}
