import '../../utils/basic_widget_imports.dart';
import 'title_heading5_widget.dart';

class MoneyInfoWidget extends StatelessWidget {
  const MoneyInfoWidget(
      {super.key,
      required this.limit,
      required this.rate,
      required this.networkFees});

  final String limit;
  final String rate;
  final String networkFees;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: EdgeInsets.only(
          right: Dimensions.paddingSize,
          left: Dimensions.paddingSize,
          top: Dimensions.paddingSize * .3,
        ),
        child: Column(
          mainAxisAlignment: mainStart,
          crossAxisAlignment: crossStart,
          children: [
            Row(
              children: [
                TitleHeading5Widget(
                  text: Strings.limit,
                  color: Get.isDarkMode
                      ? CustomColor.primaryDarkColor
                      : CustomColor.primaryLightColor,
                  fontWeight: FontWeight.w500,
                ),
                TitleHeading5Widget(
                  text: limit,
                  color: Get.isDarkMode
                      ? CustomColor.primaryDarkColor
                      : CustomColor.primaryLightColor,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            rate.isEmpty
                ? const SizedBox.shrink()
                : Row(
                    children: [
                      TitleHeading5Widget(
                        text: Strings.rate,
                        color: Get.isDarkMode
                            ? CustomColor.primaryDarkColor
                            : CustomColor.primaryLightColor,
                        fontWeight: FontWeight.w500,
                      ),
                      TitleHeading5Widget(
                        text: rate,
                        color: Get.isDarkMode
                            ? CustomColor.primaryDarkColor
                            : CustomColor.primaryLightColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
            Row(
              children: [
                TitleHeading5Widget(
                  text: Strings.networkFees,
                  color: Get.isDarkMode
                      ? CustomColor.primaryDarkColor
                      : CustomColor.primaryLightColor,
                  fontWeight: FontWeight.w500,
                ),
                TitleHeading5Widget(
                  text: networkFees,
                  color: Get.isDarkMode
                      ? CustomColor.primaryDarkColor
                      : CustomColor.primaryLightColor,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
