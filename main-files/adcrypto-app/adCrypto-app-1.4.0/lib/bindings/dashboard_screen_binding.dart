import 'package:get/get.dart';

import '../controller/dashboard/buy_crypto/buy_crypto_controller.dart';
import '../controller/dashboard/dashboard_controller/dashboard_controller.dart';
import '../controller/dashboard/exchange_crypto/exchange_crypto_controller.dart';
import '../controller/dashboard/sell_crypto/sell_crypto_controller.dart';
import '../controller/dashboard/update_profile/update_profile_controller.dart';
import '../controller/dashboard/withdraw_crypto/withdraw_crypto_controller.dart';



class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UpdateProfileController());
    Get.put(DashBoardController());
    Get.put(BuyCryptoController());
    Get.put(SellCryptoController());
    Get.put(WithdrawCryptoController());
    Get.put(ExchangeCryptoController());
  }
}
