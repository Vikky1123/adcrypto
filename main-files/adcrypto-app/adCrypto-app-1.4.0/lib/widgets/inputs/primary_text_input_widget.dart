import '../../backend/language/language_controller.dart';
import '../../utils/basic_widget_imports.dart';

class PrimaryTextInputWidget extends StatefulWidget {
  final TextEditingController controller;

  // final double? height;
  final String hintText;
  final String labelText;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final Color? color;
  final double focusedBorderWidth;
  final double enabledBorderWidth;
  final double errorBorderWidth;
  final double focusedErrorBorderWidth;
  final Color borderColor;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final ValueChanged? onWrite;
  final Function(String)? onFieldSubmitted;

  const PrimaryTextInputWidget({
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
    this.onWrite, this.onFieldSubmitted,
  });

  @override
  State<PrimaryTextInputWidget> createState() => _PrimaryTextInputWidgetState();
}

class _PrimaryTextInputWidgetState extends State<PrimaryTextInputWidget> {
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
      crossAxisAlignment: crossStart,
      children: [
        TitleHeading3Widget(
          text: widget.labelText,
          textAlign: TextAlign.left,
          padding: EdgeInsets.only(bottom: Dimensions.paddingSize * .25),
          fontSize: isTablet()
              ? Dimensions.headingTextSize3
              : Dimensions.headingTextSize3,
        ),
        SizedBox(
          //height: widget.height!,
          child: TextFormField(
            style: Get.isDarkMode
                ? CustomStyle.darkHeading3TextStyle.copyWith(
                    color: CustomColor.primaryDarkColor,
                    fontWeight: FontWeight.w600,
                    fontSize: Dimensions.headingTextSize3)
                : CustomStyle.lightHeading3TextStyle.copyWith(
                    color: CustomColor.primaryLightColor,
                    fontWeight: FontWeight.w600,
                    fontSize: Dimensions.headingTextSize3),
            readOnly: widget.readOnly!,
            // style: CustomStyle.textStyle,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            validator: (String? value) {
              if (value!.isEmpty) {
                return Get.find<LanguageSettingController>().isLoading ? "": Get.find<LanguageSettingController>().getTranslation(Strings.pleaseFillOutTheField);
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
                if(widget.onFieldSubmitted != null) {
                  widget.onFieldSubmitted!(value);
                }
                focusNode!.unfocus();
              });
            },
            onChanged: widget.onWrite,
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
                  right: Dimensions.paddingSize * .7,
                  top: isTablet()
                      ? Dimensions.paddingSize * .1
                      : Dimensions.paddingSize * .5,
                  bottom: isTablet()
                      ? Dimensions.paddingSize * .22
                      : Dimensions.paddingSize * .5),
              hintText: Get.find<LanguageSettingController>().isLoading ? "": Get.find<LanguageSettingController>().getTranslation(widget.hintText),
              hintStyle: Get.isDarkMode
                  ? CustomStyle.darkHeading3TextStyle.copyWith(
                      color: CustomColor.primaryDarkTextColor.withOpacity(0.3),
                      fontWeight: FontWeight.w500,
                      fontSize: Dimensions.headingTextSize3,
                    )
                  : CustomStyle.lightHeading3TextStyle.copyWith(
                      color: CustomColor.primaryLightTextColor.withOpacity(0.3),
                      fontWeight: FontWeight.w500,
                      fontSize: Dimensions.headingTextSize3,
                    ),
              suffixIcon: widget.suffixIcon,
            ),
          ),
        )
        // CustomSize.heightBetween()
      ],
    );
  }
}
