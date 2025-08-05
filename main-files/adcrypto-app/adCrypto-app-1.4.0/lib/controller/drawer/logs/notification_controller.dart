

import 'package:adcrypto/utils/basic_screen_imports.dart';

import '../../../backend/model/logs/notification_model.dart';
import '../../../backend/services/logs/logs_service.dart';
import '../../../backend/utils/api_method.dart';

class NotificationController extends GetxController with LogsService{

  @override
  void onInit() {
    notificationProcess();
    super.onInit();
  }



  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late NotificationModel _notificationModel;
  NotificationModel get notificationModel => _notificationModel;

  ///* Get Notification in process
  Future<NotificationModel> notificationProcess() async {
    _isLoading.value = true;
    update();
    await notificationProcessApi().then((value) {
      _notificationModel = value!;
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _notificationModel;
  }
}