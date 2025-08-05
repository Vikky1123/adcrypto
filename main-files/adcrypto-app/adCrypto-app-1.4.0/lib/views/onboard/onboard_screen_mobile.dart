import 'package:slider_button/slider_button.dart';

import '../../../widgets/others/custom_image_widget.dart';
import '../../backend/language/language_controller.dart';
import '../../backend/utils/custom_loading_api.dart';
import '../../controller/basic_settings_controller.dart';
import '../../controller/onboard_controller/onboard_controller.dart';
import '../../custom_assets/assets.gen.dart';
import '../../utils/basic_screen_imports.dart';

class OnBoardScreenMobile extends StatelessWidget {
  OnBoardScreenMobile({super.key});

  final controller = Get.put(OnboardController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: CustomStyle.screenGradientBG,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return Stack(
      children: [
        _imageWidget(context),
        _titleSubtitleTextWidget(context),
      ],
    );
  }

  _imageWidget(context) {
    return Obx(() => Get.find<BasicSettingsController>().isLoading
        ? const CustomLoadingAPI()
        : Image.network(
            Get.find<BasicSettingsController>().onboardScreen.value,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ));
  }

  _titleSubtitleTextWidget(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: Dimensions.paddingHorizontalSize),
      child: Obx(() => Column(
        crossAxisAlignment: crossCenter,
        mainAxisAlignment: mainEnd,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
            child: Text.rich(
              TextSpan(
                style: CustomStyle.lightHeading1TextStyle.copyWith(
                    color: CustomColor.primaryLightTextColor,
                    fontSize: Dimensions.headingTextSize0,
                    fontWeight: FontWeight.w800),
                children: [
                  TextSpan(
                    text: Get.find<BasicSettingsController>().isLoading
                        ? ""
                        : Get.find<BasicSettingsController>()
                            .onboardScreenTitle
                            .value,
                  ),
                  // TextSpan(
                  //   text: Get.find<LanguageSettingController>().isLoading ? "": "${Get.find<LanguageSettingController>().getTranslation(Strings.onboardTitleTwo.tr)} ",
                  //   style: CustomStyle.lightHeading1TextStyle.copyWith(
                  //       color: CustomColor.primaryDarkColor,
                  //       fontSize: Dimensions.headingTextSize0,
                  //       fontWeight: FontWeight.w800),
                  // ),
                  // TextSpan(
                  //   text: Get.find<LanguageSettingController>().isLoading ? "": "${Get.find<LanguageSettingController>().getTranslation(Strings.onboardTitleThree.tr)} ",
                  // ),
                ],
              ),
            ),
          ),
          TitleHeading4Widget(
            textAlign: TextAlign.justify,
            text: Get.find<BasicSettingsController>().isLoading
                ? ""
                : Get.find<BasicSettingsController>()
                    .onboardScreenSubTitle
                    .value,
            fontWeight: FontWeight.w500,
            opacity: .6,
            maxLines: 3,
            padding: EdgeInsets.only(bottom: Dimensions.paddingSize * 2.25),
          ),
          _sliderButtonWidget(context),
        ],
      )),
    );
  }

  _sliderButtonWidget(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: Dimensions.paddingVerticalSize,
        ),
        child: SliderButton(
          buttonColor: CustomColor.primaryLightColor,
          buttonSize: MediaQuery.of(context).size.width * .13,
          width: MediaQuery.of(context).size.width * .8,
          disable: false,
          shimmer: false,
          action: () async {
            controller.goToSignInScreen();
            return null;
          },
          backgroundColor: CustomColor.whiteColor.withOpacity(.05),
          alignLabel: const Alignment(0.2, 0),
          label: Text(
            Get.find<LanguageSettingController>().isLoading
                ? ""
                : Get.find<LanguageSettingController>()
                    .getTranslation(Strings.swipeToGetStarted.tr),
            style: TextStyle(
              color: CustomColor.whiteColor.withOpacity(.2),
              fontWeight: FontWeight.w700,
              fontSize: Dimensions.headingTextSize3,
            ),
          ),
          icon: Obx(
            () => Row(
              mainAxisAlignment: mainCenter,
              children: [
                CustomImageWidget(
                  path: Assets.icon.arrow,
                  color:
                      CustomColor.whiteColor.withOpacity(controller.svg1.value),
                  height: Dimensions.onboardBtnIconHeightSize,
                  width: Dimensions.onboardBtnIconWidthSize,
                ),
                CustomImageWidget(
                  path: Assets.icon.arrow,
                  color:
                      CustomColor.whiteColor.withOpacity(controller.svg2.value),
                  height: Dimensions.onboardBtnIconHeightSize,
                  width: Dimensions.onboardBtnIconWidthSize,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
