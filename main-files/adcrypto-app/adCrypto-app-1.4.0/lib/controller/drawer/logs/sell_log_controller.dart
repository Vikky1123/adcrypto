

import 'package:adcrypto/utils/basic_screen_imports.dart';

import '../../../backend/model/logs/sell_log_model.dart';
import '../../../backend/services/logs/logs_service.dart';
import '../../../backend/utils/api_method.dart';

class SellLogController extends GetxController with LogsService{


  @override
  void onInit() {
    sellLogProcess();
    super.onInit();
  }



  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late SellLogModel _sellLogModel;
  SellLogModel get sellLogModel => _sellLogModel;

  ///* Get SellLog in process
  Future<SellLogModel> sellLogProcess() async {
    _isLoading.value = true;
    update();
    await sellLogProcessApi().then((value) {
      _sellLogModel = value!;
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _sellLogModel;
  }


}