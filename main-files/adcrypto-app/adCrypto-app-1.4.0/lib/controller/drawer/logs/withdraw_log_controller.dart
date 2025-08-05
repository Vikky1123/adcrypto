

import 'package:adcrypto/utils/basic_screen_imports.dart';

import '../../../backend/model/logs/withdraw_log_model.dart';
import '../../../backend/services/logs/logs_service.dart';
import '../../../backend/utils/api_method.dart';

class WithdrawLogController extends GetxController with LogsService{


  @override
  void onInit() {
    withdrawLogProcess();
    super.onInit();
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late WithdrawLogModel _withdrawLogModel;
  WithdrawLogModel get withdrawLogModel => _withdrawLogModel;

  ///* Get WithdrawLog in process
  Future<WithdrawLogModel> withdrawLogProcess() async {
    _isLoading.value = true;
    update();
    await withdrawLogProcessApi().then((value) {
      _withdrawLogModel = value!;
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _withdrawLogModel;
  }

}