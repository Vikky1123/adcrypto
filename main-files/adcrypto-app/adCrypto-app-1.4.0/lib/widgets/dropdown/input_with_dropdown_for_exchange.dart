import 'package:dropdown_button2/dropdown_button2.dart';

import '../../../../controller/dashboard/exchange_crypto/exchange_crypto_controller.dart';
import '../../backend/language/language_controller.dart';
import '../../backend/model/exchange_crypto/exchange_crypto_model.dart';
import '../../utils/basic_widget_imports.dart';
import '../text_labels/title_heading5_widget.dart';

class InputWithDropdownForExchange extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final Color? color;
  final double focusedBorderWidth;
  final double enabledBorderWidth;
  final double errorBorderWidth;
  final double focusedErrorBorderWidth;
  final double? labelTextFontSize;
  final Color borderColor;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final VoidCallback? maxBtnFunction;
  final Currency selectedCurrency;
  final void Function(Currency?)? onChanged;
  final ValueChanged? valueChanged;

  const InputWithDropdownForExchange({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.readOnly = false,
    this.focusedBorderWidth = 2,
    this.enabledBorderWidth = 2.5,
    this.errorBorderWidth = 2,
    this.focusedErrorBorderWidth = 2,
    this.color = Colors.white,
    required this.borderColor,
    this.suffixIcon,
    this.onTap,
    required this.labelText,
    this.labelTextFontSize = 14.00,
    this.maxBtnFunction,
    required this.selectedCurrency,
    this.onChanged, this.valueChanged,
  });

  @override
  State<InputWithDropdownForExchange> createState() => _InputWithDropdownForExchangeState();
}

class _InputWithDropdownForExchangeState extends State<InputWithDropdownForExchange> {
  FocusNode? focusNode;
  final currencyController = Get.put(ExchangeCryptoController());

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return Column(
      crossAxisAlignment: crossStart,
      children: [
        TitleHeading3Widget(
          text: widget.labelText,
          textAlign: TextAlign.left,
          padding: EdgeInsets.only(bottom: Dimensions.paddingSize * .25),
          fontSize: widget.labelTextFontSize,
        ),
        TextFormField(
          style: Get.isDarkMode
              ? CustomStyle.darkHeading4TextStyle.copyWith(
                  color: CustomColor.primaryDarkColor,
                  fontWeight: FontWeight.w600,
                  fontSize: Dimensions.headingTextSize3)
              : CustomStyle.lightHeading4TextStyle.copyWith(
                  color: CustomColor.primaryLightColor,
                  fontWeight: FontWeight.w600,
                  fontSize: Dimensions.headingTextSize3),
          readOnly: widget.readOnly!,
          // style: CustomStyle.textStyle,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          validator: (String? value) {
            if (value!.isEmpty) {
              return Strings.pleaseFillOutTheField;
            } else {
              return null;
            }
          },
          onTap: () {
            setState(() {
              focusNode!.requestFocus();
            });
          },
          onFieldSubmitted: (value) {
            setState(() {
              focusNode!.unfocus();
            });
          },
          onChanged: widget.valueChanged,
          focusNode: focusNode,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius * 0.5),
                topRight: Radius.circular(Dimensions.radius * 0.5),
              ),
              borderSide: BorderSide(
                color: widget.borderColor.withOpacity(0.4),
                width: widget.enabledBorderWidth,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius * 0.8),
                topRight: Radius.circular(Dimensions.radius * 0.8),
              ),
              borderSide: BorderSide(
                color: CustomColor.primaryLightColor,
                width: widget.focusedBorderWidth,
              ),
            ),
            errorBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius * 0.8),
                topRight: Radius.circular(Dimensions.radius * 0.8),
              ),
              borderSide: BorderSide(
                  color: Colors.red, width: widget.errorBorderWidth),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius * 0.8),
                topRight: Radius.circular(Dimensions.radius * 0.8),
              ),
              borderSide: BorderSide(
                  color: Colors.red, width: widget.focusedErrorBorderWidth),
            ),
            filled: true,
            fillColor: focusNode!.hasFocus
                ? CustomColor.primaryLightColor.withOpacity(.15)
                : CustomColor.whiteColor.withOpacity(.06),
            contentPadding: EdgeInsets.only(
                left: Dimensions.paddingSize * .75,
                right: Dimensions.paddingSize * .5,
                top: isTablet()
                    ? Dimensions.paddingSize * .5
                    : Dimensions.paddingSize * .4,
                bottom: isTablet()
                    ? Dimensions.paddingSize * .5
                    : Dimensions.paddingSize * .25),
            hintText: Get.find<LanguageSettingController>().isLoading ? "": Get.find<LanguageSettingController>().getTranslation(widget.hintText),
            hintStyle: Get.isDarkMode
                ? CustomStyle.darkHeading3TextStyle.copyWith(
                    color: CustomColor.primaryDarkTextColor.withOpacity(0.3),
                    fontWeight: FontWeight.normal,
                    fontSize: Dimensions.headingTextSize5,
                  )
                : CustomStyle.lightHeading3TextStyle.copyWith(
                    color: CustomColor.primaryLightTextColor.withOpacity(0.3),
                    fontWeight: FontWeight.normal,
                    fontSize: Dimensions.headingTextSize5,
                  ),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: mainEnd,
              children: [
                widget.maxBtnFunction == null ? const SizedBox.shrink(): Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingHorizontalSize * .3,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(Dimensions.radius),
                    onTap: widget.maxBtnFunction,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSize * .30,
                          vertical: Dimensions.paddingSize * .05),
                      decoration: BoxDecoration(
                        color: CustomColor.primaryLightColor.withOpacity(.06),
                        borderRadius: BorderRadius.all(
                          Radius.circular(Dimensions.radius * .5),
                        ),
                      ),
                      child: const TitleHeading5Widget(
                        text: Strings.max,
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Container(
                    padding: EdgeInsets.only(
                      // left: Dimensions.paddingSize * .80,
                        top: isTablet()
                            ? Dimensions.paddingSize * .55
                            : Dimensions.paddingSize * .0001,
                        bottom: isTablet()
                            ? Dimensions.paddingSize * .55
                            : Dimensions.paddingSize * .0001),
                    decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? CustomColor.primaryDarkColor
                          : CustomColor.primaryLightColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          Dimensions.radius * 0.5,
                        ),
                        topRight: Radius.circular(
                          Dimensions.radius * 0.5,
                        ),
                      ),
                    ),
                    width: Dimensions.widthSize * 11,
                    child: DropdownButton2<Currency>(
                      isDense: false,
                      isExpanded: true,
                      iconStyleData: const IconStyleData(
                        icon: Padding(
                          padding: EdgeInsets.only(right: 4),
                          child: Icon(
                            Icons.arrow_drop_down_rounded,
                            color: CustomColor.whiteColor,
                          ),
                        ),
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: MediaQuery.sizeOf(context).height * .26,
                        decoration: BoxDecoration(
                          color: CustomColor.primaryDarkScaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(Dimensions.radius),
                        ),
                      ),
                      underline: Container(

                      ),
                      items: currencyController.currencyList
                          .map<DropdownMenuItem<Currency>>(
                        (value) {
                          return DropdownMenuItem<Currency>(
                            value: value,
                            child: TitleHeading3Widget(
                              padding: EdgeInsets.symmetric(
                                vertical: isTablet()
                                    ? Dimensions.paddingSize * .01
                                    : Dimensions.paddingSize * .25,
                              ),
                              textAlign: TextAlign.center,
                              text: value.code.toString(),
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: widget.onChanged,
                      value: widget.selectedCurrency,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}