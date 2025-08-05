


import '../../utils/basic_widget_imports.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: TitleHeading2Widget(
            text: Strings.noDataFound,
            color: CustomColor.primaryLightColor,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600));
  }
}
