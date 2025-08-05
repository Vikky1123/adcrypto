import '../../../../views/tab_screen/preview_screen/withdraw_crypto_preview_screen/withdraw_crypto_preview_screen_mobile.dart';


import '../../../../../utils/basic_screen_imports.dart';
import '../../../../../utils/responsive_layout.dart';

class WithdrawCryptoPreviewScreen extends StatelessWidget {
  const WithdrawCryptoPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  ResponsiveLayout(
      mobileScaffold: WithdrawCryptoPreviewScreenMobile(),
    );
  }
}