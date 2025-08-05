import '../../../../views/auth/sign_up/sign_up_otp_screen/sign_up_otp_screen_mobile.dart';

import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';


class SignUpOtpScreen extends StatelessWidget {
  const SignUpOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return    ResponsiveLayout(
      mobileScaffold:
      SignUpOtpScreenMobile(),
    );
  }
}