import 'package:adcrypto/backend/utils/custom_loading_api.dart';

import '../../../../controller/drawer/settings/fa_controller.dart';
import '../../../../utils/basic_widget_imports.dart';
import '../../../../widgets/buttons/primary_button.dart';
import '../../../../widgets/others/custom_back_button.dart';
import '../../../../widgets/text_labels/title_heading5_widget.dart';

class TwoFASecurityScreenMobile extends StatelessWidget {
  TwoFASecurityScreenMobile({super.key});

  final controller = Get.put(FAController());

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
            text: Strings.twoFASecurity.tr,
          ),
        ),
        backgroundColor: CustomColor.transparentColor,
        body: Obx(() => controller.isLoading
            ? const CustomLoadingAPI()
            : _bodyWidget(context)),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize * .75),
      child: Column(
        mainAxisAlignment: mainCenter,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Image.network(
              controller.faInfoModel.data.qrCode,
            ),
          ),
          _enableTwoFATitleWidget(context),
          _enableTwoFASubTitleWidget(context),
          _buttonWidget(context),
        ],
      ),
    );
  }

  _enableTwoFATitleWidget(BuildContext context) {
    return TitleHeading2Widget(
        padding: EdgeInsets.only(
            top: Dimensions.paddingSize * .75,
            bottom: Dimensions.paddingSize * .5),
        text: Strings.enableTwoFASecurity);
  }

  _enableTwoFASubTitleWidget(BuildContext context) {
    return TitleHeading5Widget(
      textAlign: TextAlign.center,
      padding: EdgeInsets.only(bottom: Dimensions.paddingSize),
      text: controller.faInfoModel.data.alert,
      color: CustomColor.whiteColor.withOpacity(.40),
    );
  }

  _buttonWidget(BuildContext context) {
    return Obx(() => controller.isStatusUpdateLoading
        ? const CustomLoadingAPI()
        : PrimaryButton(
            title: controller.faInfoModel.data.qrStatus == 0
                ? Strings.enable.tr
                : Strings.disable.tr,
            fontWeight: FontWeight.normal,
            buttonTextColor: Get.isDarkMode
                ? CustomColor.primaryBGDarkColor
                : CustomColor.primaryBGLightColor,
            fontSize: Dimensions.headingTextSize3 * .88,
            onPressed: () {
              controller.faStatusUpdateProcess();
            },
            borderColor: Get.isDarkMode
                ? CustomColor.primaryDarkColor
                : CustomColor.primaryLightColor,
            buttonColor: Get.isDarkMode
                ? CustomColor.primaryDarkColor
                : CustomColor.primaryLightColor,
          ));
  }
}
