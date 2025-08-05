
import '../../../../views/drawer_menu_items/withdraw_log/withdraw_log_screen_mobile.dart';

import '../../../../../utils/basic_screen_imports.dart';
import '../../../../../utils/responsive_layout.dart';

class WithdrawLogScreen extends StatelessWidget {
  const WithdrawLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  ResponsiveLayout(
      mobileScaffold: WithdrawLogScreenMobile(),
    );
  }
}