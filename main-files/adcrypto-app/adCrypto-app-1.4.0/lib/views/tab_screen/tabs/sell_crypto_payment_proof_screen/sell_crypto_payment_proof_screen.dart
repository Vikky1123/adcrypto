import '../../../../views/tab_screen/tabs/sell_crypto_payment_proof_screen/sell_crypto_payment_proof_screen_mobile.dart';

import '../../../../../utils/basic_screen_imports.dart';
import '../../../../../utils/responsive_layout.dart';

class SellCryptoPaymentProofScreen extends StatelessWidget {
  const SellCryptoPaymentProofScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  ResponsiveLayout(
      mobileScaffold: SellCryptoPaymentProofScreenMobile(),
    );
  }
}