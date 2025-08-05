import 'package:adcrypto/backend/utils/custom_loading_api.dart';
import 'package:flutter/services.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../../widgets/others/custom_image_widget.dart';
import '../../../backend/language/language_controller.dart';
import '../../../backend/model/buy_crypto/buy_crypto_model.dart';
import '../../../controller/dashboard/buy_crypto/buy_crypto_controller.dart';
import '../../../custom_assets/assets.gen.dart';
import '../../../utils/basic_widget_imports.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/inputs/primary_dropdown_input_widget.dart';
import '../../../widgets/text_labels/money_info_widget.dart';

class BuyCryptoScreen extends StatelessWidget {
  BuyCryptoScreen({super.key});

  final buyCryptoController = Get.put(BuyCryptoController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => buyCryptoController.isLoading
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
                        initialLabelIndex: buyCryptoController.selectIndex.value,
                        totalSwitches: buyCryptoController
                            .buyCryptoModel.data.walletType.length,
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
                          buyCryptoController.selectIndex.value = index!;
                        },
                      ),
                    ),
                  ),
                ),
                _inputWidget(context)
              ],
            ),
          ));
  }

  _inputWidget(context) {
    return Column(
      crossAxisAlignment: crossCenter,
      children: [
        _coinAndRowDropdown(context),
        _cryptoAddress(context),
        _paymentMethod(context),
        _amountInputWidget(context),
        _amountLimitWidget(context),
        _buttonWidget(context),
      ],
    );
  }

  _coinAndRowDropdown(context) {
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
              selectedValue: buyCryptoController.selectedCoin.value,
              items: buyCryptoController.buyCryptoModel.data.currencies,
              onChanged: (value) {
                buyCryptoController.selectedCoin.value = value!;
                buyCryptoController.networkList.value = value.networks;
                buyCryptoController.selectedNetwork.value =
                    value.networks.first;

                buyCryptoController
                    .calculation(buyCryptoController.amountController.text);
              },
              displayText: (item) => item.code,
              labelText: Strings.selectCoin.tr,
              borderColor: Get.isDarkMode
                  ? CustomColor.primaryDarkTextColor.withOpacity(.15)
                  : CustomColor.primaryLightTextColor.withOpacity(.15),
              prefixIconBuilder: (coin) {
                var data =
                    buyCryptoController.buyCryptoModel.data.currencyImagePaths;
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
              //Image.asset(coin.coinLogo),
            ),
          ),
          horizontalSpace(Dimensions.widthSize),
          Expanded(
            child: Obx(() => PrimaryDropdownWidget<Network>(
                  selectedValue: buyCryptoController.selectedNetwork.value,
                  items: buyCryptoController.networkList,
                  onChanged: (value) {
                    buyCryptoController.selectedNetwork.value = value!;
                    buyCryptoController
                        .calculation(buyCryptoController.amountController.text);
                  },
                  displayText: (item) => item.name,
                  labelText: Strings.selectNetwork.tr,
                  borderColor: Get.isDarkMode
                      ? CustomColor.primaryDarkTextColor.withOpacity(.15)
                      : CustomColor.primaryLightTextColor.withOpacity(.15),
                )),
          ),
        ],
      ),
    );
  }

  _cryptoAddress(context) {
    return Obx(() => Visibility(
          visible: buyCryptoController.selectIndex.value == 1,
          child: Padding(
            padding: EdgeInsets.only(
              right: Dimensions.paddingSize,
              left: Dimensions.paddingSize,
              top: Dimensions.paddingSize * .75,
            ),
            child: PrimaryTextInputWidget(
              controller: buyCryptoController.cryptoAddressController,
              labelText: Strings.cryptoAddress.tr,
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
                    buyCryptoController.cryptoAddressController.text =
                        clipboardData.text!;
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
            ),
          ),
        ));
  }

  _paymentMethod(context) {
    return Padding(
      padding: EdgeInsets.only(
        right: Dimensions.paddingSize,
        left: Dimensions.paddingSize,
        top: Dimensions.paddingSize * .75,
      ),
      child: PrimaryDropdownWidget<PaymentGateway>(
        selectedValue: buyCryptoController.selectedPaymentMethod.value,
        items: buyCryptoController.buyCryptoModel.data.paymentGateway,
        onChanged: (value) {
          buyCryptoController.selectedPaymentMethod.value = value!;
          buyCryptoController
              .calculation(buyCryptoController.amountController.text);
        },
        displayText: (item) => item.name,
        labelText: Strings.paymentMethod.tr,
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
        controller: buyCryptoController.amountController,
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
                  text: buyCryptoController.selectedCoin.value.code,
                  textAlign: TextAlign.center,
                )),
          ),
        ),
        onWrite: (value) {
          buyCryptoController.calculation(value.toString());
        },
      ),
    );
  }

  _amountLimitWidget(context) {
    return MoneyInfoWidget(
      limit:
          "${buyCryptoController.min.value.toStringAsFixed(6)} ~ ${buyCryptoController.max.value.toStringAsFixed(6)} ${buyCryptoController.selectedCoin.value.code}",
      rate:
          "1 ${buyCryptoController.selectedCoin.value.code} = ${buyCryptoController.exchangeRate.value.toStringAsFixed(6)} ${buyCryptoController.selectedPaymentMethod.value.currencyCode}",
      networkFees:
          "${buyCryptoController.fee.value.toStringAsFixed(6)} ${buyCryptoController.selectedPaymentMethod.value.currencyCode}",
    );
  }

  _buttonWidget(context) {
    return Padding(
      padding: EdgeInsets.only(
        right: Dimensions.paddingSize,
        left: Dimensions.paddingSize,
        top: Dimensions.paddingSize * .3,
      ),
      child: Obx(() => buyCryptoController.isStoreLoading
          ? const CustomLoadingAPI()
          : PrimaryButton(
              title: Strings.continueBtn.tr,
              onPressed: () {
                buyCryptoController.buyCryptoStoreProcess();
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
