
import '../../../../views/drawer_menu_items/sell_log/sell_log_screen_mobile.dart';

import '../../../../../utils/basic_screen_imports.dart';
import '../../../../../utils/responsive_layout.dart';

class SellLogScreen extends StatelessWidget {
  const SellLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  ResponsiveLayout(
      mobileScaffold: SellLogScreenMobile(),
    );
  }
}