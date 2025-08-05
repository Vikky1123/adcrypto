import 'package:get/get.dart';

import '../../../../views/auth/sign_in/forgot_password_otp_verification_screen/forgot_password_otp_verification_screen.dart';
import '../../../../views/auth/sign_in/reset_password_screen/reset_password_screen.dart';
import '../../../../views/dashboard/dashboard_screen/dashboard_screen.dart';
import '../../../../views/dashboard/update_profile/update_profile_screen.dart';
import '../../../../views/onboard/onboard_screen.dart';
import '../../../routes/routes.dart';
import '../bindings/dashboard_screen_binding.dart';
import '../bindings/splash_screen_binding.dart';
import '../views/auth/kyc_form_screen/kyc_form_screen.dart';
import '../views/auth/sign_in/sign_in_screen/sign_in_screen.dart';
import '../views/auth/sign_up/sign_up_otp_screen/sign_up_otp_screen.dart';
import '../views/auth/sign_up/sign_up_screen/sign_up_screen.dart';
import '../views/dashboard/view_more/view_more_screen.dart';
import '../views/drawer_menu_items/buy_log/buy_log_screen.dart';
import '../views/drawer_menu_items/buy_log/transaction_tatum_manual_screen.dart';
import '../views/drawer_menu_items/exchange_log/exchange_log_screen.dart';
import '../views/drawer_menu_items/notification/notification_screen.dart';
import '../views/drawer_menu_items/sell_log/sell_log_screen.dart';
import '../views/drawer_menu_items/settings/change_password/change_password_screen.dart';
import '../views/drawer_menu_items/settings/settings_screen/settings_screen.dart';
import '../views/drawer_menu_items/settings/two_f_a_security/fa_otp_verification_screen/fa_otp_verification_screen.dart';
import '../views/drawer_menu_items/settings/two_f_a_security/two_f_a_security_screen.dart';
import '../views/drawer_menu_items/withdraw_log/withdraw_log_screen.dart';
import '../views/splash_screen/splash_screen.dart';
import '../views/tab_screen/manual_screen/buy_crypto_manual_screen.dart';
import '../views/tab_screen/manual_screen/sell_crypto_manual_screen.dart';
import '../views/tab_screen/outside_screen/outside_qr_screen.dart';
import '../views/tab_screen/preview_screen/buy_crypto_preview_screen/buy_crypto_preview_screen.dart';
import '../views/tab_screen/preview_screen/exchange_crypto_preview_screen/exchange_crypto_preview_screen.dart';
import '../views/tab_screen/preview_screen/sell_crypto_preview_screen/sell_crypto_preview_screen.dart';
import '../views/tab_screen/preview_screen/withdraw_crypto_preview_screen/withdraw_crypto_preview_screen.dart';
import '../views/tab_screen/tabs/sell_crypto_payment_proof_screen/sell_crypto_payment_proof_screen.dart';

class RoutePageList {
  static var list = [
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.onboardScreen,
      page: () => const OnBoardScreen(),
    ),
    GetPage(
      name: Routes.signInScreen,
      page: () => const SignInScreen(),
    ),
    GetPage(
      name: Routes.forgotPasswordOtpScreen,
      page: () => const ForgotPasswordOtpVerificationScreen(),
    ),
    GetPage(
      name: Routes.resetPasswordScreen,
      page: () => const ResetPasswordScreen(),
    ),
    GetPage(
      name: Routes.signUpScreen,
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: Routes.signUpOtpScreen,
      page: () => const SignUpOtpScreen(),
    ),
    GetPage(
      name: Routes.kycFormScreen,
      page: () => KYCFormScreen(),
    ),
    GetPage(
      name: Routes.dashboardScreen,
      page: () => const DashboardScreen(),
      binding: DashboardBinding()
    ),
    GetPage(
      name: Routes.updateProfileScreen,
      page: () => const UpdateProfileScreen(),
    ),
    GetPage(
      name: Routes.notificationScreen,
      page: () => const NotificationScreen(),
    ),
    GetPage(
      name: Routes.buyLogScreen,
      page: () => const BuyLogScreen(),
    ),
    GetPage(
      name: Routes.sellLogScreen,
      page: () => const SellLogScreen(),
    ),
    GetPage(
      name: Routes.withdrawLogScreen,
      page: () => const WithdrawLogScreen(),
    ),
    GetPage(
      name: Routes.exchangeLogScreen,
      page: () => const ExchangeLogScreen(),
    ),
    GetPage(
      name: Routes.settingsScreen,
      page: () => const SettingsScreen(),
    ),
    GetPage(
      name: Routes.twoFASecurityScreen,
      page: () => const TwoFASecurityScreen(),
    ),
    GetPage(
      name: Routes.changePasswordScreen,
      page: () => const ChangePasswordScreen(),
    ),
    GetPage(
      name: Routes.sellCryptoQRScreen,
      page: () => const OutsideQRScreen(),
    ),
    GetPage(
      name: Routes.sellCryptoPaymentProofScreen,
      page: () => const SellCryptoPaymentProofScreen(),
    ),
    //
    GetPage(
      name: Routes.buyCryptoPreviewScreen,
      page: () => const BuyCryptoPreviewScreen(),
    ),
    GetPage(
      name: Routes.buyCryptoManualScreen,
      page: () => BuyCryptoManualScreen(),
    ),
    GetPage(
      name: Routes.transactionTatumManualScreen,
      page: () => TransactionTatumManualScreen(),
    ),
    GetPage(
      name: Routes.sellCryptoPreviewScreen,
      page: () => const SellCryptoPreviewScreen(),
    ),
    GetPage(
      name: Routes.sellCryptoManualScreen,
      page: () => SellCryptoManualScreen(),
    ),
    GetPage(
      name: Routes.withdrawCryptoPreviewScreen,
      page: () => const WithdrawCryptoPreviewScreen(),
    ),
    GetPage(
      name: Routes.exchangeCryptoPreviewScreen,
      page: () => const ExchangeCryptoPreviewScreen(),
    ),


    GetPage(
      name: Routes.viewMoreScreen,
      page: () => const ViewMoreScreen(),
    ),

    GetPage(
      name: Routes.currencyDetailScreen,
      page: () => const ViewMoreScreen(),
    ),

    GetPage(
      name: Routes.faOtpVerificationScreen,
      page: () => const FAOtpVerificationScreen(),
    ),
  ];
}