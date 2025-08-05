import 'package:adcrypto/backend/model/common/common_success_model.dart';

import '../../../../utils/basic_screen_imports.dart';

import '../../../backend/model/withdraw_crypto/withdraw_crypto_check_model.dart';
import '../../../backend/model/withdraw_crypto/withdraw_crypto_model.dart';
import '../../../backend/model/withdraw_crypto/withdraw_crypto_store_model.dart';
import '../../../backend/services/withdraw_crypto/withdraw_crypto_service.dart';
import '../../../backend/utils/api_method.dart';
import '../../../routes/routes.dart';
import '../../../views/congratulation/congratulation_screen.dart';

class WithdrawCryptoController extends GetxController
    with WithdrawCryptoService {
  final amountController = TextEditingController();
  final walletAddressController = TextEditingController();

  @override
  void onInit() {
    withdrawCryptoProcess();
    super.onInit();
  }

  late Rx<Currency> selectedCoin;

  RxString toCurrencyCode = "".obs;
  RxDouble toCurrencyRate = 0.0.obs;

  RxDouble exchangeRate = 0.0.obs;
  RxDouble min = 0.0.obs;
  RxDouble max = 0.0.obs;
  // RxDouble rate = 0.0.obs;
  RxDouble fee = 0.0.obs;

  calculation(String value) {
    if(toCurrencyRate.value != 0){
      exchangeRate.value = toCurrencyRate.value /
          double.parse(selectedCoin.value.rate);
    }else{
      exchangeRate.value = 0;
    }

    TransactionFees data = _withdrawCryptoModel.data.transactionFees;
    min.value =
        double.parse(data.minLimit) * double.parse(selectedCoin.value.rate);
    max.value =
        double.parse(data.maxLimit) * double.parse(selectedCoin.value.rate);

    if (value.isNotEmpty) {
      var senderAmount = double.parse(value);
      debugPrint(fee.value.toString());
      fee.value =
      ((senderAmount * double.parse(data.percentCharge) / 100) +
          double.parse(data.fixedCharge) *
              double.parse(selectedCoin.value.rate));
      debugPrint(fee.value.toString());
    } else {
      fee.value = double.parse(data.fixedCharge) * double.parse(selectedCoin.value.rate);
    }
  }


//----------------------------------------------------------------------------
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late WithdrawCryptoModel _withdrawCryptoModel;
  WithdrawCryptoModel get withdrawCryptoModel => _withdrawCryptoModel;

  ///* Get WithdrawCrypto in process
  Future<WithdrawCryptoModel> withdrawCryptoProcess() async {
    _isLoading.value = true;
    update();
    await withdrawCryptoProcessApi().then((value) {
      _withdrawCryptoModel = value!;

      _setValues(_withdrawCryptoModel);

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _withdrawCryptoModel;
  }

  void _setValues(WithdrawCryptoModel withdrawCryptoModel) {
    selectedCoin = withdrawCryptoModel.data.currencies.first.obs;
    calculation("");
  }

//----------------------------------------------------------------------------
  final search = false.obs;
  final validUser = false.obs;

  final _isCheckLoading = false.obs;
  bool get isCheckLoading => _isCheckLoading.value;

  late WithdrawCryptoCheckModel _withdrawCryptoCheckModel;
  WithdrawCryptoCheckModel get withdrawCryptoCheckModel =>
      _withdrawCryptoCheckModel;

  ///* Get WithdrawCryptoCheck in process
  Future<WithdrawCryptoCheckModel> withdrawCryptoCheckProcess(
      String walletId) async {
    _isCheckLoading.value = true;
    update();
    await withdrawCryptoCheckProcessApi(walletId).then((value) {
      _withdrawCryptoCheckModel = value!;
      validUser.value = true;

      toCurrencyCode.value = _withdrawCryptoCheckModel.data.code;
      toCurrencyRate.value = double.parse(_withdrawCryptoCheckModel.data.rate);
      calculation(amountController.text);

      _isCheckLoading.value = false;
      update();
    }).catchError((onError) {
      validUser.value = false;
      log.e(onError);
    });
    _isCheckLoading.value = false;
    update();
    return _withdrawCryptoCheckModel;
  }

//---------------------------------------------------------------------------
  final _isStoreLoading = false.obs;
  bool get isStoreLoading => _isStoreLoading.value;

  late WithdrawCryptoStoreModel _withdrawCryptoStoreModel;
  WithdrawCryptoStoreModel get withdrawCryptoStoreModel =>
      _withdrawCryptoStoreModel;

  ///* WithdrawCryptoStore in process
  Future<WithdrawCryptoStoreModel> withdrawCryptoStoreProcess() async {
    _isStoreLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'amount': amountController.text,
      'sender_wallet': selectedCoin.value.wallets.first.id,
      'wallet_address': walletAddressController.text,
    };
    await withdrawCryptoStoreProcessApi(body: inputBody).then((value) {
      _withdrawCryptoStoreModel = value!;

      Get.toNamed(Routes.withdrawCryptoPreviewScreen);

      _isStoreLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isStoreLoading.value = false;
    update();
    return _withdrawCryptoStoreModel;
  }

//--------------------------------------------------------------------------
  final _isConfirmLoading = false.obs;
  bool get isConfirmLoading => _isConfirmLoading.value;

  late CommonSuccessModel _withdrawCryptoConfirmModel;
  CommonSuccessModel get withdrawCryptoConfirmModel =>
      _withdrawCryptoConfirmModel;

  ///* WithdrawCryptoConfirm in process
  Future<CommonSuccessModel> withdrawCryptoConfirmProcess() async {
    _isConfirmLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'identifier': _withdrawCryptoStoreModel.data.data.identifier,
    };
    await withdrawCryptoConfirmProcessApi(body: inputBody).then((value) {
      _withdrawCryptoConfirmModel = value!;

      Get.to(() => CongratulationScreen(
            route: Routes.dashboardScreen,
            subTitle: _withdrawCryptoConfirmModel.message.success.first,
          ));

      _isConfirmLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isConfirmLoading.value = false;
    update();
    return _withdrawCryptoConfirmModel;
  }
}
