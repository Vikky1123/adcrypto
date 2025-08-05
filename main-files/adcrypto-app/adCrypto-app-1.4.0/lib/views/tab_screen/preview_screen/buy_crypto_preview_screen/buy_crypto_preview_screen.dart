import '../../../../views/tab_screen/preview_screen/buy_crypto_preview_screen/buy_crypto_preview_screen_mobile.dart';

import '../../../../../utils/basic_screen_imports.dart';
import '../../../../../utils/responsive_layout.dart';

class BuyCryptoPreviewScreen extends StatelessWidget {
  const BuyCryptoPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  ResponsiveLayout(
      mobileScaffold: BuyCryptoPreviewScreenMobile(),
    );
  }
}