import 'package:flutter/services.dart';

import '../../../../controller/dashboard/sell_crypto/sell_crypto_controller.dart';
import '../../../../controller/dashboard/sell_crypto/sell_crypto_payment_proof_controller/sell_crypto_payment_proof_controller.dart';
import '../../../../custom_assets/assets.gen.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/image_picker/ss_image_upload_widget.dart';
import '../../../../widgets/others/custom_back_button.dart';
import '../../../../widgets/others/custom_image_widget.dart';

class SellCryptoPaymentProofScreenMobile extends StatelessWidget {
  SellCryptoPaymentProofScreenMobile({super.key});

  final controller = Get.put(SellCryptoPaymentProofController());
  final sellCryptoController = Get.put(SellCryptoController());
  final sellCryptoInputFormKey = GlobalKey<FormState>();

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
          title: TitleHeading3Widget(
            padding: EdgeInsets.only(left: Dimensions.paddingSize * 4),
            text: Strings.sellCrypto.tr,
          ),
        ),
        backgroundColor: CustomColor.transparentColor,
        body: _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return Form(
      key: sellCryptoInputFormKey,
      child: ListView(
        padding: EdgeInsets.only(
            right: Dimensions.paddingSize, left: Dimensions.paddingSize),
        children: [
          _paymentProofTextWidget(context),
          _addressTrxAndScreenShotWidget(context),
          _receivingMethodInformationWidget(context),
          _receivingMethodInformationInputWidget(context),
          _buttonWidget(context),
        ],
      ),
    );
  }

  _paymentProofTextWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimensions.paddingSize * .15),
      height: MediaQuery.of(context).size.height * .05,
      decoration: BoxDecoration(
        color: CustomColor.primaryLightColor.withOpacity(
          .06,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            Dimensions.radius * 1.5,
          ),
          topRight: Radius.circular(
            Dimensions.radius * 1.5,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: mainMin,
        crossAxisAlignment: crossStart,
        mainAxisAlignment: mainCenter,
        children: [
          TitleHeading2Widget(
            padding: EdgeInsets.only(left: Dimensions.paddingSize),
            text: Strings.paymentProof,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }

  _addressTrxAndScreenShotWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimensions.paddingSize * .5),
      padding:
          EdgeInsets.symmetric(vertical: Dimensions.paddingVerticalSize * .5),
      decoration: BoxDecoration(
        color: CustomColor.primaryLightColor.withOpacity(
          .06,
        ),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(
            Dimensions.radius,
          ),
          bottomLeft: Radius.circular(
            Dimensions.radius,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: mainMin,
        crossAxisAlignment: crossStart,
        // mainAxisAlignment: mainCenter,
        children: [
          Padding(
            padding: EdgeInsets.only(
              right: Dimensions.paddingSize,
              left: Dimensions.paddingSize,
              top: Dimensions.paddingSize * .25,
            ),
            child: PrimaryTextInputWidget(
              controller: sellCryptoController.selectIndex.value == 0
                  ? controller.sellCryptoInsideWalletAddressController
                  : controller.sellCryptoOutsideWalletAddressController,
              labelText: Strings.fromCryptoAddress.tr,
              hintText: Strings.enterOrPasteAddress.tr,
              borderColor: Get.isDarkMode
                  ? CustomColor.primaryDarkTextColor.withOpacity(.15)
                  : CustomColor.primaryLightTextColor.withOpacity(.15),
              suffixIcon: InkWell(
                onTap: () async {
                  // Get the clipboard data
                  ClipboardData? clipboardData =
                      await Clipboard.getData(Clipboard.kTextPlain);
                  // Check if clipboard data is not null and has text
                  if (clipboardData != null && clipboardData.text != null) {
                    sellCryptoController.selectIndex.value == 0
                        ? controller.sellCryptoInsideWalletAddressController
                            .text = clipboardData.text!
                        : controller.sellCryptoOutsideWalletAddressController
                            .text = clipboardData.text!;
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    right: Dimensions.paddingSize * .5,
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
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: Dimensions.paddingSize,
              left: Dimensions.paddingSize,
              top: Dimensions.paddingSize * .25,
            ),
            child: PrimaryTextInputWidget(
              controller: sellCryptoController.selectIndex.value == 0
                  ? controller.sellCryptoInsideWalletTrxController
                  : controller.sellCryptoOutsideWalletTrxController,
              hintText: Strings.enterHere,
              borderColor: Get.isDarkMode
                  ? CustomColor.primaryDarkTextColor.withOpacity(.15)
                  : CustomColor.primaryLightTextColor.withOpacity(.15),
              labelText: Strings.trx,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: Dimensions.paddingSize,
              left: Dimensions.paddingSize,
              top: Dimensions.paddingSize * .25,
            ),
            child: Column(
              crossAxisAlignment: crossStart,
              children: [
                TitleHeading3Widget(
                  text: Strings.screenShot,
                  textAlign: TextAlign.left,
                  padding:
                      EdgeInsets.only(bottom: Dimensions.paddingSize * .25),
                ),
                SSImageUploadWidget(
                  title: Strings.screenShot,
                ),
                verticalSpace(Dimensions.heightSize * .8)
              ],
            ),
          ),
        ],
      ),
    );
  }

  _receivingMethodInformationWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimensions.paddingSize * .15),
      height: MediaQuery.of(context).size.height * .05,
      decoration: BoxDecoration(
        color: CustomColor.primaryLightColor.withOpacity(
          .06,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            Dimensions.radius * 1.5,
          ),
          topRight: Radius.circular(
            Dimensions.radius * 1.5,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: mainMin,
        crossAxisAlignment: crossStart,
        mainAxisAlignment: mainCenter,
        children: [
          TitleHeading2Widget(
            padding: EdgeInsets.only(left: Dimensions.paddingSize),
            text: Strings.receivingMethodInformation,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }

  _receivingMethodInformationInputWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimensions.paddingSize * .25),
      decoration: BoxDecoration(
        color: CustomColor.primaryLightColor.withOpacity(
          .06,
        ),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(
            Dimensions.radius,
          ),
          bottomLeft: Radius.circular(
            Dimensions.radius,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: mainMin,
        crossAxisAlignment: crossStart,
        // mainAxisAlignment: mainCenter,
        children: [
          Padding(
            padding: EdgeInsets.only(
              right: Dimensions.paddingSize,
              left: Dimensions.paddingSize,
              top: Dimensions.paddingSize * .5,
            ),
            child: PrimaryTextInputWidget(
              controller: sellCryptoController.selectIndex.value == 0
                  ? controller.sellCryptoInsideWalletBankNameController
                  : controller.sellCryptoOutsideWalletBankNameController,
              hintText: Strings.enterHere,
              borderColor: Get.isDarkMode
                  ? CustomColor.primaryDarkTextColor.withOpacity(.15)
                  : CustomColor.primaryLightTextColor.withOpacity(.15),
              labelText: Strings.bankName,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: Dimensions.paddingSize,
              left: Dimensions.paddingSize,
              top: Dimensions.paddingSize * .25,
            ),
            child: PrimaryTextInputWidget(
              controller: sellCryptoController.selectIndex.value == 0
                  ? controller.sellCryptoInsideWalletBankAccNumberController
                  : controller.sellCryptoOutsideWalletBankAccNumberController,
              hintText: Strings.enterHere,
              borderColor: Get.isDarkMode
                  ? CustomColor.primaryDarkTextColor.withOpacity(.15)
                  : CustomColor.primaryLightTextColor.withOpacity(.15),
              labelText: Strings.bankAccNumber,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: Dimensions.paddingSize,
              left: Dimensions.paddingSize,
              top: Dimensions.paddingSize * .25,
              bottom: Dimensions.paddingSize * .75,
            ),
            child: PrimaryTextInputWidget(
              controller: sellCryptoController.selectIndex.value == 0
                  ? controller.sellCryptoInsideWalletBranchNameController
                  : controller.sellCryptoOutsideWalletBranchNameController,
              hintText: Strings.enterHere,
              borderColor: Get.isDarkMode
                  ? CustomColor.primaryDarkTextColor.withOpacity(.15)
                  : CustomColor.primaryLightTextColor.withOpacity(.15),
              labelText: Strings.branch,
            ),
          ),
        ],
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: Dimensions.paddingSize,
        left: Dimensions.paddingSize,
        top: Dimensions.paddingSize * .3,
        bottom: Dimensions.paddingSize * .75,
      ),
      child: PrimaryButton(
        title: Strings.continueBtn.tr,
        onPressed: () {
          if (sellCryptoInputFormKey.currentState!.validate()) {
            controller.goToSellCryptoPreviewScreen();
          }
        },
        borderColor: Get.isDarkMode
            ? CustomColor.primaryDarkColor
            : CustomColor.primaryLightColor,
        buttonColor: Get.isDarkMode
            ? CustomColor.primaryDarkColor
            : CustomColor.primaryLightColor,
      ),
    );
  }
}
