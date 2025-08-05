import 'package:intl/intl.dart';

import '../../../backend/model/logs/exchange_log_model.dart';
import '../../../backend/utils/custom_loading_api.dart';
import '../../../controller/drawer/logs/exchange_log_controller.dart';
import '../../../utils/basic_widget_imports.dart';
import '../../../widgets/drawer/exchange_log_widget.dart';
import '../../../widgets/others/custom_back_button.dart';
import '../../../widgets/text_labels/no_data_widget.dart';

class ExchangeLogScreenMobile extends StatelessWidget {
  ExchangeLogScreenMobile({super.key});

  final controller = Get.put(ExchangeLogController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: CustomStyle.screenGradientBG,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColor.gradientColorTop,
          leading: CustomBackButton(
            onTap: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: TitleHeading3Widget(
            text: Strings.exchangeLog.tr,
          ),
        ),
        backgroundColor: CustomColor.transparentColor,
        body: Obx(() => controller.isLoading
            ? const CustomLoadingAPI()
            : _bodyWidget(context)),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return _exchangeLogWidget(context);
  }

  _exchangeLogWidget(BuildContext context) {
    return controller.exchangeLogModel.data.exchangeLog.isEmpty
        ? const NoDataWidget()
        : ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSize * 0.8,
            ),
            physics: const BouncingScrollPhysics(),
            itemCount: controller.exchangeLogModel.data.exchangeLog.length,
            itemBuilder: (context, index) {
              ExchangeLog data =
                  controller.exchangeLogModel.data.exchangeLog[index];
              return ExchangeLogWidget(
                dateText: data.createdAt.day.toString(),
                monthText: DateFormat('MMMM').format(data.createdAt),
                status: data.status == 1
                    ? Strings.pending
                    : data.status == 2
                        ? Strings.confirm
                        : data.status == 3
                            ? Strings.cancel
                            : Strings.reject,
                exchangeAmount:
                    "${double.parse(data.amount).toStringAsFixed(6)} ${data.details.data.senderWallet.code}",
                title: data.details.data.senderWallet.code,
                transactionType: data.type,
                transactionAmount:
                    "${double.parse(data.totalPayable).toStringAsFixed(6)} ${data.details.data.senderWallet.code}",
                exchangeRate:
                    "1 ${data.details.data.senderWallet.code} = ${data.details.data.exchangeRate.toStringAsFixed(6)} ${data.details.data.receiverWallet.code}",
                feesAndCharge:
                    "${double.parse(data.totalCharge).toStringAsFixed(6)} ${data.details.data.senderWallet.code}",
                transactionStatus: data.status == 1
                    ? Strings.pending
                    : data.status == 2
                        ? Strings.confirm
                        : data.status == 3
                            ? Strings.cancel
                            : Strings.reject,
              );
            },
          );
  }
}
