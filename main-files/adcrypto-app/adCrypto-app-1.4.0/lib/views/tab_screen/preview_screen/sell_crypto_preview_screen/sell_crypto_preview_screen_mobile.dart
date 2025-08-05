import 'dart:math' as math;

import 'package:adcrypto/backend/utils/custom_loading_api.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import '../../../../backend/model/sell_crypto/sell_crypto_payment_info_store.dart';
import '../../../../controller/dashboard/sell_crypto/sell_crypto_controller.dart';
import '../../../../custom_assets/assets.gen.dart';
import '../../../../utils/basic_widget_imports.dart';
import '../../../../widgets/buttons/primary_button.dart';
import '../../../../widgets/others/custom_back_button.dart';
import '../../../../widgets/others/custom_image_widget.dart';
import '../../../../widgets/text_labels/title_heading5_widget.dart';

class SellCryptoPreviewScreenMobile extends StatelessWidget {
  SellCryptoPreviewScreenMobile({super.key});

  final previewInfo =
      Get.find<SellCryptoController>().sellCryptoPaymentInfoStoreModel.data;

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
          centerTitle: true,
          title: TitleHeading2Widget(
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
        _paymentProofSummaryWidget(context),
        _receivingMethodSummaryWidget(context),
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
            margin: EdgeInsets.only(top: Dimensions.marginSizeVertical),
            padding: EdgeInsets.only(bottom: Dimensions.marginSizeVertical),
            decoration: BoxDecoration(
              color: CustomColor.primaryLightColor.withOpacity(.06),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius),
                topRight: Radius.circular(
                  Dimensions.radius,
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize),
              child: Column(
                crossAxisAlignment: crossCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: Dimensions.paddingSize,
                        bottom: Dimensions.paddingSize * .05),
                    child: TitleHeading3Widget(
                      fontSize: Dimensions.headingTextSize3 * 2,
                      text:
                          "${previewInfo.data.data.amount.toStringAsFixed(6)} ${previewInfo.data.data.senderWallet.code}",
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
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: crossStart,
            children: [
              TitleHeading2Widget(
                text: previewInfo.data.data.senderWallet.type,
                color: CustomColor.primaryLightColor,
                fontWeight: FontWeight.w600,
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
                  text: previewInfo.data.data.network.name,
                  color: CustomColor.primaryLightColor,
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
                    text: previewInfo.data.data.senderWallet.code,
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
                      text: previewInfo.data.data.paymentMethod.name,
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
    return previewInfo.data.data.outsideAddress.publicAddress.isEmpty
        ? const SizedBox.shrink()
        : Container(
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
                    text: previewInfo.data.data.outsideAddress.publicAddress,
                    color: CustomColor.primaryLightColor,
                    fontWeight: FontWeight.w700),
                TitleHeading5Widget(
                  text: Strings.walletAddress,
                  color: CustomColor.whiteColor.withOpacity(.30),
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          );
  }

  _amountInfoWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Dimensions.paddingSize * .25,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: mainSpaceBet,
            children: [
              TitleHeading4Widget(
                text: Strings.enteredAmount,
                fontWeight: FontWeight.w500,
                color: CustomColor.whiteColor.withOpacity(
                  .2,
                ),
              ),
              TitleHeading3Widget(
                text: previewInfo.data.data.amount.toStringAsFixed(6),
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
              TitleHeading3Widget(
                text:
                    "1 ${previewInfo.data.data.senderWallet.code} = ${previewInfo.data.data.exchangeRate.toStringAsFixed(6)} ${previewInfo.data.data.paymentMethod.code}",
                color: CustomColor.orangeColor,
                fontSize: Dimensions.headingTextSize3 * .8,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          verticalSpace(Dimensions.heightSize * 0.25),
          Row(
            mainAxisAlignment: mainSpaceBet,
            children: [
              TitleHeading4Widget(
                  text: Strings.networkChargeText,
                  fontWeight: FontWeight.w500,
                  color: CustomColor.whiteColor.withOpacity(.2)),
              TitleHeading3Widget(
                text:
                    "${previewInfo.data.data.totalCharge.toStringAsFixed(6)} ${previewInfo.data.data.senderWallet.code}",
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
                      "${previewInfo.data.data.totalPayable.toStringAsFixed(6)} ${previewInfo.data.data.senderWallet.code}",
                  color: CustomColor.primaryLightColor,
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

  _paymentProofSummaryWidget(BuildContext context) {
    return previewInfo.data.data.senderWallet.type == "Inside Wallet"
        ? const SizedBox.shrink()
        : Padding(
            padding: EdgeInsets.only(
                bottom: Dimensions.paddingVerticalSize * .5,
                top: Dimensions.paddingVerticalSize * .5),
            child: ClipPath(
              clipper: MovieTicketBothSidesClipper(),
              child: Container(
                padding:
                    EdgeInsets.only(bottom: Dimensions.paddingVerticalSize),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: CustomColor.primaryLightColor.withOpacity(.06)),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: Dimensions.paddingSize),
                  child: Column(
                    crossAxisAlignment: crossCenter,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: Dimensions.paddingSize,
                            bottom: Dimensions.paddingSize * .25),
                        child: FittedBox(
                          child: Row( 
                            mainAxisAlignment: mainStart,
                            children: const [
                              TitleHeading1Widget(
                                text: Strings.paymentProofSummary,
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: Dimensions.paddingVerticalSize * .5,
                        ),
                        child: Divider(
                          height: Dimensions.heightSize * .40,
                          color: CustomColor.whiteColor.withOpacity(
                            .1,
                          ),
                        ),
                      ),
                      GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  // mainAxisExtent: 65,
                                  crossAxisSpacing: 2),
                          itemCount: Get.find<SellCryptoController>()
                              .paymentProofPreview
                              .length,
                          itemBuilder: (context, index) {
                            DynamicPreview data =
                                Get.find<SellCryptoController>()
                                    .paymentProofPreview[index];
                            return data.type == PreviewType.text
                                ? Column(
                                    crossAxisAlignment:
                                        index % 2 == 0 ? crossStart : crossEnd,
                                    children: [
                                      TitleHeading2Widget(
                                        text: data.value,
                                        color: CustomColor.primaryLightColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      TitleHeading3Widget(
                                        text: data.name,
                                        color: CustomColor.whiteColor
                                            .withOpacity(.30),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        index % 2 == 0 ? crossStart : crossEnd,
                                    children: [
                                      TitleHeading2Widget(
                                          text: data.value.substring(
                                              data.value.length > 10
                                                  ? data.value.length - 10
                                                  : data.value.length),
                                          color: CustomColor.primaryLightColor,
                                          fontWeight: FontWeight.w600),
                                      TitleHeading3Widget(
                                        text: data.name,
                                        color: CustomColor.whiteColor
                                            .withOpacity(.30),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ],
                                  );
                          })
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  _receivingMethodSummaryWidget(BuildContext context) {
    return Transform.rotate(
      angle: math.pi,
      child: ClipPath(
        clipper: MultipleRoundedCurveClipper(),
        child: Container(
          padding: EdgeInsets.only(top: Dimensions.paddingVerticalSize),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius * 1.5),
                  topLeft: Radius.circular(Dimensions.radius * 1.5)),
              color: CustomColor.primaryLightColor.withOpacity(.06)),
          child: Transform.rotate(
            angle: math.pi,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize),
              child: Column(
                crossAxisAlignment: crossCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: Dimensions.paddingSize,
                        bottom: Dimensions.paddingSize * .25),
                    child: FittedBox(
                      child: Row(
                        mainAxisAlignment: mainStart,
                        children: [
                          TitleHeading1Widget(
                            fontSize: Dimensions.headingTextSize1 * .95,
                            text: Strings.receivingMethodSummary,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: Dimensions.paddingSize * .5,
                    ),
                    child: Divider(
                      height: Dimensions.heightSize * .40,
                      color: CustomColor.whiteColor.withOpacity(
                        .1,
                      ),
                    ),
                  ),
                  GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 2),
                      itemCount: Get.find<SellCryptoController>()
                          .receivingMethodPreview
                          .length,
                      itemBuilder: (context, index) {
                        DynamicPreview data = Get.find<SellCryptoController>()
                            .receivingMethodPreview[index];
                        return data.type == PreviewType.text
                            ? Column(
                                crossAxisAlignment:
                                    index % 2 == 0 ? crossStart : crossEnd,
                                children: [
                                  TitleHeading3Widget(
                                    text: data.value,
                                    color: CustomColor.primaryLightColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  TitleHeading3Widget(
                                    text: data.name,
                                    color:
                                        CustomColor.whiteColor.withOpacity(.30),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment:
                                    index % 2 == 0 ? crossStart : crossEnd,
                                children: [
                                  TitleHeading2Widget(
                                      text: data.value,
                                      color: CustomColor.primaryLightColor,
                                      fontWeight: FontWeight.w600),
                                  TitleHeading3Widget(
                                    text: data.name,
                                    color:
                                        CustomColor.whiteColor.withOpacity(.30),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              );
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Dimensions.paddingSize * .75,
        bottom: Dimensions.paddingSize,
      ),
      child: Obx(() => Get.find<SellCryptoController>().isConfirmLoading
          ? const CustomLoadingAPI()
          : PrimaryButton(
              title: Strings.confirm.tr,
              onPressed: () {
                Get.find<SellCryptoController>().sellConfirmStoreProcess();
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
