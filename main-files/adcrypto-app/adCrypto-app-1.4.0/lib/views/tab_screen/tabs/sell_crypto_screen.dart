import 'package:adcrypto/backend/utils/custom_loading_api.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../backend/language/language_controller.dart';
import '../../../backend/model/sell_crypto/sell_crypto_model.dart';
import '../../../controller/dashboard/sell_crypto/sell_crypto_controller.dart';
import '../../../utils/basic_widget_imports.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/inputs/primary_dropdown_input_widget.dart';
import '../../../widgets/text_labels/money_info_widget.dart';

class SellCryptoScreen extends StatelessWidget {
  SellCryptoScreen({super.key});

  final sellCryptoController = Get.put(SellCryptoController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => sellCryptoController.isLoading
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
                Padding(
                  padding: EdgeInsets.only(top: Dimensions.paddingSize * .75),
                  child: Center(
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: ToggleSwitch(
                        initialLabelIndex:
                            sellCryptoController.selectIndex.value,
                        totalSwitches: sellCryptoController
                            .sellCryptoModel.data.walletType.length,
                        minWidth: MediaQuery.of(context).size.width * .33,
                        minHeight: MediaQuery.of(context).size.height * .045,
                        inactiveBgColor:
                            CustomColor.primaryLightColor.withOpacity(.10),
                        activeFgColor: Colors.white,
                        activeBgColor: [
                          CustomColor.primaryLightColor,
                        ],
                        inactiveFgColor: CustomColor.primaryLightColor,
                        customTextStyles: [
                          TextStyle(
                              fontSize: Dimensions.headingTextSize4,
                              fontWeight: FontWeight.bold),
                          TextStyle(
                              fontSize: Dimensions.headingTextSize4,
                              fontWeight: FontWeight.bold)
                        ],
                        labels: [
                          Get.find<LanguageSettingController>().isLoading
                              ? ""
                              : Get.find<LanguageSettingController>()
                                  .getTranslation(Strings.insideWallet),
                          Get.find<LanguageSettingController>().isLoading
                              ? ""
                              : Get.find<LanguageSettingController>()
                                  .getTranslation(Strings.outsideWallet),
                        ],
                        onToggle: (index) {
                          sellCryptoController.selectIndex.value = index!;
                        },
                      ),
                    ),
                  ),
                ),
                _inputWidget(context),
              ],
            ),
          ));
  }

  _inputWidget(context) {
    return Column(
      crossAxisAlignment: crossCenter,
      children: [
        _walletsDropDownWidget(context),
        _receivingMethodWidget(context),
        _amountInputWidget(context),
        _amountLimitWidget(context),
        _buttonWidget(context),
      ],
    );
  }

  _walletsDropDownWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: Dimensions.paddingSize,
        left: Dimensions.paddingSize,
        top: Dimensions.paddingSize * .75,
      ),
      child: Row(
        crossAxisAlignment: crossEnd,
        children: [
          Expanded(
            child: PrimaryDropdownWidget<Currency>(
              selectedValue: sellCryptoController.selectedCoin.value,
              items: sellCryptoController.sellCryptoModel.data.currencies,
              onChanged: (value) {
                sellCryptoController.selectedCoin.value = value!;
                sellCryptoController.networkList.value = value.networks;
                sellCryptoController.selectedNetwork.value =
                    value.networks.first;
                sellCryptoController
                    .calculation(sellCryptoController.amountController.text);
              },
              displayText: (item) => item.code,
              labelText: Strings.selectCoin.tr,
              borderColor: Get.isDarkMode
                  ? CustomColor.primaryDarkTextColor.withOpacity(.15)
                  : CustomColor.primaryLightTextColor.withOpacity(.15),
              prefixIconBuilder: (coin) {
                var data = sellCryptoController
                    .sellCryptoModel.data.currencyImagePaths;
                String prePath = "${data.baseUrl}/${data.pathLocation}";
                return Container(
                  height: Dimensions.heightSize * 2.5,
                  width: Dimensions.widthSize * 2.5,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          "$prePath/${coin.flag}",
                        ),
                        fit: BoxFit.cover,
                      )),
                );
              },
            ),
          ),
          horizontalSpace(Dimensions.widthSize),
          Expanded(
            child: PrimaryDropdownWidget<Network>(
              selectedValue: sellCryptoController.selectedNetwork.value,
              items: sellCryptoController.networkList,
              onChanged: (value) {
                sellCryptoController.selectedNetwork.value = value!;
                sellCryptoController
                    .calculation(sellCryptoController.amountController.text);
              },
              displayText: (item) => item.name,
              labelText: Strings.selectNetwork.tr,
              borderColor: Get.isDarkMode
                  ? CustomColor.primaryDarkTextColor.withOpacity(.15)
                  : CustomColor.primaryLightTextColor.withOpacity(.15),
            ),
          ),
        ],
      ),
    );
  }

  _receivingMethodWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: Dimensions.paddingSize,
        left: Dimensions.paddingSize,
        top: Dimensions.paddingSize * .75,
      ),
      child: PrimaryDropdownWidget<PaymentGateway>(
        selectedValue: sellCryptoController.selectedReceivingMethod.value,
        items: sellCryptoController.sellCryptoModel.data.paymentGateway,
        onChanged: (value) {
          sellCryptoController.selectedReceivingMethod.value = value!;
          sellCryptoController
              .calculation(sellCryptoController.amountController.text);
        },
        displayText: (item) => item.name,
        labelText: Strings.receivingMethod.tr,
        borderColor: Get.isDarkMode
            ? CustomColor.primaryDarkTextColor.withOpacity(.15)
            : CustomColor.primaryLightTextColor.withOpacity(.15),
      ),
    );
  }

  _amountInputWidget(context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return Padding(
      padding: EdgeInsets.only(
        right: Dimensions.paddingSize,
        left: Dimensions.paddingSize,
        top: Dimensions.paddingSize * .75,
      ),
      child: PrimaryTextInputWidget(
        controller: sellCryptoController.amountController,
        labelText: Strings.amount.tr,
        hintText: Strings.enterAmount.tr,
        borderColor: Get.isDarkMode
            ? CustomColor.primaryDarkTextColor.withOpacity(.15)
            : CustomColor.primaryLightTextColor.withOpacity(.15),
        keyboardType: TextInputType.number,
        suffixIcon: Container(
          decoration: BoxDecoration(
            color: Get.isDarkMode
                ? CustomColor.primaryDarkColor
                : CustomColor.primaryLightColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius * 0.5),
              topRight: Radius.circular(Dimensions.radius * 0.5),
            ),
          ),
          width: Dimensions.widthSize * 8,
          child: Center(
            child: Obx(() => TitleHeading3Widget(
                  padding: EdgeInsets.symmetric(
                      vertical: isTablet()
                          ? Dimensions.paddingSize * .25
                          : Dimensions.paddingSize * .45),
                  text: sellCryptoController.selectedCoin.value.code,
                  textAlign: TextAlign.center,
                )),
          ),
        ),
        onWrite: (value) {
          sellCryptoController.calculation(value.toString());
        },
      ),
    );
  }

  _amountLimitWidget(context) {
    return MoneyInfoWidget(
      limit:
          "${sellCryptoController.min.value.toStringAsFixed(6)} ~ ${sellCryptoController.max.value.toStringAsFixed(6)} ${sellCryptoController.selectedCoin.value.code}",
      rate:
          "1 ${sellCryptoController.selectedCoin.value.code} = ${sellCryptoController.exchangeRate.value.toStringAsFixed(6)} ${sellCryptoController.selectedReceivingMethod.value.currencyCode}",
      networkFees:
          "${sellCryptoController.fee.value.toStringAsFixed(6)} ${sellCryptoController.selectedCoin.value.code}",
    );
  }

  _buttonWidget(context) {
    return Padding(
      padding: EdgeInsets.only(
        right: Dimensions.paddingSize,
        left: Dimensions.paddingSize,
        top: Dimensions.paddingSize * .3,
      ),
      child: (sellCryptoController.isStoreLoading ||
              sellCryptoController.isOutsideStoreLoading)
          ? const CustomLoadingAPI()
          : PrimaryButton(
              title: Strings.continueBtn.tr,
              onPressed: () {
                sellCryptoController.sellCryptoStoreProcess();
                // sellCryptoController.goToSellCryptoPreviewScreen();
                // sellCryptoController.goToSellCryptoPaymentProofScreen();
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
