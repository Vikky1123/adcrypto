import 'package:adcrypto/backend/utils/custom_snackbar.dart';

import '../../../backend/utils/custom_loading_api.dart';
import '../../../controller/dashboard/exchange_crypto/exchange_crypto_controller.dart';
import '../../../utils/basic_widget_imports.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/dropdown/input_with_dropdown_for_exchange.dart';
import '../../../widgets/others/tooltip_info_widget.dart';
import '../../../widgets/text_labels/title_heading5_widget.dart';

class ExchangeCryptoScreen extends StatelessWidget {
  ExchangeCryptoScreen({super.key});

  final controller = Get.put(ExchangeCryptoController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading
        ? const CustomLoadingAPI()
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
                            Obx(() => TitleHeading5Widget(
                              text: "1 ${controller.fromCurrency.value.code} = ${controller.exchangeRateCalculate(value: controller.fromAmountController.text).toStringAsFixed(6)} ${controller.toCurrency.value.code}",
                              color: CustomColor.primaryLightColor,
                              fontSize: Dimensions.headingTextSize5 - 1,
                              fontWeight: FontWeight.w600,
                            ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                _exchangeCryptoInputWidget(context),
              ],
            ),
          ));
  }

  _exchangeCryptoInputWidget(BuildContext context) {
    return Column(
      children: [
        _exchangeCryptoFromAmountInputWidget(context),
        _exchangeCryptoToAmountInputWidget(context),
        _exchangeCryptoLimitWidget(context),
        _exchangeCryptoButtonWidget(context),
      ],
    );
  }

  _exchangeCryptoFromAmountInputWidget(BuildContext context) {
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
      child: InputWithDropdownForExchange(
        keyboardType: TextInputType.number,
        controller: controller.fromAmountController,
        hintText: Strings.enterAmount.tr,
        borderColor: Get.isDarkMode
            ? CustomColor.primaryDarkTextColor.withOpacity(.15)
            : CustomColor.primaryLightTextColor.withOpacity(.15),
        labelText: Strings.exchangeFrom,
        labelTextFontSize: isTablet()
            ? Dimensions.headingTextSize3
            : Dimensions.headingTextSize3,
        maxBtnFunction: () {

          double walletBalance = double.parse(controller.fromCurrency.value.wallets.first.balance);
          controller.exchangeRateCalculate(value: walletBalance.toString());


          if(walletBalance.isGreaterThan(0)){
            if(walletBalance <= controller.networkCharge.value){
              controller.fromAmountController.text = "0";
              controller.exchangeRateCalculate(value: controller.fromAmountController.text);
            }else{
              controller.fromAmountController.text = ( walletBalance - controller.networkCharge.value).toStringAsFixed(6);
              controller.exchangeRateCalculate(value: controller.fromAmountController.text);
            }
          }
          else{
            controller.fromAmountController.text = "0";
            controller.exchangeRateCalculate(value: controller.fromAmountController.text);
          }

        },
        selectedCurrency: controller.fromCurrency.value,
        valueChanged: (value){
          controller.exchangeRateCalculate(value: value.toString());
        },
        onChanged: (value){
          controller.fromCurrency.value = value!;
          controller.exchangeRateCalculate(value: controller.fromAmountController.text);
        },
      ),
    );
  }

  _exchangeCryptoToAmountInputWidget(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return Padding(
      padding: EdgeInsets.only(
        right: Dimensions.paddingSize,
        left: Dimensions.paddingSize,
        top: Dimensions.paddingSize * .5,
      ),
      child: InputWithDropdownForExchange(
        readOnly: true,
        keyboardType: TextInputType.number,
        controller: controller.toAmountController,
        hintText: Strings.enterAmount.tr,
        borderColor: Get.isDarkMode
            ? CustomColor.primaryDarkTextColor.withOpacity(.15)
            : CustomColor.primaryLightTextColor.withOpacity(.15),
        labelText: Strings.exchangeTo,
        labelTextFontSize: isTablet()
            ? Dimensions.headingTextSize3
            : Dimensions.headingTextSize3,
        selectedCurrency: controller.toCurrency.value,
        onChanged: (value){
          controller.toCurrency.value = value!;
          controller.exchangeRateCalculate(value: controller.fromAmountController.text);
        },
      ),
    );
  }

  _exchangeCryptoLimitWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: Dimensions.paddingSize,
          left: Dimensions.paddingSize,
          top: Dimensions.paddingSize * .3,
          bottom: Dimensions.paddingSize),
      child: Obx(() => Column(
        crossAxisAlignment: crossStart,
        children: [
          ToolTipInfoWidget(
            title: Strings.limit,
            value: "${controller.min.value.toStringAsFixed(6)} - ${controller.max.value.toStringAsFixed(6)} ${controller.fromCurrency.value.code}",
          ),
          ToolTipInfoWidget(
            title: Strings.networkCharge,
            value: "${controller.networkCharge.value.toStringAsFixed(6)} ${controller.fromCurrency.value.code}",
          ),
        ],
      )),
    );
  }

  _exchangeCryptoButtonWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: Dimensions.paddingSize,
        left: Dimensions.paddingSize,
        top: Dimensions.paddingSize * .3,
        bottom: Dimensions.paddingSize * .75,
      ),
      child: Obx(() => controller.isStoreLoading
          ? const CustomLoadingAPI()
          : PrimaryButton(
              title: Strings.exchangeCrypto.tr,
              onPressed: () {
                if (controller.fromAmountController.text.isNotEmpty) {
                  controller.goToExchangeCryptoPreviewScreen();
                }else{
                  CustomSnackBar.error(Strings.pleaseFillOutTheField);
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
