import '../../utils/basic_screen_imports.dart';
import '../others/coin_logo_widget.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.title,
    required this.balance,
    required this.currency,
    required this.cryptoCurrencyNetworkLogo,
  });

  final String title,
      balance,
      currency,
      cryptoCurrencyNetworkLogo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: Dimensions.marginSizeHorizontal * 0.3),
      padding: EdgeInsets.all(Dimensions.paddingSize * 0.8),
      decoration: ShapeDecoration(
        color: CustomColor.primaryLightColor.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius * 1.5),
        ),
      ),
      child: Row(
        children: [
          CoinLogoWidget(
            networkLogoPath: cryptoCurrencyNetworkLogo,
            height: Dimensions.heightSize * 3,
            width: Dimensions.heightSize * 3,
          ),
          horizontalSpace(Dimensions.paddingHorizontalSize * .6),

          Column(
            mainAxisAlignment: mainCenter,
            crossAxisAlignment: crossStart,
            children: [
              TitleHeading4Widget(
                text: title,
                opacity: 0.6,
              ),
              verticalSpace(5),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  children: [
                    TitleHeading4Widget(
                      padding:
                          EdgeInsets.only(right: Dimensions.paddingSize * .20),
                      text: balance,
                      fontSize: Dimensions.headingTextSize2 + 2,
                      fontWeight: FontWeight.w600,
                    ),
                    TitleHeading4Widget(
                      text: currency,
                      color: CustomColor.primaryLightColor,
                      fontSize: Dimensions.headingTextSize2 + 2,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}