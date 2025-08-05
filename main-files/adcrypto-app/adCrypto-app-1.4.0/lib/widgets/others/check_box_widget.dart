import '../../controller/basic_settings_controller.dart';
import '../../utils/basic_widget_imports.dart';
import '../../views/dynamic_web_screen/dynamic_web_screen.dart';

class CheckBoxWidget extends StatelessWidget {
  const CheckBoxWidget({
    super.key,
    required this.isChecked,
    this.onChecked,
    this.fontSize = 14,
  });
  final RxBool isChecked;
  final void Function(bool)? onChecked;

  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: mainCenter,
        children: [
          InkWell(
            onTap: () {
              isChecked.value = !isChecked.value;
              onChecked!(isChecked.value);
            },
            child: Row(
              mainAxisAlignment: mainCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: CustomColor.transparentColor,
                    border: Border.all(
                      width: 1.5,
                      color: CustomColor.whiteColor.withOpacity(0.2),
                    ),
                  ),
                  child: Icon(
                    Icons.check,
                    size: Dimensions.heightSize,
                    color: isChecked.value
                        ? CustomColor.whiteColor
                        : CustomColor.whiteColor.withOpacity(.00),
                  ),
                ),
                horizontalSpace(Dimensions.widthSize * 0.75),
                CustomTitleHeadingWidget(
                  text: Strings.iHaveAgreedWith,
                  style: CustomStyle.lightHeading5TextStyle.copyWith(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w500,
                      color: CustomColor.whiteColor.withOpacity(.6),
                      letterSpacing: .01,
                      wordSpacing: .01),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(WebViewScreen(
                link: Get.find<BasicSettingsController>().basicSettingsModel.data.privacyPolicyLink,
                appTitle: Strings.privacyAndPolicy,
              ));
            },
            child: CustomTitleHeadingWidget(
              text: Strings.termsOfUse,
              style: CustomStyle.lightHeading5TextStyle.copyWith(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                  color: CustomColor.primaryLightColor,
                  letterSpacing: .01,
                  wordSpacing: .01),
            ),
          ),
        ],
      ),
    );
  }
}