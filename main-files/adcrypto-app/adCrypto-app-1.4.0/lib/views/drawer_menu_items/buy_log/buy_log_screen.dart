
import '../../../../views/drawer_menu_items/buy_log/buy_log_screen_mobile.dart';

import '../../../../../utils/basic_screen_imports.dart';
import '../../../../../utils/responsive_layout.dart';

class BuyLogScreen extends StatelessWidget {
  const BuyLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: BuyLogScreenMobile(),
    );
  }
}