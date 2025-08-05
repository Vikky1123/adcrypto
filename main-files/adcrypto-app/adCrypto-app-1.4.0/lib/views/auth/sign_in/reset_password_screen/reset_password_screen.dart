import '../../../../views/auth/sign_in/reset_password_screen/reset_password_screen_mobile.dart';

import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return     ResponsiveLayout(
      mobileScaffold:
      ResetPasswordScreenMobile(),
    );
  }
}