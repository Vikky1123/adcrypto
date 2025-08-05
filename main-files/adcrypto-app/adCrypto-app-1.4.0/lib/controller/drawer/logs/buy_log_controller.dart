

import 'package:adcrypto/utils/basic_screen_imports.dart';

import '../../../backend/model/buy_crypto/buy_crypto_tatum_model.dart' as tatum;
import '../../../backend/model/logs/buy_log_model.dart';
import '../../../backend/services/logs/logs_service.dart';
import '../../../backend/utils/api_method.dart';
import '../../../routes/routes.dart';
import '../../dashboard/buy_crypto/buy_crypto_controller.dart';

class BuyLogController extends GetxController with LogsService{

  @override
  void onInit() {
    buyLogProcess();
    super.onInit();
  }



  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late BuyLogModel _buyLogModel;
  BuyLogModel get buyLogModel => _buyLogModel;

  ///* Get BuyLog in process
  Future<BuyLogModel> buyLogProcess() async {
    _isLoading.value = true;
    update();
    await buyLogProcessApi().then((value) {
      _buyLogModel = value!;
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _buyLogModel;
  }

  List<tatum.InputField> inputFields = [];
  late BuyLog buyLog;


  tatumManualScreen(BuyLog data) {
    debugPrint("TATUM SCREEN MANUAL _________________1");
    inputFields.clear();
    buyLog = data;

    inputFields =
    data.requirements.map((requirement) {
      return tatum.InputField(
          type: requirement.type,
          label: requirement.label,
          placeholder: requirement.placeholder,
          name: requirement.name,
          required: requirement.required,
          validation: tatum.Validation(
              min: requirement.validation.min,
              max: requirement.validation.max,
              required: requirement.validation.required));
    }).toList();
    Get.find<BuyCryptoController>()
        .getDynamicInputFieldForTatum(data: inputFields);

    debugPrint("TATUM SCREEN MANUAL _________________2");

    Get.toNamed(Routes.transactionTatumManualScreen);
  }

  void buyCryptoSubmit() {
    Get.find<BuyCryptoController>().buyCryptoTatumSubmitProcess(
        url: buyLog.submitUrl,
        data: inputFields
    );
  }
}