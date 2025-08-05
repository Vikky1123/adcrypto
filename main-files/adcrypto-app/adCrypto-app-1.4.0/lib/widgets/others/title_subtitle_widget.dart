import '../../utils/basic_widget_imports.dart';

class TitleSubtitleWidget extends StatelessWidget {
  const TitleSubtitleWidget(
      {super.key, required this.title, required this.subTitle});
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingHorizontalSize * .5,
          ),
          width: Dimensions.widthSize * .5,
          height: Dimensions.heightSize * 6,
          decoration: BoxDecoration(
            color: CustomColor.primaryLightColor,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleHeading1Widget(
                text: title,
                color: Get.isDarkMode
                    ? CustomColor.primaryDarkTextColor
                    : CustomColor.primaryLightTextColor,
                fontWeight: FontWeight.w700,
              ),
              verticalSpace(Dimensions.heightSize * .5),
              TitleHeading4Widget(
                text: subTitle,
                color: Get.isDarkMode
                    ? CustomColor.primaryDarkTextColor.withOpacity(.6)
                    : CustomColor.primaryLightTextColor.withOpacity(.6),
                fontSize: Dimensions.headingTextSize4,
                fontWeight: FontWeight.w500,
              ),
              verticalSpace(Dimensions.heightSize * .5),
            ],
          ),
        ),
      ],
    );
  }
}