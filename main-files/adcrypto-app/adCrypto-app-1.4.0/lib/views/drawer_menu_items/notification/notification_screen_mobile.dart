import 'package:intl/intl.dart';

import '../../../backend/model/logs/notification_model.dart' as log;
import '../../../backend/utils/custom_loading_api.dart';
import '../../../controller/drawer/logs/notification_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/drawer/notification_widget.dart';
import '../../../widgets/others/custom_back_button.dart';
import '../../../widgets/text_labels/no_data_widget.dart';

class NotificationScreenMobile extends StatelessWidget {
  NotificationScreenMobile({super.key});

  final controller = Get.put(NotificationController());

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
            text: Strings.notification.tr,
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
    return _notificationWidget(context);
  }

  _notificationWidget(BuildContext context) {
    return controller.notificationModel.data.notification.isEmpty
        ? const NoDataWidget()
        : ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSize * 0.8,
            ),
            physics: const BouncingScrollPhysics(),
            itemCount: controller.notificationModel.data.notification.length,
            itemBuilder: (context, index) {
              log.Notification data =
                  controller.notificationModel.data.notification[index];
              return NotificationWidget(
                title: data.message.title,
                dateText: data.createdAt.day.toString(),
                monthText: DateFormat('MMMM').format(data.createdAt),
                notificationMessage: data.message.success,
              );
            },
          );
  }
}
