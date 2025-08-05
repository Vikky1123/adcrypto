import '../../../../../utils/basic_screen_imports.dart';
import '../../../../../utils/responsive_layout.dart';
import '../../../../views/drawer_menu_items/exchange_log/exchange_log_screen_mobile.dart';

class ExchangeLogScreen extends StatelessWidget {
  const ExchangeLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: ExchangeLogScreenMobile(),
    );
  }
}