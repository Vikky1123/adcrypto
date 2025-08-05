import '../../../../backend/utils/custom_loading_api.dart';
import '../../../../controller/auth/sign_in/reset_password_controller/reset_password_controller.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/inputs/password_input_widget.dart';
import '../../../../widgets/others/custom_back_button.dart';

class ResetPasswordScreenMobile extends StatelessWidget {
  ResetPasswordScreenMobile({super.key});

  final controller = Get.put(ResetPasswordController());
  final resetNewPasswordFormKey = GlobalKey<FormState>();
  final resetConfirmPasswordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(Routes.signInScreen);
        return true;
      },
      child: Container(
        decoration: CustomStyle.screenGradientBG,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: CustomColor.transparentColor,
            leading: Padding(
              padding:
                  EdgeInsets.only(left: Dimensions.paddingVerticalSize * .4),
              child: CustomBackButton(
                onTap: () => Navigator.pop(context),
              ),
            ),
            title: TitleHeading3Widget(
              padding: EdgeInsets.only(left: Dimensions.paddingSize * 3),
              text: Strings.resetPassword.tr,
            ),
          ),
          backgroundColor: CustomColor.transparentColor,
          body: _bodyWidget(context),
        ),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return Column(
      children: [
        // verticalSpace(Dimensions.heightSize * 3.5),

        _inputFieldWidget(context),
      ],
    );
  }

  _inputFieldWidget(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          left: Dimensions.paddingSize,
          right: Dimensions.paddingSize,
          // top: Dimensions.paddingSize * 1.33,
        ),
        child: Column(
          crossAxisAlignment: crossStart,
          children: [
            _newPasswordInputWidget(context),
            _confirmPasswordInputWidget(context),
            const Spacer(),
            _resetPasswordButtonWidget(context),
            verticalSpace(Dimensions.paddingVerticalSize)
          ],
        ),
      ),
    );
  }

//new password input widget
  _newPasswordInputWidget(BuildContext context) {
    return Form(
      key: resetNewPasswordFormKey,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Dimensions.marginBetweenInputBox * .25),
        child: PasswordInputWidget(
          controller: controller.newPassword,
          hintText: Strings.enterNewPassword.tr,
          labelText: Strings.newPassword.tr,
          borderColor: Get.isDarkMode
              ? CustomColor.primaryDarkTextColor.withOpacity(.15)
              : CustomColor.primaryLightTextColor.withOpacity(.15),
          color: Get.isDarkMode
              ? CustomColor.primaryBGDarkColor
              : CustomColor.primaryBGLightColor,
        ),
      ),
    );
  }

//confirm password input widget
  _confirmPasswordInputWidget(BuildContext context) {
    return Form(
      key: resetConfirmPasswordFormKey,
      child: Padding(
        padding:
            EdgeInsets.symmetric(vertical: Dimensions.marginBetweenInputBox),
        child: PasswordInputWidget(
          controller: controller.confirmPassword,
          hintText: Strings.enterConfirmPassword.tr,
          labelText: Strings.confirmPassword.tr,
          borderColor: Get.isDarkMode
              ? CustomColor.primaryDarkTextColor.withOpacity(.15)
              : CustomColor.primaryLightTextColor.withOpacity(.15),
          color: Get.isDarkMode
              ? CustomColor.primaryBGDarkColor
              : CustomColor.primaryBGLightColor,
        ),
      ),
    );
  }

//reset password button
  _resetPasswordButtonWidget(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: Dimensions.paddingSize),
        child: Obx(
          () => controller.isLoading
              ? const CustomLoadingAPI()
              : PrimaryButton(
                  title: Strings.resetPassword.tr,
                  onPressed: () {
                    if (resetNewPasswordFormKey.currentState!.validate() &&
                        resetConfirmPasswordFormKey.currentState!.validate()) {
                      controller.resetPasswordProcess();
                    }
                  },
                  borderColor: CustomColor.primaryLightColor,
                  buttonColor: CustomColor.primaryLightColor,
                ),
        ));
  }
}
