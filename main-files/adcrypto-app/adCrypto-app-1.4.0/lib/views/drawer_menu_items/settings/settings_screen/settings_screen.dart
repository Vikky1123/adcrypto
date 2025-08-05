
import '../../../../views/drawer_menu_items/settings/settings_screen/settings_screen_mobile.dart';

import '../../../../../utils/basic_screen_imports.dart';
import '../../../../../utils/responsive_layout.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   ResponsiveLayout(
      mobileScaffold: SettingsScreenMobile(),
    );
  }
}