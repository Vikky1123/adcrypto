import '../../../../views/tab_screen/preview_screen/sell_crypto_preview_screen/sell_crypto_preview_screen_mobile.dart';

import '../../../../../utils/basic_screen_imports.dart';
import '../../../../../utils/responsive_layout.dart';

class SellCryptoPreviewScreen extends StatelessWidget {
  const SellCryptoPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  ResponsiveLayout(
      mobileScaffold: SellCryptoPreviewScreenMobile(),
    );
  }
}