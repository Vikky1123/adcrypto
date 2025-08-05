import '../../../../routes/routes.dart';
import '../../../../utils/basic_screen_imports.dart';

class SellCryptoPaymentProofController extends GetxController {
  final sellCryptoInsideWalletAddressController = TextEditingController();
  final sellCryptoInsideWalletTrxController = TextEditingController();
  final sellCryptoInsideWalletBankNameController = TextEditingController();
  final sellCryptoInsideWalletBankAccNumberController = TextEditingController();
  final sellCryptoInsideWalletBranchNameController = TextEditingController();

  final sellCryptoOutsideWalletAddressController = TextEditingController();
  final sellCryptoOutsideWalletTrxController = TextEditingController();
  final sellCryptoOutsideWalletBankNameController = TextEditingController();
  final sellCryptoOutsideWalletBankAccNumberController =
      TextEditingController();
  final sellCryptoOutsideWalletBranchNameController = TextEditingController();

  goToSellCryptoPreviewScreen() {
    Get.toNamed(Routes.sellCryptoPreviewScreen);
  }goToSellCryptoConfirmationScreenScreen() {
    Get.toNamed(Routes.sellCryptoQRScreen);
  }
}