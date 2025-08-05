import 'package:adcrypto/backend/language/language_controller.dart';
import 'package:adcrypto/backend/utils/custom_loading_api.dart';

import '../../../../backend/language/language_drop_down.dart';
import '../../../../controller/drawer/settings/settings_controller.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/dialog_helper.dart';
import '../../../../widgets/others/custom_back_button.dart';

class SettingsScreenMobile extends StatelessWidget {
  SettingsScreenMobile({super.key});

  final controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Get.find<LanguageSettingController>().isLoading
        ? const SizedBox()
        : Container(
            decoration: CustomStyle.screenGradientBG,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: CustomColor.gradientColorTop,
                leading: CustomBackButton(
                  onTap: () => Navigator.pop(context),
                ),
                title: TitleHeading3Widget(
                  padding: EdgeInsets.only(left: Dimensions.paddingSize * 4),
                  text: Strings.settings.tr,
                ),
              ),
              backgroundColor: CustomColor.transparentColor,
              body: _bodyWidget(context),
            ),
          ));
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize * .75),
      physics: const BouncingScrollPhysics(),
      children: [
        _kycyWidget(context),
        _twoFaSecurityWidget(context),
        _changeLanguageWidget(context),
        _changePasswordWidget(context),
        _deleteAccountWidget(context),
      ],
    );
  }

  _kycyWidget(BuildContext context) {
    return InkWell(
      highlightColor: CustomColor.transparentColor,
      focusColor: CustomColor.transparentColor,
      hoverColor: CustomColor.transparentColor,
      splashColor: CustomColor.transparentColor,
      onTap: () {
        controller.goToKYCScreen();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleHeading4Widget(
            padding:
                EdgeInsets.symmetric(vertical: Dimensions.paddingSize * .2),
            text: Strings.kycVerification,
            fontWeight: FontWeight.normal,
            fontSize: Dimensions.headingTextSize3,
          ),
          Divider(
            thickness: Dimensions.radius * .1,
            color: CustomColor.whiteColor.withOpacity(.10),
          ),
        ],
      ),
    );
  }

  _twoFaSecurityWidget(BuildContext context) {
    return InkWell(
      highlightColor: CustomColor.transparentColor,
      focusColor: CustomColor.transparentColor,
      hoverColor: CustomColor.transparentColor,
      splashColor: CustomColor.transparentColor,
      onTap: () {
        controller.goToTwoFASecurityScreen();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleHeading4Widget(
            padding:
                EdgeInsets.symmetric(vertical: Dimensions.paddingSize * .2),
            text: Strings.twoFASecurity,
            fontWeight: FontWeight.normal,
            fontSize: Dimensions.headingTextSize3,
          ),
          Divider(
            thickness: Dimensions.radius * .1,
            color: CustomColor.whiteColor.withOpacity(.10),
          ),
        ],
      ),
    );
  }

  _changeLanguageWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: TitleHeading4Widget(
                padding:
                    EdgeInsets.symmetric(vertical: Dimensions.paddingSize * .2),
                text: Strings.changeLanguage,
                fontWeight: FontWeight.normal,
                fontSize: Dimensions.headingTextSize3,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingHorizontalSize * .5),
              child: const ChangeLanguageWidget(),
            ),
          ],
        ),
        Divider(
          thickness: Dimensions.radius * .1,
          color: CustomColor.whiteColor.withOpacity(.10),
        ),
      ],
    );
  }

  _changePasswordWidget(BuildContext context) {
    return InkWell(
      highlightColor: CustomColor.transparentColor,
      focusColor: CustomColor.transparentColor,
      hoverColor: CustomColor.transparentColor,
      splashColor: CustomColor.transparentColor,
      onTap: () {
        controller.goToChangePasswordScreen();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleHeading4Widget(
            padding:
                EdgeInsets.symmetric(vertical: Dimensions.paddingSize * .2),
            text: Strings.changePassword,
            fontWeight: FontWeight.normal,
            fontSize: Dimensions.headingTextSize3,
          ),
          Divider(
            thickness: Dimensions.radius * .1,
            color: CustomColor.whiteColor.withOpacity(.10),
          ),
        ],
      ),
    );
  }

  _deleteAccountWidget(BuildContext context) {
    return Obx(() => controller.isLoading
        ? const CustomLoadingAPI()
        : InkWell(
            highlightColor: CustomColor.transparentColor,
            focusColor: CustomColor.transparentColor,
            hoverColor: CustomColor.transparentColor,
            splashColor: CustomColor.transparentColor,
            onTap: () {
              DialogHelper.show(
                  context: context,
                  title: Strings.deleteAccount.tr,
                  subTitle: Strings.deleteAccountMessage.tr,
                  actionText: Strings.delete.tr,
                  action: () {
                    Get.close(1);
                    controller.deleteAccountProcess();
                  });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleHeading4Widget(
                  padding: EdgeInsets.symmetric(
                      vertical: Dimensions.paddingSize * .2),
                  text: Strings.deleteAccount,
                  fontWeight: FontWeight.normal,
                  fontSize: Dimensions.headingTextSize3,
                  color: CustomColor.redColor,
                ),
              ],
            ),
          ));
  }
}
