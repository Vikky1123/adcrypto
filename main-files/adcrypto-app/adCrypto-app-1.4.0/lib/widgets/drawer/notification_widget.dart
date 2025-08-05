import '../../utils/basic_screen_imports.dart';
import '../text_labels/title_heading5_widget.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget(
      {super.key,
      required this.title,
      required this.dateText,
      required this.notificationMessage,
      required this.monthText});

  final String title, monthText, dateText, notificationMessage;

  @override
  Widget build(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: EdgeInsets.only(bottom: Dimensions.paddingSize * 0.3),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
            color: CustomColor.primaryLightColor.withOpacity(.04),
          ),
          padding: EdgeInsets.only(right: Dimensions.paddingSize * 0.2),
          height: Dimensions.heightSize * 6,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.only(
                    left: Dimensions.marginSizeVertical * 0.4,
                    top: Dimensions.marginSizeVertical * 0.4,
                    bottom: Dimensions.marginSizeVertical * 0.4,
                    right: Dimensions.marginSizeVertical * 0.2,
                  ),
                  padding: EdgeInsets.only(
                    left: Dimensions.paddingSize * 0.2,
                    right: Dimensions.paddingSize * 0.2,
                  ),
                  decoration: BoxDecoration(
                      color: CustomColor.primaryLightColor.withOpacity(.10),
                      borderRadius: BorderRadius.circular(Dimensions.radius)),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: mainCenter,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: crossCenter,
                    children: [
                      TitleHeading4Widget(
                        text: dateText,
                        fontSize: isTablet()
                            ? Dimensions.headingTextSize3 - 1
                            : Dimensions.headingTextSize1,
                        fontWeight: FontWeight.w600,
                        color: CustomColor.primaryLightColor,
                      ),
                      TitleHeading4Widget(
                        text: monthText,
                        fontSize: Dimensions.headingTextSize6 - 2,
                        fontWeight: FontWeight.w500,
                        color: CustomColor.primaryLightColor,
                      ),
                    ],
                  ),
                ),
              ),
              horizontalSpace(Dimensions.widthSize),
              Expanded(
                flex: 11,
                child: Column(
                  crossAxisAlignment: crossStart,
                  mainAxisAlignment: mainCenter,
                  children: [
                    TitleHeading1Widget(
                      text: title,
                      fontSize: Dimensions.headingTextSize4 + 1,
                      fontWeight: FontWeight.w700,
                      color: CustomColor.primaryLightTextColor,
                    ),
                    verticalSpace(Dimensions.widthSize * 0.4),
                    TitleHeading5Widget(
                      maxLines: 1,
                      text: notificationMessage,
                      fontWeight: FontWeight.normal,
                      color: CustomColor.primaryLightTextColor.withOpacity(
                        .60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}