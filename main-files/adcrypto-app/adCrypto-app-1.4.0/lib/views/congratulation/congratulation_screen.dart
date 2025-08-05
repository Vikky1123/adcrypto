import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';
import '../../../../views/congratulation/congratulation_screen_mobile.dart';

class CongratulationScreen extends StatelessWidget {


  const CongratulationScreen(
      {super.key, required this.subTitle, required this.route});

  final String subTitle, route;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: CongratulationScreenMobile(
        subTitle: subTitle,
        route: route,
      ),
    );
  }
}