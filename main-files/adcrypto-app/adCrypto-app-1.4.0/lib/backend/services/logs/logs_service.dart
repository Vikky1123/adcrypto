
import '../../../widgets/others/custom_snack_bar.dart';
import '../../model/logs/buy_log_model.dart';
import '../../model/logs/exchange_log_model.dart';
import '../../model/logs/notification_model.dart';
import '../../model/logs/sell_log_model.dart';
import '../../model/logs/withdraw_log_model.dart';
import '../../utils/api_method.dart';
import '../api_endpoint.dart';

mixin LogsService{

  ///* Get BuyLog api services
  Future<BuyLogModel?> buyLogProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
          ApiEndpoint.buyLogURL
      );
      if (mapResponse != null) {
        BuyLogModel result = BuyLogModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from BuyLog api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* Get WithdrawLog api services
  Future<WithdrawLogModel?> withdrawLogProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
          ApiEndpoint.withdrawLogURL
      );
      if (mapResponse != null) {
        WithdrawLogModel result = WithdrawLogModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from WithdrawLog api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* Get ExchangeLog api services
  Future<ExchangeLogModel?> exchangeLogProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
          ApiEndpoint.exchangeLogURL
      );
      if (mapResponse != null) {
        ExchangeLogModel result = ExchangeLogModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from ExchangeLog api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* Get SellLog api services
  Future<SellLogModel?> sellLogProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
          ApiEndpoint.sellLogURL
      );
      if (mapResponse != null) {
        SellLogModel result = SellLogModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from SellLog api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* Get Notification api services
  Future<NotificationModel?> notificationProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
          ApiEndpoint.notificationURL
      );
      if (mapResponse != null) {
        NotificationModel result = NotificationModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from Notification api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

}