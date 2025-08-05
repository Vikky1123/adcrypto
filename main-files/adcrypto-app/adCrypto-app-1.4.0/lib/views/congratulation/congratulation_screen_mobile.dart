import 'package:flutter_svg/svg.dart';

import '../../custom_assets/assets.gen.dart';
import '../../routes/routes.dart';
import '../../utils/basic_screen_imports.dart';

class CongratulationScreenMobile extends StatelessWidget {
  final String subTitle;
  final String route;

  const CongratulationScreenMobile({
    super.key,
    required this.subTitle,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(route);
        return true;
      },
      child: Container(
        decoration: CustomStyle.screenGradientBG,
        child: Scaffold(
          backgroundColor: CustomColor.transparentColor,
          body: _bodyWidget(context),
        ),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(
            left: Dimensions.paddingSize, right: Dimensions.paddingSize),
        child: Column(
          // crossAxisAlignment: crossCenter,
          mainAxisAlignment: mainCenter,
          children: [
            _congratulationImageWidget(context),
            _congratulationTitleTextWidget(context),
            _congratulationSubTitleTextWidget(context),
            _okayButtonWidget(context),
          ],
        ),
      ),
    );
  }

  //congratulation image widget
  _congratulationImageWidget(BuildContext context) {
    return SvgPicture.asset(
      Assets.icon.tickMark,
      // ignore: deprecated_member_use
      color: CustomColor.primaryLightColor,
      height: MediaQuery.of(context).size.height * .30,
      width: MediaQuery.of(context).size.width * .60,
    );
  }

  //congratulation text widget
  _congratulationTitleTextWidget(BuildContext context) {
    return TitleHeading1Widget(
      text: Strings.congratulation.tr,
    );
  }

  //congratulation subtitle text widget
  _congratulationSubTitleTextWidget(BuildContext context) {
    return TitleHeading4Widget(
      textAlign: TextAlign.center,
      text: subTitle,
      padding: EdgeInsets.only(
        top: Dimensions.paddingSize * 0.33,
        bottom: Dimensions.paddingSize * 0.833,
        left: Dimensions.paddingSize,
        right: Dimensions.paddingSize,
      ),
      fontWeight: FontWeight.w500,
      color: Get.isDarkMode
          ? CustomColor.primaryDarkTextColor.withOpacity(0.60)
          : CustomColor.primaryLightTextColor.withOpacity(0.60),
    );
  }

  //okay button takes  to dashboard
  _okayButtonWidget(BuildContext context) {
    return PrimaryButton(
      title: switchButtonText(),
      onPressed: () {
        Get.offAllNamed(route);
      },
      borderColor: CustomColor.primaryLightColor,
      buttonColor: CustomColor.primaryLightColor,
      // shape: RoundedRectangleBorder(borderRadius: ),
    );
  }

  switchButtonText() {
    if (Routes.dashboardScreen == route) {
      return Strings.goToHome;
    } else if (Routes.signInScreen == route) {
      return Strings.signInNow;
    } else {
      return Strings.confirm;
    }
  }
}