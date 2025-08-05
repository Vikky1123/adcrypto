import '../../../../../utils/basic_screen_imports.dart';
import '../../../../../utils/responsive_layout.dart';
import 'outside_qr_screen_mobile.dart';

class OutsideQRScreen extends StatelessWidget {
  const OutsideQRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  ResponsiveLayout(
      mobileScaffold: OutsideQRScreenScreenMobile(),
    );
  }
}