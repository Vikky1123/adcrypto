import 'package:intl/intl.dart';

import '../../../backend/model/logs/withdraw_log_model.dart';
import '../../../backend/utils/custom_loading_api.dart';
import '../../../controller/drawer/logs/withdraw_log_controller.dart';
import '../../../utils/basic_widget_imports.dart';
import '../../../widgets/drawer/withdraw_log_widget.dart';
import '../../../widgets/others/custom_back_button.dart';
import '../../../widgets/text_labels/no_data_widget.dart';

class WithdrawLogScreenMobile extends StatelessWidget {
  WithdrawLogScreenMobile({super.key});

  final controller = Get.put(WithdrawLogController());

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
            text: Strings.withdrawLog.tr,
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
    return _withdrawLogWidget(context);
  }

  _withdrawLogWidget(BuildContext context) {
    return controller.withdrawLogModel.data.withdrawLog.isEmpty
        ? const NoDataWidget()
        : ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSize * 0.8,
            ),
            physics: const BouncingScrollPhysics(),
            itemCount: controller.withdrawLogModel.data.withdrawLog.length,
            itemBuilder: (context, index) {
              WithdrawLog data =
                  controller.withdrawLogModel.data.withdrawLog[index];
              return WithdrawLogWidget(
                dateText: data.createdAt.day.toString(),
                monthText: DateFormat('MMMM').format(data.createdAt),
                status: data.status == 1
                    ? Strings.pending
                    : data.status == 2
                        ? Strings.confirm
                        : data.status == 3
                            ? Strings.cancel
                            : Strings.reject,
                withdrawAmount:
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
