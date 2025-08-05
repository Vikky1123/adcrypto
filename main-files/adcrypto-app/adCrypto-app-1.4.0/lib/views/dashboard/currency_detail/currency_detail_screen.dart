import '../../../../../utils/basic_screen_imports.dart';
import '../../../../../utils/responsive_layout.dart';
import '../../../backend/model/buy_crypto/buy_crypto_model.dart';
import 'currency_detail_screen_mobile.dart';

class CurrencyDetailScreen extends StatelessWidget {
  const CurrencyDetailScreen({super.key, required this.currency});
  final Currency currency;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: CurrencyDetailScreenMobile(currency: currency),
    );
  }
}