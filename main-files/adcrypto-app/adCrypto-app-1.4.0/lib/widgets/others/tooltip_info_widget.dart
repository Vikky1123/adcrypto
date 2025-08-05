import '../../utils/basic_screen_imports.dart';
import '../text_labels/title_heading5_widget.dart';

class ToolTipInfoWidget extends StatelessWidget {
  const ToolTipInfoWidget({super.key, required this.title, required this.value});

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TitleHeading5Widget(
          text: title,
          color: Get.isDarkMode
              ? CustomColor.primaryDarkColor
              : CustomColor.primaryLightColor,
          fontWeight: FontWeight.w500,
        ),
        TitleHeading5Widget(
          text: value,
          color: Get.isDarkMode
              ? CustomColor.primaryDarkColor
              : CustomColor.primaryLightColor,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
