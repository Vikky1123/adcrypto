import 'package:adcrypto/backend/model/common/common_success_model.dart';

import '../../../../utils/basic_screen_imports.dart';

import '../../../backend/model/exchange_crypto/exchange_crypto_model.dart';
import '../../../backend/model/exchange_crypto/exchange_crypto_store_model.dart';
import '../../../backend/services/exchange_crypto/exchange_crypto_service.dart';
import '../../../backend/utils/api_method.dart';
import '../../../routes/routes.dart';
import '../../../views/congratulation/congratulation_screen.dart';

class ExchangeCryptoController extends GetxController
    with ExchangeCryptoService {
  final fromAmountController = TextEditingController();
  final toAmountController = TextEditingController();

  @override
  void onInit() {
    exchangeCryptoProcess();
    super.onInit();
  }

  late Rx<Currency> fromCurrency;
  late Rx<Currency> toCurrency;

  RxList<Currency> currencyList = <Currency>[].obs;
  RxDouble exchangeRate = 0.0.obs;

  RxDouble min = 0.0.obs;
  RxDouble max = 0.0.obs;
  RxDouble networkCharge = 0.0.obs;

  goToExchangeCryptoPreviewScreen() {
    exchangeCryptoStoreProcess();
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late ExchangeCryptoModel _exchangeCryptoModel;
  ExchangeCryptoModel get exchangeCryptoModel => _exchangeCryptoModel;

  ///* Get ExchangeCrypto in process
  Future<ExchangeCryptoModel> exchangeCryptoProcess() async {
    _isLoading.value = true;
    update();
    await exchangeCryptoProcessApi().then((value) {
      _exchangeCryptoModel = value!;

      currencyList.value = _exchangeCryptoModel.data.currencies;
      fromCurrency = _exchangeCryptoModel.data.currencies.first.obs;
      toCurrency = _exchangeCryptoModel.data.currencies.first.obs;

      exchangeRateCalculate(value: fromAmountController.text);

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _exchangeCryptoModel;
  }

  RxDouble exchangeRateCalculate({required String value}) {
    exchangeRate.value = double.parse(toCurrency.value.rate) /
        double.parse(fromCurrency.value.rate);
    TransactionFees data = _exchangeCryptoModel.data.transactionFees;
    min.value =
        double.parse(data.minLimit) * double.parse(fromCurrency.value.rate);
    max.value =
        double.parse(data.maxLimit) * double.parse(fromCurrency.value.rate);

    if (value.isNotEmpty) {
      var senderAmount = double.parse(value);
      debugPrint(networkCharge.value.toString());
      networkCharge.value =
          ((senderAmount * double.parse(data.percentCharge) / 100) +
              double.parse(data.fixedCharge) *
                  double.parse(fromCurrency.value.rate));
      debugPrint(networkCharge.value.toString());
      toAmountController.text =
          (senderAmount * exchangeRate.value).toStringAsFixed(6);
    } else {
      networkCharge.value = double.parse(data.fixedCharge);
      toAmountController.text = "";
    }
    return exchangeRate;
  }

  final _isStoreLoading = false.obs;
  bool get isStoreLoading => _isStoreLoading.value;

  late ExchangeCryptoStoreModel _exchangeCryptoStoreModel;
  ExchangeCryptoStoreModel get exchangeCryptoStoreModel =>
      _exchangeCryptoStoreModel;

  ///* ExchangeCryptoStore in process
  Future<ExchangeCryptoStoreModel> exchangeCryptoStoreProcess() async {
    _isStoreLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'send_amount': fromAmountController.text,
      'sender_wallet': fromCurrency.value.wallets.first.id,
      'receiver_currency': toCurrency.value.wallets.first.id
    };
    await exchangeCryptoStoreProcessApi(body: inputBody).then((value) {
      _exchangeCryptoStoreModel = value!;
      Get.toNamed(Routes.exchangeCryptoPreviewScreen);
      _isStoreLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isStoreLoading.value = false;
    update();
    return _exchangeCryptoStoreModel;
  }

  final _isConfirmLoading = false.obs;
  bool get isConfirmLoading => _isConfirmLoading.value;

  late CommonSuccessModel _exchangeCryptoConfirmModel;
  CommonSuccessModel get exchangeCryptoConfirmModel =>
      _exchangeCryptoConfirmModel;

  ///* ExchangeCryptoConfirm in process
  Future<CommonSuccessModel> exchangeCryptoConfirmProcess() async {
    _isConfirmLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'identifier': _exchangeCryptoStoreModel.data.data.identifier,
    };
    await exchangeCryptoConfirmProcessApi(body: inputBody).then((value) {
      _exchangeCryptoConfirmModel = value!;

      Get.to(
        () => const CongratulationScreen(
          route: Routes.dashboardScreen,
          subTitle: Strings.exchangeCryptoCongratulationSubtitle,
        ),
      );

      _isConfirmLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isConfirmLoading.value = false;
    update();
    return _exchangeCryptoConfirmModel;
  }
}
