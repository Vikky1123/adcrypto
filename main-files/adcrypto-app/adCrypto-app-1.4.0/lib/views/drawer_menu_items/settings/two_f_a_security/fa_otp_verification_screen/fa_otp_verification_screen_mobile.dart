import 'package:adcrypto/backend/utils/custom_loading_api.dart';

import '../../../../../controller/drawer/settings/fa_controller.dart';
import '../../../../../utils/basic_screen_imports.dart';
import '../../../../../widgets/inputs/dynamic_otp_input_widget.dart';
import '../../../../../widgets/others/custom_back_button.dart';
import '../../../../../widgets/others/title_subtitle_widget.dart';


class FAOtpVerificationScreenMobile extends StatelessWidget {
  FAOtpVerificationScreenMobile({super.key});

  final forgotPasswordFormKey = GlobalKey<FormState>();
  final controller = Get.put(FAController());

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
        body: Obx(() => controller.isLoading ? const CustomLoadingAPI(): _bodyWidget(context)),
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
          _buttonWidget(context),
        ],
      ),
    );
  }

  _otpVerificationEmailTextWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.paddingVerticalSize * 3),
      child: TitleSubtitleWidget(
        title: Strings.oTPVerification.tr,
        subTitle: controller.faInfoModel.data.alert,
      ),
    );
  }

  //otp input widget
  _otpInputWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Dimensions.paddingSize * 3.2,
        left: Dimensions.paddingHorizontalSize,
        right: Dimensions.paddingHorizontalSize,
      ),
      child: Form(
        key: forgotPasswordFormKey,
        child: Column(
          children: [
            OtpInputWidget(
              controller: controller.otpController,
            )
          ],
        ),
      ),
    );
  }


  _buttonWidget(context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.paddingVerticalSize,
        horizontal: Dimensions.paddingHorizontalSize,
      ),
      child: Obx(() => controller.isFALoading
          ? const CustomLoadingAPI()
          : PrimaryButton(
              title: Strings.submit.tr,
              onPressed: () {
                if (forgotPasswordFormKey.currentState!.validate()) {
                  controller.fAVerifyProcess();
                }
              },
              borderColor: Get.isDarkMode
                  ? CustomColor.primaryDarkColor
                  : CustomColor.primaryLightColor,
              buttonColor: Get.isDarkMode
                  ? CustomColor.primaryDarkColor
                  : CustomColor.primaryLightColor,
            )),
    );
  }
}
