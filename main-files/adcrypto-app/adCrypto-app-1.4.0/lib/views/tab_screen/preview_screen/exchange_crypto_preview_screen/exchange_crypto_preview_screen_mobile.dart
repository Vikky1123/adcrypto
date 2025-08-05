import 'package:adcrypto/backend/utils/custom_loading_api.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import '../../../../controller/dashboard/exchange_crypto/exchange_crypto_controller.dart';
import '../../../../custom_assets/assets.gen.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/others/custom_back_button.dart';
import '../../../../widgets/others/custom_image_widget.dart';

class ExchangeCryptoPreviewScreenMobile extends StatelessWidget {
  ExchangeCryptoPreviewScreenMobile({super.key});

  final data = Get.find<ExchangeCryptoController>()
      .exchangeCryptoStoreModel
      .data
      .data
      .data;

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
          title: TitleHeading2Widget(
            padding: EdgeInsets.only(left: Dimensions.paddingSize * 3.5),
            fontWeight: FontWeight.w600,
            text: Strings.preview.tr,
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
            decoration: BoxDecoration(
              color: CustomColor.primaryLightColor.withOpacity(.06),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(Dimensions.radius * 1.5),
                topLeft: Radius.circular(
                  Dimensions.radius * 1.5,
                ),
              ),
            ),
            padding: EdgeInsets.only(bottom: Dimensions.marginSizeVertical),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize),
              child: Column(
                crossAxisAlignment: crossCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: Dimensions.paddingSize * 2.1,
                        bottom: Dimensions.paddingSize * .05),
                    child: TitleHeading3Widget(
                      text:
                          "${data.sendingAmount.toStringAsFixed(6)} ${data.senderWallet.code}",
                      fontSize: Dimensions.headingTextSize3 * 2,
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
                        ),
                      ),
                    ),
                  ),
                  _fromWalletToWallet(context),
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

  _fromWalletToWallet(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: mainSpaceBet,
          children: [
            Column(
              crossAxisAlignment: crossStart,
              children: [
                TitleHeading2Widget(
                  text: data.senderWallet.code,
                  color: CustomColor.primaryLightColor,
                  fontWeight: FontWeight.w600,
                ),
                TitleHeading3Widget(
                  text: Strings.fromWallet,
                  color: CustomColor.whiteColor.withOpacity(.30),
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: crossEnd,
              children: [
                TitleHeading2Widget(
                    text: data.receiverWallet.code,
                    color: CustomColor.primaryLightColor,
                    fontWeight: FontWeight.w600),
                TitleHeading3Widget(
                  text: Strings.toWallet,
                  color: CustomColor.whiteColor.withOpacity(.30),
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ],
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
      ],
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
                    "${data.sendingAmount.toStringAsFixed(6)} ${data.senderWallet.code}",
                color: CustomColor.greenColor,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          verticalSpace(Dimensions.heightSize * 0.25),
          FittedBox(
            child: Row(
              mainAxisAlignment: mainSpaceBet,
              children: [
                TitleHeading4Widget(
                    text: Strings.exchangeRate,
                    fontWeight: FontWeight.w500,
                    color: CustomColor.whiteColor.withOpacity(.2)),
                TitleHeading3Widget(
                  text:
                      "1 ${data.senderWallet.code} = ${data.exchangeRate.toStringAsFixed(6)} ${data.receiverWallet.code}",
                  color: CustomColor.orangeColor,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
          verticalSpace(Dimensions.heightSize * 0.25),
          Row(
            mainAxisAlignment: mainSpaceBet,
            children: [
              TitleHeading4Widget(
                  text: Strings.networkCharge,
                  fontWeight: FontWeight.w500,
                  color: CustomColor.whiteColor.withOpacity(.2)),
              TitleHeading3Widget(
                text:
                    "${data.totalCharge.toStringAsFixed(6)} ${data.senderWallet.code}",
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
              TitleHeading3Widget(
                text:
                    "${data.payableAmount.toStringAsFixed(6)} ${data.senderWallet.code}",
                color: CustomColor.primaryLightColor,
                fontWeight: FontWeight.w600,
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
      child: Obx(() => Get.find<ExchangeCryptoController>().isConfirmLoading
          ? const CustomLoadingAPI()
          : PrimaryButton(
              title: Strings.confirm.tr,
              onPressed: () {
                Get.find<ExchangeCryptoController>().exchangeCryptoConfirmProcess();

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
