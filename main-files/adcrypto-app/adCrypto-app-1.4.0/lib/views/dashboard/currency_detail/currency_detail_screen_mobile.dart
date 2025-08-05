import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/others/custom_back_button.dart';
import '../../../backend/model/buy_crypto/buy_crypto_model.dart';
import '../../../controller/dashboard/buy_crypto/buy_crypto_controller.dart';
import '../../../custom_assets/assets.gen.dart';
import '../../../widgets/others/custom_image_widget.dart';

class CurrencyDetailScreenMobile extends StatelessWidget {
  const CurrencyDetailScreenMobile({super.key, required this.currency});

  final Currency currency;

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
            text: currency.name,
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
            horizontal: Dimensions.paddingHorizontalSize * .5),
        shrinkWrap: true,
        children: [
          _walletInfo(context),
          _qrCodeWidget(context),
          _addressFieldWidget(),
          verticalSpace(Dimensions.paddingVerticalSize),
          _networks(context),
          verticalSpace(Dimensions.paddingVerticalSize),
        ]);
  }

  _walletInfo(BuildContext context) {
    var model = Get.find<BuyCryptoController>().buyCryptoModel.data;
    String currencyImage =
        "${model.currencyImagePaths.baseUrl}/${model.currencyImagePaths.pathLocation}/${currency.flag}";
    String defaultImage =
        "${model.currencyImagePaths.baseUrl}/${model.currencyImagePaths.defaultImage}";
    return Column(
      children: [
        verticalSpace(Dimensions.paddingHorizontalSize * .5),
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(
            currencyImage.isEmpty ? defaultImage : currencyImage,
          ),
        ),
        Column(
          mainAxisAlignment: mainCenter,
          crossAxisAlignment: crossCenter,
          children: [
            verticalSpace(Dimensions.paddingHorizontalSize * .5),
            TitleHeading4Widget(
              text: currency.name,
              opacity: 0.6,
            ),
            verticalSpace(3),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                mainAxisAlignment: mainCenter,
                crossAxisAlignment: crossCenter,
                children: [
                  TitleHeading4Widget(
                    padding: EdgeInsets.only(right: Dimensions.paddingSize * .20),
                    text: double.parse(currency.wallet.first.balance)
                        .toStringAsFixed(6),
                    fontSize: Dimensions.headingTextSize2 + 2,
                    fontWeight: FontWeight.w600,
                  ),
                  TitleHeading4Widget(
                    text: currency.code,
                    color: CustomColor.primaryLightColor,
                    fontSize: Dimensions.headingTextSize2 + 2,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ],
        ),
        verticalSpace(Dimensions.paddingHorizontalSize * 1),
      ],
    );
  }

  _addressFieldWidget() {
    return PrimaryTextInputWidget(
      readOnly: true,
      controller:
          TextEditingController(text: currency.wallet.first.publicAddress),
      labelText: "",
      hintText: "",
      borderColor: Get.isDarkMode
          ? CustomColor.primaryDarkTextColor.withOpacity(.15)
          : CustomColor.primaryLightTextColor.withOpacity(.15),
      suffixIcon: InkWell(
        onTap: () async {
          await Clipboard.setData(
              ClipboardData(text: currency.wallet.first.publicAddress));
        },
        child: Padding(
          padding: EdgeInsets.only(
            right: Dimensions.paddingSize * .3,
            left: Dimensions.paddingSize * .3,
            top: Dimensions.paddingSize * .30,
            bottom: Dimensions.paddingSize * .30,
          ),
          child: CircleAvatar(
            radius: Dimensions.radius,
            backgroundColor: CustomColor.primaryLightColor,
            child: CustomImageWidget(
              path: Assets.icon.iconPasteSvg,
              height: Dimensions.heightSize * 1.5,
              width: Dimensions.widthSize * 1.5,
            ),
          ),
        ),
      ),
    );
  }

  _qrCodeWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.paddingSize * 1.5),
      margin: EdgeInsets.all(Dimensions.paddingSize * .4),
      height: MediaQuery.of(context).size.height * .40,
      decoration: BoxDecoration(
        color: CustomColor.primaryLightColor.withOpacity(.06),
        borderRadius: BorderRadius.circular(
          Dimensions.radius,
        ),
      ),
      child: Center(
        child: QrImageView(
          data: currency.wallet.first.publicAddress,
          version: QrVersions.auto,
          dataModuleStyle: QrDataModuleStyle(
            color: CustomColor.primaryLightColor,
            dataModuleShape: QrDataModuleShape.square,
          ),
          eyeStyle: QrEyeStyle(
              color: CustomColor.primaryLightColor,
              eyeShape: QrEyeShape.square),
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }

  _networks(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: CustomColor.primaryLightColor.withOpacity(.06)),
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          TitleHeading2Widget(
            text: Strings.availableNetwork,
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingHorizontalSize * .4,
              vertical: Dimensions.paddingVerticalSize * .4,
            ),
          ),
          const Divider(color: CustomColor.gradientColorBottom, thickness: 2,),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingHorizontalSize * .4,
              vertical: Dimensions.paddingVerticalSize * .4,
            ),
            children: List.generate(
                currency.networks.length,
                  (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    mainAxisAlignment: mainSpaceBet,
                    children: [
                      const TitleHeading3Widget(text: Strings.network, opacity: .4, fontWeight: FontWeight.w500,),
                      TitleHeading3Widget(text: currency.networks[index].name, opacity: .5, fontWeight: FontWeight.w700),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
