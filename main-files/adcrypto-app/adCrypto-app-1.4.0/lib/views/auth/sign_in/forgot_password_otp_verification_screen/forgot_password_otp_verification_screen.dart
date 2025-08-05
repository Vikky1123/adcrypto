
import '../../../../views/auth/sign_in/forgot_password_otp_verification_screen/forgot_password_otp_verification_screen_mobile.dart';

import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';


class ForgotPasswordOtpVerificationScreen extends StatelessWidget {
  const ForgotPasswordOtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return    ResponsiveLayout(
      mobileScaffold:
      ForgotPasswordOtpVerificationScreenMobile(),
    );
  }
}