import '../../controller/basic_settings_controller.dart';
import '../../utils/basic_screen_imports.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({super.key, this.height, this.width});

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: Dimensions.marginSizeHorizontal * 3,
        right: Dimensions.marginSizeHorizontal * 3,
        top: Dimensions.marginSizeVertical,
        bottom: Dimensions.marginSizeVertical,
      ),
      child: Obx(() => Get.find<BasicSettingsController>().isLoading
          ? const SizedBox.shrink()
          : Container(
        height: height ?? MediaQuery.of(context).size.height * .15,
        width: width ?? MediaQuery.of(context).size.width * .75,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  Get.find<BasicSettingsController>().siteLogoDark.value),
            fit: BoxFit.contain
          ),
        ),
      )),
    );
  }
}
