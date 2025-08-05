import 'package:adcrypto/backend/utils/custom_loading_api.dart';
import 'package:intl/intl.dart';

import '../../../backend/model/logs/sell_log_model.dart';
import '../../../controller/drawer/logs/sell_log_controller.dart';
import '../../../utils/basic_widget_imports.dart';
import '../../../widgets/drawer/sell_log_widget.dart';
import '../../../widgets/others/custom_back_button.dart';
import '../../../widgets/text_labels/no_data_widget.dart';

class SellLogScreenMobile extends StatelessWidget {
  SellLogScreenMobile({super.key});

  final controller = Get.put(SellLogController());

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
            text: Strings.sellLog.tr,
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
    return _sellLogWidget(context);
  }

  _sellLogWidget(BuildContext context) {
    return controller.sellLogModel.data.sellLog.isEmpty
        ? const NoDataWidget()
        : ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSize * 0.8,
            ),
            physics: const BouncingScrollPhysics(),
            itemCount: controller.sellLogModel.data.sellLog.length,
            itemBuilder: (context, index) {
              SellLog data = controller.sellLogModel.data.sellLog[index];
              return SellLogWidget(
                dateText: data.createdAt.day.toString(),
                monthText: DateFormat('MMMM').format(data.createdAt),
                status: data.status == 1
                    ? Strings.pending
                    : data.status == 2
                        ? Strings.confirm
                        : data.status == 3
                            ? Strings.cancel
                            : Strings.reject,
                sellAmount:
                    "${double.parse(data.amount).toStringAsFixed(6)} ${data.data.senderWallet.code}",
                title: data.data.senderWallet.code,
                transactionType: data.type,
                transactionAmount:
                    "${double.parse(data.totalPayable).toStringAsFixed(6)} ${data.data.senderWallet.code}",
                exchangeRate:
                    "1 ${data.data.senderWallet.code} = ${data.data.exchangeRate.toStringAsFixed(6)} ${data.data.paymentMethod.code}",
                feesAndCharge:
                    "${double.parse(data.totalCharge).toStringAsFixed(6)} ${data.data.senderWallet.code}",
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
