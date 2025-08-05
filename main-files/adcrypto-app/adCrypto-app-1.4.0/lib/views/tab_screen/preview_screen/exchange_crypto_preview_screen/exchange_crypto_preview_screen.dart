import '../../../../views/tab_screen/preview_screen/exchange_crypto_preview_screen/exchange_crypto_preview_screen_mobile.dart';
import '../../../../../utils/basic_screen_imports.dart';
import '../../../../../utils/responsive_layout.dart';

class ExchangeCryptoPreviewScreen extends StatelessWidget {
  const ExchangeCryptoPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  ResponsiveLayout(
      mobileScaffold: ExchangeCryptoPreviewScreenMobile(),
    );
  }
}