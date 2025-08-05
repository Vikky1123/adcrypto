import '../../utils/basic_screen_imports.dart';
import '../text_labels/title_heading5_widget.dart';
import 'log_information/log_information_widget.dart';

class ExchangeLogWidget extends StatelessWidget {
  const ExchangeLogWidget(
      {super.key,
      required this.title,
      required this.dateText,
      required this.status,
      required this.exchangeAmount,
      required this.monthText,
      required this.transactionType,
      required this.transactionAmount,
      required this.exchangeRate,
      required this.feesAndCharge,
      required this.transactionStatus});

  final String title,
      monthText,
      dateText,
      status,
      exchangeAmount,
      transactionType,
      transactionAmount,
      exchangeRate,
      feesAndCharge,
      transactionStatus;

  @override
  Widget build(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: EdgeInsets.only(bottom: Dimensions.paddingSize * 0.15),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
            color: CustomColor.primaryLightColor.withOpacity(.08),
          ),
          padding: EdgeInsets.only(right: Dimensions.paddingSize * 0.2),
          child: ExpansionTile(
            tilePadding: EdgeInsets.zero,
            childrenPadding: EdgeInsets.zero,
            trailing: Padding(
              padding:
                  EdgeInsets.only(right: Dimensions.paddingHorizontalSize * .5),
              child: Column(
                mainAxisAlignment: mainCenter,
                children: [
                  TitleHeading2Widget(
                      maxLines: 1,
                      text: exchangeAmount,
                      fontSize: Dimensions.headingTextSize4,
                      fontWeight: FontWeight.normal,
                      color: CustomColor.primaryLightColor),
                ],
              ),
            ),
            title: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: Dimensions.marginSizeVertical * 0.4,
                    top: Dimensions.marginSizeVertical * 0.1,
                    bottom: Dimensions.marginSizeVertical * 0.1,
                    right: Dimensions.marginSizeVertical * 0.2,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSize * 0.2,
                    horizontal: Dimensions.paddingSize * 0.2,
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
                            ? Dimensions.headingTextSize3
                            : Dimensions.headingTextSize1,
                        fontWeight: FontWeight.w600,
                        color: CustomColor.primaryLightColor,
                      ),
                      TitleHeading4Widget(
                        text: monthText,
                        fontSize: Dimensions.headingTextSize5,
                        fontWeight: FontWeight.w500,
                        color: CustomColor.primaryLightColor,
                      ),
                    ],
                  ),
                ),
                horizontalSpace(Dimensions.widthSize),
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: crossStart,
                    mainAxisAlignment: mainCenter,
                    children: [
                      Row(
                        children: [
                          TitleHeading2Widget(
                            text: Strings.exchange,
                            fontSize: Dimensions.headingTextSize4,
                            fontWeight: FontWeight.w700,
                            color: CustomColor.whiteColor,
                          ),
                          horizontalSpace(Dimensions.paddingSize * .15),
                          TitleHeading5Widget(
                            text: title,
                            fontWeight: FontWeight.w600,
                            color: CustomColor.primaryLightColor,
                          ),
                        ],
                      ),
                      verticalSpace(Dimensions.widthSize * 0.4),
                      Row(
                        children: [
                          TitleHeading5Widget(
                            padding: EdgeInsets.only(
                              right: Dimensions.paddingSize * .05,
                            ),
                            maxLines: 1,
                            text: Strings.sent,
                            fontSize: Dimensions.headingTextSize5,
                            fontWeight: FontWeight.w600,
                            color: CustomColor.whiteColor.withOpacity(
                              .60,
                            ),
                          ),
                          statusInfo(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSize * 0.5),
                decoration: ShapeDecoration(
                    shadows: const [
                      BoxShadow(
                        color: CustomColor.transparentColor,
                        blurRadius: 10,
                      )
                    ],
                    color: CustomColor.gradientColorBottom,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(Dimensions.radius * 0),
                      bottomRight: Radius.circular(Dimensions.radius * 0),
                    ))),
                child: Column(
                  children: [
                    LogInformationWidget(
                      variable: Strings.transactionType.tr,
                      value: transactionType,
                    ),
                    LogInformationWidget(
                      variable: Strings.amount.tr,
                      value: transactionAmount,
                    ),
                    LogInformationWidget(
                      variable: Strings.exchangeRate.tr,
                      value: exchangeRate,
                    ),
                    LogInformationWidget(
                      variable: Strings.feesAndCharge.tr,
                      value: feesAndCharge,
                    ),
                    LogInformationWidget(
                      variable: Strings.status.tr,
                      value: transactionStatus,stoke: false,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  statusInfo() {
    switch (status) {
      case Strings.pending:
        return _customStatusWidget(color: CustomColor.orangeColor);
      case Strings.reject:
        return _customStatusWidget(color: CustomColor.redColor);
      case Strings.confirm:
        return _customStatusWidget(color: CustomColor.greenColor);
      default:
        return _customStatusWidget(color: CustomColor.redColor);
    }
  }

  _customStatusWidget({required Color color}) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSize * .15,
          ),
          child: CircleAvatar(
            radius: Dimensions.radius * .25,
            backgroundColor: color,
          ),
        ),
        TitleHeading5Widget(
          maxLines: 1,
          text: status,
          fontSize: Dimensions.headingTextSize5,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ],
    );
  }
}