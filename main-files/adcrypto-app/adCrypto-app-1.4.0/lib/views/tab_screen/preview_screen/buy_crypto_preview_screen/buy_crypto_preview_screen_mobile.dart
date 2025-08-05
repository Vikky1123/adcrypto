import 'package:adcrypto/backend/utils/custom_loading_api.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import '../../../../controller/dashboard/buy_crypto/buy_crypto_controller.dart';
import '../../../../custom_assets/assets.gen.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/others/custom_back_button.dart';
import '../../../../widgets/others/custom_image_widget.dart';
import '../../../../widgets/text_labels/title_heading5_widget.dart';

class BuyCryptoPreviewScreenMobile extends StatelessWidget {
  BuyCryptoPreviewScreenMobile({super.key});

  final previewInfo =
      Get.find<BuyCryptoController>().buyCryptoStoreModel.data.data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: CustomStyle.screenGradientBG,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColor.transparentColor,
          leading: CustomBackButton(
            onTap: () => Navigator.pop(context),
          ),
          title: TitleHeading2Widget(
            padding: EdgeInsets.only(left: Dimensions.paddingSize * 3.5),
            text: Strings.preview.tr,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: CustomColor.transparentColor,
        body: _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(
          top: Dimensions.paddingSize,
          right: Dimensions.paddingSize,
          left: Dimensions.paddingSize),
      children: [
        _receiptWidget(context),
        _buttonWidget(context),
      ],
    );
  }

  _receiptWidget(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: MultipleRoundedCurveClipper(),
          child: Container(
            margin: EdgeInsets.only(
              top: Dimensions.marginSizeVertical,
            ),
            padding: EdgeInsets.only(
                top: Dimensions.marginSizeVertical,
                bottom: Dimensions.marginSizeVertical),
            color: CustomColor.primaryLightColor.withOpacity(.06),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize),
              child: Column(
                crossAxisAlignment: crossCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: Dimensions.paddingVerticalSize * .05),
                    child: TitleHeading3Widget(
                      fontSize: Dimensions.headingTextSize3 * 2,
                      text:
                          "${previewInfo.data.amount} ${previewInfo.data.wallet.code}",
                      color: CustomColor.primaryLightColor,
                    ),
                  ),
                  TitleHeading3Widget(
                    text: Strings.enteredAmount,
                    fontWeight: FontWeight.w600,
                    color: CustomColor.whiteColor.withOpacity(
                      .30,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: Dimensions.paddingVerticalSize * .5,
                    ),
                    child: Container(
                      height: Dimensions.heightSize * .17,
                      decoration: BoxDecoration(
                          color: CustomColor.whiteColor.withOpacity(
                            .1,
                          ),
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(Dimensions.radius),
                            right: Radius.circular(
                              Dimensions.radius,
                            ),
                          )),
                    ),
                  ),
                  _walletTypeAndNetworkWidget(context),
                  _coinAndPaymentGatewayWidget(context),
                  _walletAddressWidget(context),
                  _amountInfoWidget(context),
                ],
              ),
            ),
          ),
        ),
        Center(
          child: CircleAvatar(
            backgroundColor: CustomColor.primaryLightColor,
            radius: Dimensions.radius * 2.5,
            child: CircleAvatar(
              backgroundColor: CustomColor.gradientColorTop,
              radius: Dimensions.radius * 2.2,
              child: CustomImageWidget(
                path: Assets.icon.receipt,
                height: Dimensions.heightSize * 2.2,
              ),
            ),
          ),
        )
      ],
    );
  }

  _walletTypeAndNetworkWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: mainSpaceBet,
      crossAxisAlignment: crossStart,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: crossStart,
            children: [
              TitleHeading2Widget(
                text: previewInfo.data.wallet.type,
                color: CustomColor.primaryLightColor,
                fontWeight: FontWeight.w600,
                fontSize: Dimensions.headingTextSize2 * .9,
              ),
              TitleHeading3Widget(
                text: Strings.walletType,
                color: CustomColor.whiteColor.withOpacity(.30),
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
        horizontalSpace(5),
        Expanded(
          child: Column(
            crossAxisAlignment: crossEnd,
            children: [
              TitleHeading2Widget(
                  text: previewInfo.data.network.name,
                  color: CustomColor.primaryLightColor,
                  fontSize: Dimensions.headingTextSize2 * .9,
                  fontWeight: FontWeight.w600),
              TitleHeading3Widget(
                text: Strings.network,
                color: CustomColor.whiteColor.withOpacity(.30),
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ],
    );
  }

  _coinAndPaymentGatewayWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSize * .25),
      child: Row(
        mainAxisAlignment: mainSpaceBet,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSize * .25,
                  vertical: Dimensions.paddingSize * .5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius),
                border: Border.all(
                  width: Dimensions.widthSize * .1,
                  color: CustomColor.whiteColor.withOpacity(
                    .10,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: crossStart,
                children: [
                  TitleHeading3Widget(
                    text: previewInfo.data.wallet.name,
                    color: CustomColor.primaryLightColor,
                    fontWeight: FontWeight.w700,
                  ),
                  TitleHeading5Widget(
                    text: Strings.coin,
                    color: CustomColor.whiteColor.withOpacity(.30),
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ),
          horizontalSpace(Dimensions.widthSize),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSize * .25,
                  vertical: Dimensions.paddingSize * .5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius),
                border: Border.all(
                  width: Dimensions.widthSize * .1,
                  color: CustomColor.whiteColor.withOpacity(
                    .10,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: crossEnd,
                children: [
                  TitleHeading3Widget(
                      text: previewInfo.data.paymentMethod.name,
                      color: CustomColor.primaryLightColor,
                      fontWeight: FontWeight.w600),
                  TitleHeading5Widget(
                    text: Strings.paymentGateway,
                    color: CustomColor.whiteColor.withOpacity(.30),
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _walletAddressWidget(BuildContext context) {
    return Visibility(
      visible: Get.find<BuyCryptoController>().selectIndex.value == 1,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSize * .25,
            vertical: Dimensions.paddingSize * .5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius),
          border: Border.all(
            width: Dimensions.widthSize * .1,
            color: CustomColor.whiteColor.withOpacity(
              .10,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: crossStart,
          children: [
            TitleHeading3Widget(
                text: previewInfo.data.wallet.address,
                color: CustomColor.primaryLightColor,
                fontWeight: FontWeight.w700),
            TitleHeading5Widget(
              text: Strings.walletAddress,
              color: CustomColor.whiteColor.withOpacity(.30),
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }

  _amountInfoWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Dimensions.paddingSize * .1,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: mainSpaceBet,
            children: [
              TitleHeading4Widget(
                  text: Strings.enteredAmount,
                  fontWeight: FontWeight.w500,
                  color: CustomColor.whiteColor.withOpacity(.2)),
              TitleHeading3Widget(
                text:
                    "${previewInfo.data.amount} ${previewInfo.data.wallet.code}",
                color: CustomColor.greenColor,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          verticalSpace(Dimensions.heightSize * 0.25),
          Row(
            mainAxisAlignment: mainSpaceBet,
            children: [
              TitleHeading4Widget(
                  text: Strings.exchangeRate,
                  fontWeight: FontWeight.w500,
                  color: CustomColor.whiteColor.withOpacity(.2)),
              Expanded(
                child: TitleHeading3Widget(
                  text:
                      "1 ${previewInfo.data.wallet.code} = ${previewInfo.data.exchangeRate.toStringAsFixed(6)} ${previewInfo.data.paymentMethod.code}",
                  color: CustomColor.orangeColor,
                  fontWeight: FontWeight.w700,
                  maxLines: 2,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          verticalSpace(Dimensions.heightSize * 0.25),
          Row(
            mainAxisAlignment: mainSpaceBet,
            children: [
              TitleHeading4Widget(
                fontWeight: FontWeight.w500,
                text: Strings.networkChargeText,
                color: CustomColor.whiteColor.withOpacity(
                  .2,
                ),
              ),
              TitleHeading3Widget(
                text:
                    "${previewInfo.data.totalCharge.toStringAsFixed(6)} ${previewInfo.data.paymentMethod.code}",
                color: CustomColor.redColor.withOpacity(.8),
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: Dimensions.paddingSize * .25),
            child: DottedLine(
              dashLength: 7,
              dashRadius: 5,
              lineThickness: 1.5,
              dashColor: CustomColor.whiteColor.withOpacity(.20),
            ),
          ),
          Row(
            mainAxisAlignment: mainSpaceBet,
            children: [
              TitleHeading4Widget(
                  text: Strings.totalPayableAmount,
                  fontWeight: FontWeight.w500,
                  color: CustomColor.whiteColor.withOpacity(.2)),
              Expanded(
                child: TitleHeading2Widget(
                  text:
                      "${previewInfo.data.payableAmount.toStringAsFixed(6)} ${previewInfo.data.paymentMethod.code}",
                  color: CustomColor.primaryLightColor,
                  maxLines: 2,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Dimensions.paddingSize * .75,
        bottom: Dimensions.paddingSize,
      ),
      child: Obx(() => Get.find<BuyCryptoController>().isSubmitLoading
          ? const CustomLoadingAPI()
          : PrimaryButton(
              title: Strings.confirm.tr,
              onPressed: () {
                debugPrint('''
            Info:
              P.Name => ${previewInfo.data.paymentMethod.name}
              Identifier => ${previewInfo.identifier}
            ''');
                // manage automatic and manual
                if (previewInfo.data.paymentMethod.alias
                    .contains("automatic")) {
                  debugPrint("AUTOMATIC: ");
                  if(previewInfo.data.paymentMethod.alias
                      .contains("tatum")){
                    Get.find<BuyCryptoController>()
                        .buyCryptoTatumProcess();
                  }
                  else{
                    Get.find<BuyCryptoController>()
                        .buyCryptoAutomaticSubmitProcess();
                  }
                } else {
                  debugPrint("MANUAL: ");
                  Get.find<BuyCryptoController>().buyCryptoManualProcess();
                }
              },
              borderColor: Get.isDarkMode
                  ? CustomColor.primaryDarkColor
                  : CustomColor.primaryLightColor,
              buttonColor: Get.isDarkMode
                  ? CustomColor.primaryDarkColor
                  : CustomColor.primaryLightColor,
            )),
    );
  }
}
