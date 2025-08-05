import 'package:intl/intl.dart';

import '../../../backend/model/logs/buy_log_model.dart';
import '../../../backend/utils/custom_loading_api.dart';
import '../../../controller/drawer/logs/buy_log_controller.dart';
import '../../../utils/basic_widget_imports.dart';
import '../../../widgets/drawer/buy_log_widget.dart';
import '../../../widgets/others/custom_back_button.dart';
import '../../../widgets/text_labels/no_data_widget.dart';

class BuyLogScreenMobile extends StatelessWidget {
  BuyLogScreenMobile({super.key});

  final controller = Get.put(BuyLogController());

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
            text: Strings.buyLog.tr,
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
    return _buyLogWidget(context);
  }

  _buyLogWidget(BuildContext context) {
    return controller.buyLogModel.data.buyLog.isEmpty
        ? const NoDataWidget()
        : ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSize * 0.8,
            ),
            physics: const BouncingScrollPhysics(),
            itemCount: controller.buyLogModel.data.buyLog.length,
            itemBuilder: (context, index) {
              BuyLog data = controller.buyLogModel.data.buyLog[index];
              return BuyLogWidget(
                onTap: data.details.data.paymentMethod.alias.contains("tatum")
                    ? (){
                  controller.tatumManualScreen(data);
                }
                    : null,
                dateText: data.createdAt.day.toString(),
                monthText: DateFormat('MMMM').format(data.createdAt),
                status: data.status == 1
                    ? Strings.pending
                    : data.status == 2
                        ? Strings.confirm
                        : data.status == 3
                            ? Strings.cancel
                            : Strings.reject,
                buyAmount:
                    "${double.parse(data.amount).toStringAsFixed(6)} ${data.details.data.wallet.code}",
                title: data.details.data.wallet.code,
                transactionType: data.type,
                transactionAmount:
                    "${double.parse(data.totalPayable).toStringAsFixed(6)} ${data.details.data.paymentMethod.code}",
                exchangeRate:
                    "1 ${data.details.data.wallet.code} = ${data.details.data.exchangeRate.toStringAsFixed(6)} ${data.details.data.paymentMethod.code}",
                feesAndCharge:
                    "${double.parse(data.totalCharge).toStringAsFixed(6)} ${data.details.data.wallet.code}",
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
