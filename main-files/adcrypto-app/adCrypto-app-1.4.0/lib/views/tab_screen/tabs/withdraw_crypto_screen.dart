import 'package:adcrypto/backend/utils/custom_loading_api.dart';
import 'package:adcrypto/backend/utils/custom_snackbar.dart';
import 'package:flutter/services.dart';

import '../../../../widgets/others/custom_image_widget.dart';
import '../../../controller/dashboard/withdraw_crypto/withdraw_crypto_controller.dart';
import '../../../custom_assets/assets.gen.dart';
import '../../../utils/basic_widget_imports.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/dropdown/input_with_dropdown_for_withdraw.dart';
import '../../../widgets/text_labels/money_info_widget.dart';
import '../../../widgets/text_labels/title_heading5_widget.dart';

class WithdrawCryptoScreen extends StatelessWidget {
  WithdrawCryptoScreen({super.key});

  final controller = Get.put(WithdrawCryptoController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isLoading
          ? const SizedBox.shrink()
          : Container(
              decoration: BoxDecoration(
                color: CustomColor.primaryLightColor.withOpacity(.1),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(
                    Dimensions.radius * 1.5,
                  ),
                  topLeft: Radius.circular(
                    Dimensions.radius * 1.5,
                  ),
                ),
              ),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Padding(
                      padding: EdgeInsets.only(top: Dimensions.paddingSize * .75),
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSize * .9,
                              vertical: Dimensions.paddingSize * .5),
                          decoration: BoxDecoration(
                            color: CustomColor.primaryLightColor.withOpacity(.1),
                            borderRadius: BorderRadius.circular(
                              Dimensions.radius,
                            ),
                          ),
                          child: Column(
                            children: [
                              TitleHeading5Widget(
                                text: Strings.exchangeRate,
                                color: CustomColor.primaryLightColor,
                                fontSize: Dimensions.headingTextSize6,
                              ),
                              TitleHeading5Widget(
                                text:
                                    "1 ${controller.selectedCoin.value.code} = ${controller.exchangeRate.value.toStringAsFixed(6)} ${controller.toCurrencyCode.value}",
                                color: CustomColor.primaryLightColor,
                                fontSize: Dimensions.headingTextSize5 - 1,
                                fontWeight: FontWeight.w600,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  _withdrawCryptoInputWidget(context),
                ],
              ),
            );
    });
  }

  _withdrawCryptoInputWidget(BuildContext context) {
    return Column(
      children: [
        _withdrawCryptoAddressInputWidget(context),
        _withdrawCryptoAmountInputWidget(context),
        _amountLimitWidget(context),
        _withdrawCryptoButtonWidget(context),
      ],
    );
  }

  _withdrawCryptoAddressInputWidget(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return Padding(
      padding: EdgeInsets.only(
        right: Dimensions.paddingSize,
        left: Dimensions.paddingSize,
        top: isTablet()
            ? Dimensions.paddingSize * .75
            : Dimensions.paddingSize * .5,
      ),
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          PrimaryTextInputWidget(
            controller: controller.walletAddressController,
            labelText: Strings.walletAddress.tr,
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
                  // Set the clipboard text to the text field's controller
                  controller.walletAddressController.text = clipboardData.text!;
                  if (controller.walletAddressController.text.isNotEmpty) {
                    controller.search.value = true;
                    controller.withdrawCryptoCheckProcess(
                        controller.walletAddressController.text.toString());
                  } else {
                    controller.search.value = false;
                    controller.validUser.value = false;
                  }
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingHorizontalSize * .3,
                  vertical: Dimensions.paddingSize * .30,
                ),
                child: CircleAvatar(
                  backgroundColor: CustomColor.primaryLightColor,
                  child: CustomImageWidget(
                    path: Assets.icon.iconPasteSvg,
                    height: Dimensions.heightSize * 1.5,
                    width: Dimensions.widthSize * 1.5,
                  ),
                ),
              ),
            ),
            onFieldSubmitted: (value) {
              if (value.toString().isNotEmpty) {
                controller.search.value = true;
                controller.withdrawCryptoCheckProcess(value.toString());
              } else {
                controller.search.value = false;
                controller.validUser.value = false;
              }
            },
          ),
          verticalSpace(5),
          controller.search.value
              ? controller.isCheckLoading
                  ? const CustomLoadingAPI()
                  : TitleHeading5Widget(
                      text: controller.validUser.value
                          ? Strings.validUser
                          : Strings.invalidUser,
                      color: controller.validUser.value
                          ? CustomColor.greenColor
                          : CustomColor.redColor,
                      fontSize: Dimensions.headingTextSize5,
                      fontWeight: FontWeight.w600,
                    )
              : const SizedBox.shrink()
        ],
      ),
    );
  }

  _withdrawCryptoAmountInputWidget(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return Padding(
      padding: EdgeInsets.only(
        right: Dimensions.paddingSize,
        left: Dimensions.paddingSize,
        top: isTablet()
            ? Dimensions.paddingSize * .75
            : Dimensions.paddingSize * .5,
      ),
      child: InputWithDropdownForWithdraw(
        keyboardType: TextInputType.number,
        controller: controller.amountController,
        hintText: Strings.enterAmount.tr,
        borderColor: Get.isDarkMode
            ? CustomColor.primaryDarkTextColor.withOpacity(.15)
            : CustomColor.primaryLightTextColor.withOpacity(.15),
        labelText: Strings.amount,
        labelTextFontSize: isTablet()
            ? Dimensions.headingTextSize3
            : Dimensions.headingTextSize3,
        maxBtnFunction: () {
          double walletBalance = double.parse(controller.selectedCoin.value.wallets.first.balance);
          controller.calculation(walletBalance.toString());

          if(walletBalance.isGreaterThan(0)){
            if(walletBalance <= controller.fee.value){
              controller.amountController.text = "0";
              controller.calculation(controller.amountController.text);
            }else{
              controller.amountController.text = ( walletBalance - controller.fee.value).toStringAsFixed(6);
              controller.calculation(controller.amountController.text);
            }
          }
          else{
            controller.amountController.text = "0";
            controller.calculation(controller.amountController.text);
          }

        },
        selectedCurrency: controller.selectedCoin.value,
        valueChanged: (value) {
          controller.calculation(value.toString());
        },
        onChanged: (value) {
          controller.selectedCoin.value = value!;
          controller.calculation(controller.amountController.text);
        },
      ),
    );
  }

  _amountLimitWidget(context) {
    return MoneyInfoWidget(
      limit:
          "${controller.min.value.toStringAsFixed(6)} ~ ${controller.max.value.toStringAsFixed(6)} ${controller.selectedCoin.value.code}",
      rate: "",
      networkFees:
          "${controller.fee.value.toStringAsFixed(6)} ${controller.selectedCoin.value.code}",
    );
  }

  _withdrawCryptoButtonWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: Dimensions.paddingSize,
        left: Dimensions.paddingSize,
        top: Dimensions.paddingSize * .3,
        bottom: Dimensions.paddingSize * .75,
      ),
      child: controller.isStoreLoading
          ? const CustomLoadingAPI()
          : PrimaryButton(
              title: Strings.continueBtn.tr,
              onPressed: () {
                if (controller.walletAddressController.text.isNotEmpty &&
                    controller.amountController.text.isNotEmpty) {
                  controller.withdrawCryptoStoreProcess();
                } else {
                  CustomSnackBar.error(Strings.pleaseFillOutTheField);
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
