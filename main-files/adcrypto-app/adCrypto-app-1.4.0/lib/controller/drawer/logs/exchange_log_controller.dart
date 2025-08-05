

import 'package:adcrypto/utils/basic_screen_imports.dart';

import '../../../backend/model/logs/exchange_log_model.dart';
import '../../../backend/services/logs/logs_service.dart';
import '../../../backend/utils/api_method.dart';

class ExchangeLogController extends GetxController with LogsService{



  @override
  void onInit() {
    exchangeLogProcess();
    super.onInit();
  }



  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late ExchangeLogModel _exchangeLogModel;
  ExchangeLogModel get exchangeLogModel => _exchangeLogModel;

  ///* Get ExchangeLog in process
  Future<ExchangeLogModel> exchangeLogProcess() async {
    _isLoading.value = true;
    update();
    await exchangeLogProcessApi().then((value) {
      _exchangeLogModel = value!;
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _exchangeLogModel;
  }
}