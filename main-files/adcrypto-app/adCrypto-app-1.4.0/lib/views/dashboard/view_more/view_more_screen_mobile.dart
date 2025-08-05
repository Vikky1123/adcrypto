import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/others/custom_back_button.dart';
import '../../../backend/model/buy_crypto/buy_crypto_model.dart';
import '../../../controller/dashboard/buy_crypto/buy_crypto_controller.dart';
import '../../../controller/dashboard/dashboard_controller/dashboard_controller.dart';
import '../../../widgets/dashboard/card_widget.dart';

class ViewMoreScreenMobile extends StatelessWidget {
  const ViewMoreScreenMobile({super.key});

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
            padding: EdgeInsets.only(left: Dimensions.paddingSize * 0),
            text: Strings.allWallet.tr,
          ),
        ),
        backgroundColor: CustomColor.transparentColor,
        body: _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingHorizontalSize * .5
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
        Get.find<BuyCryptoController>().buyCryptoModel.data.currencies.length,
        (index) {
          var model = Get.find<BuyCryptoController>().buyCryptoModel.data;
          Currency data = model.currencies[index];
          String currencyImage =
              "${model.currencyImagePaths.baseUrl}/${model.currencyImagePaths.pathLocation}/${data.flag}";
          String defaultImage =
              "${model.currencyImagePaths.baseUrl}/${model.currencyImagePaths.defaultImage}";
          return GestureDetector(
            onTap: (){
              Get.find<DashBoardController>().viewDetail(data);
            },
            child: Padding(
              padding: EdgeInsets.only(
                  top: index != 0 ? Dimensions.paddingSize * 0.6 : 0),
              child: CardWidget(
                title: data.name,
                balance:
                    double.parse(data.wallet.first.balance).toStringAsFixed(2),
                currency: data.code,
                cryptoCurrencyNetworkLogo:
                    data.flag.isEmpty ? defaultImage : currencyImage,
              ),
            ),
          );
        },
      ),
    );
  }
}
