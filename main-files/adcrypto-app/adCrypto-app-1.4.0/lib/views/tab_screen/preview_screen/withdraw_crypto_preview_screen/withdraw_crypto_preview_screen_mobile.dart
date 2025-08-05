import 'package:adcrypto/backend/utils/custom_loading_api.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import '../../../../controller/dashboard/withdraw_crypto/withdraw_crypto_controller.dart';
import '../../../../custom_assets/assets.gen.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/others/custom_back_button.dart';
import '../../../../widgets/others/custom_image_widget.dart';

class WithdrawCryptoPreviewScreenMobile extends StatelessWidget {
  WithdrawCryptoPreviewScreenMobile({super.key});

  final previewInfo = Get.find<WithdrawCryptoController>().withdrawCryptoStoreModel.data.data.data;

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
            padding: EdgeInsets.only(bottom: Dimensions.paddingSize),
            color: CustomColor.primaryLightColor.withOpacity(.06),
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
                      text: "${previewInfo.amount} ${previewInfo.senderWallet.code}",
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
                text: "${previewInfo.amount} ${previewInfo.senderWallet.code}",
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
                  text: "1 ${previewInfo.senderWallet.code} = ${previewInfo.exchangeRate.toStringAsFixed(6)} ${previewInfo.receiverWallet.code}",
                  color: CustomColor.orangeColor,
                  fontWeight: FontWeight.w700,
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
                text: Strings.networkChargeText,
                fontWeight: FontWeight.w500,
                color: CustomColor.whiteColor.withOpacity(
                  .2,
                ),
              ),
              TitleHeading3Widget(
                text: "${previewInfo.totalCharge.toStringAsFixed(6)} ${previewInfo.senderWallet.code}",
                color: CustomColor.redColor.withOpacity(.8),
                fontWeight: FontWeight.w600,
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
                  text: "${previewInfo.payableAmount.toStringAsFixed(6)} ${previewInfo.senderWallet.code}",
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

  _buttonWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Dimensions.paddingSize * .75,
        bottom: Dimensions.paddingSize,
      ),
      child: Obx(() => Get.find<WithdrawCryptoController>().isConfirmLoading
          ? const CustomLoadingAPI()
          : PrimaryButton(
              title: Strings.confirm.tr,
              onPressed: () {
                Get.find<WithdrawCryptoController>().withdrawCryptoConfirmProcess();
              },
              borderColor: Get.isDarkMode
                  ? CustomColor.primaryDarkColor
                  : CustomColor.primaryLightColor,
              buttonColor: Get.isDarkMode
                  ? CustomColor.primaryDarkColor
                  : CustomColor.primaryLightColor,
            ))
    );
  }
}
