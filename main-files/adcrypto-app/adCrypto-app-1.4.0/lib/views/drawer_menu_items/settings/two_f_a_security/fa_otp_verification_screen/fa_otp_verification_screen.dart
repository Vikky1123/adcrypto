
import '../../../../../utils/basic_screen_imports.dart';
import '../../../../../utils/responsive_layout.dart';
import 'fa_otp_verification_screen_mobile.dart';



class FAOtpVerificationScreen extends StatelessWidget {
  const FAOtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold:
      FAOtpVerificationScreenMobile(),
    );
  }
}