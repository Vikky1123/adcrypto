import 'package:adcrypto/extensions/custom_extensions.dart';

class ApiEndpoint {

static const String mainDomain = "put-your-own-domain";


  static const String baseUrl = "$mainDomain/api/v1";

  static String languageURL = '/language'.addBaseURl();
  static String basicSettingsUrl = '/basic-settings'.addBaseURl();
  static String countryListUrl = '/country-list'.addBaseURl();

  static String loginURL = '/login'.addBaseURl();
  static String forgotPassURL = '/password/forgot/find/user'.addBaseURl();
  static String forgotPassVerifyURL = '/password/forgot/verify/code'.addBaseURl();
  static String forgotPassResendURL = '/password/forgot/resend/code?token='.addBaseURl();
  static String forgotPassResetURL = '/password/forgot/reset'.addBaseURl();

  static String registerURL = '/register'.addBaseURl();
  static String registerVerifyURL = '/user/verify/code'.addBaseURl();
  static String registerResendURL = '/user/resend/code'.addBaseURl();

  static String profileInfoURL = '/user/profile/info'.addBaseURl();
  static String profileUpdateURL = '/user/profile/info/update'.addBaseURl();

  static String passwordChangeURL = '/user/profile/password/update'.addBaseURl();
  static String kycInfoURL = '/user/profile/kyc/input-fields'.addBaseURl();
  static String kycSubmitURL = '/user/profile/kyc/submit'.addBaseURl();

  static String faInfoURL = '/user/profile/google-2fa'.addBaseURl();
  static String faStatusUpdateURL = '/user/profile/google-2fa/status/update'.addBaseURl();
  static String faCodeVerifyURL = '/user/google-2fa/otp/verify'.addBaseURl();

  static String logoutURL = '/user/logout'.addBaseURl();
  static String deleteAccountURL = '/user/profile/delete-account'.addBaseURl();

  static String buyCryptoURL = '/user/buy-crypto/index'.addBaseURl();
  static String buyCryptoStoreURL = '/user/buy-crypto/store'.addBaseURl();
  static String buyCryptoSubmitURL = '/user/buy-crypto/submit'.addBaseURl();

  static String buyCryptoManualURL = '/user/buy-crypto/manual/input-fields'.addBaseURl();
  static String buyCryptoManualSubmitURL = '/user/buy-crypto/manual/submit'.addBaseURl();

  static String sellCryptoURL = '/user/sell-crypto/index'.addBaseURl();
  static String sellCryptoStoreURL = '/user/sell-crypto/store'.addBaseURl();

  static String sellCryptoOutSideStoreURL = '/user/sell-crypto/sell-payment-store'.addBaseURl();
  static String sellCryptoPaymentInfoStoreURL = '/user/sell-crypto/payment-info-store'.addBaseURl();
  static String sellCryptoConfirmURL = '/user/sell-crypto/confirm'.addBaseURl();

  static String withdrawCryptoURL = '/user/withdraw-crypto/index'.addBaseURl();
  static String withdrawCryptoCheckURL = '/user/withdraw-crypto/check-wallet-address'.addBaseURl();
  static String withdrawCryptoStoreURL = '/user/withdraw-crypto/store'.addBaseURl();
  static String withdrawCryptoConfirmURL = '/user/withdraw-crypto/confirm'.addBaseURl();

  static String exchangeCryptoURL = '/user/exchange-crypto/index'.addBaseURl();
  static String exchangeCryptoStoreURL = '/user/exchange-crypto/store'.addBaseURl();
  static String exchangeCryptoConfirmURL = '/user/exchange-crypto/confirm'.addBaseURl();

  static String buyLogURL = '/user/transaction/buy-log'.addBaseURl();
  static String withdrawLogURL = '/user/transaction/withdraw-log'.addBaseURl();
  static String exchangeLogURL = '/user/transaction/exchange-log'.addBaseURl();
  static String sellLogURL = '/user/transaction/sell-log'.addBaseURl();
  static String notificationURL = '/user/notification'.addBaseURl();
}