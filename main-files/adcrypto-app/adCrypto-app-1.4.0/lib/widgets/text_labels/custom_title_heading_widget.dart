import 'package:adcrypto/backend/language/language_controller.dart';

import '../../../../utils/basic_screen_imports.dart';
class CustomTitleHeadingWidget extends StatelessWidget {
  const CustomTitleHeadingWidget({
    super.key,
    required this.text,
    this.textAlign,
    this.textOverflow,
    this.padding = paddingValue,
    this.opacity = 1.0,
    required this.style,
    this.maxLines,
  });

  final String text;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final EdgeInsetsGeometry padding;
  final double opacity;
  final TextStyle style;
  final int? maxLines;
  static const paddingValue = EdgeInsets.all(0.0);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Padding(
        padding: padding,
        child: Text(
          Get.find<LanguageSettingController>().isLoading ? "": Get.find<LanguageSettingController>().getTranslation(text.tr),
          style: style,
          textAlign: textAlign,
          overflow: textOverflow,
          maxLines: maxLines,
        ),
      ),
    );
  }
}