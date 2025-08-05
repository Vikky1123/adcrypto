import 'package:dropdown_button2/dropdown_button2.dart';

import '../../backend/language/language_controller.dart';
import '../../utils/basic_screen_imports.dart';

class PrimaryDropdownWidget<T> extends StatefulWidget {
  final T? selectedValue;
  final List<T> items;
  final void Function(T?) onChanged;
  final String Function(T) displayText;
  final String labelText;
  final Color borderColor;
  final Widget Function(T)? prefixIconBuilder;
  final String? hintText;

  const PrimaryDropdownWidget({
    super.key,
    this.selectedValue,
    required this.items,
    required this.onChanged,
    required this.displayText,
    required this.labelText,
    required this.borderColor,
    this.prefixIconBuilder,
    this.hintText,
  });

  @override
  State<PrimaryDropdownWidget<T>> createState() =>
      _PrimaryDropdownWidgetState<T>();
}

class _PrimaryDropdownWidgetState<T> extends State<PrimaryDropdownWidget<T>> {
  FocusNode? focusNode;

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleHeading3Widget(
          text: widget.labelText,
          maxLines: 1,
          textOverflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          fontSize: Dimensions.headingTextSize3,
          padding: EdgeInsets.only(bottom: Dimensions.paddingSize * .25),
        ),
        Stack(
          children: [
            TextFormField(
              readOnly: true,
              // validator: (String? value) {
              //   // if (value!.isEmpty) {
              //   //   return Get.find<LanguageSettingController>().isLoading ? "": Get.find<LanguageSettingController>().getTranslation(Strings.pleaseFillOutTheField);
              //   // } else {
              //   //   return null;
              //   // }
              // },
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius * 0.5),
                    topRight: Radius.circular(Dimensions.radius * 0.5),
                  ),
                  borderSide: BorderSide(
                    color: widget.borderColor.withOpacity(0.4),
                    width: 2.5, // Customize as needed
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius * 0.8),
                    topRight: Radius.circular(Dimensions.radius * 0.8),
                  ),
                  borderSide: BorderSide(
                    color: CustomColor.primaryLightColor,
                    width: 2, // Customize as needed
                  ),
                ),
                filled: true,
                fillColor: focusNode!.hasFocus
                    ? CustomColor.primaryLightColor.withOpacity(.15)
                    : CustomColor.whiteColor.withOpacity(.06),
                contentPadding: EdgeInsets.only(
                    left: Dimensions.paddingSize * .75,
                    right: Dimensions.paddingSize * .5,
                    top: Dimensions.paddingSize * .5,
                    bottom: Dimensions.paddingSize * .5),
                hintText: Get.find<LanguageSettingController>().isLoading ? "": Get.find<LanguageSettingController>().getTranslation(widget.hintText ?? ""),
                hintStyle: CustomStyle.lightHeading3TextStyle.copyWith(
                  color: CustomColor.primaryLightTextColor.withOpacity(0.15),
                  fontWeight: FontWeight.normal,
                  fontSize: Dimensions.headingTextSize4,
                ),
              ),
            ),
            DropdownButton2<T>(
              isExpanded: true,
              dropdownStyleData: DropdownStyleData(
                maxHeight: Dimensions.buttonHeight * 3,
                decoration: const BoxDecoration(
                  color: CustomColor.primaryDarkScaffoldBackgroundColor,
                ),
              ),
              underline: const SizedBox.shrink(),
              value: widget.selectedValue,
              items: widget.items
                  .map(
                    (item) => DropdownMenuItem<T>(
                      value: item,
                      child: Padding(
                        padding:  EdgeInsets.symmetric(vertical: Dimensions.paddingVerticalSize*.08 ),
                        child: FittedBox(
                          child: Row(
                            children: [
                              if (widget.prefixIconBuilder != null)
                                widget.prefixIconBuilder!(item),
                              SizedBox(width: Dimensions.widthSize * .8),
                              // Adjust the spacing
                              Text(
                                Get.find<LanguageSettingController>().isLoading ? "": Get.find<LanguageSettingController>().getTranslation(widget.displayText(item)),
                                style: TextStyle(
                                  fontSize: isTablet()
                                      ? Dimensions.headingTextSize5
                                      : Dimensions.headingTextSize3,
                                  color: Get.isDarkMode
                                      ? CustomColor.primaryDarkColor
                                      : CustomColor.primaryLightColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              iconStyleData: IconStyleData(
                  icon: const Icon(
                    Icons.arrow_drop_down,
                  ).paddingOnly(right: 10),
                  iconDisabledColor: CustomColor.whiteColor,
                  iconEnabledColor: CustomColor.primaryDarkColor),
              onChanged: widget.onChanged,
              focusNode: focusNode,
            ),
          ],
        )
      ],
    );
  }
}