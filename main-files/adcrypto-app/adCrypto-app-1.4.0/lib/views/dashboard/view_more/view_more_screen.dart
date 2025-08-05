import '../../../../../utils/basic_screen_imports.dart';
import '../../../../../utils/responsive_layout.dart';
import 'view_more_screen_mobile.dart';

class ViewMoreScreen extends StatelessWidget {
  const ViewMoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobileScaffold: ViewMoreScreenMobile(),
    );
  }
}