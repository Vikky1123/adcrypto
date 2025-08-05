import 'package:adcrypto/backend/utils/custom_loading_api.dart';

import '../../../utils/basic_screen_imports.dart';
import '../../../utils/responsive_layout.dart';
import '../../backend/language/language_controller.dart';
import '../../controller/basic_settings_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: Scaffold(
        body: Obx(() => Get.find<BasicSettingsController>().isLoading
            ? const CustomLoadingAPI()
            : Stack(
              children: [
                Image.network(
                    Get.find<BasicSettingsController>().splashScreen.value,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height ,
                    width: MediaQuery.of(context).size.width,
                  ),
                Visibility(
                  visible: Get.find<LanguageSettingController>().isLoading,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.sizeOf(context).height * 0.2,
                      left: MediaQuery.sizeOf(context).width * 0.15,
                      right: MediaQuery.sizeOf(context).width * 0.15,
                    ),
                    child: LinearProgressIndicator(
                      color:
                      CustomColor.whiteColor.withOpacity(1),
                      backgroundColor: CustomColor.primaryDarkColor,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
