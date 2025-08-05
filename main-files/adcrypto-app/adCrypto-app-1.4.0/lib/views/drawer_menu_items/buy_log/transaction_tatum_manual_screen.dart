import 'package:adcrypto/controller/drawer/logs/buy_log_controller.dart';

import '../../../controller/dashboard/buy_crypto/buy_crypto_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../backend/utils/custom_loading_api.dart';
import '../../../utils/responsive_layout.dart';
import '../../../widgets/others/app_logo_widget.dart';
import '../../../widgets/others/custom_back_button.dart';

class TransactionTatumManualScreen extends StatelessWidget {
  TransactionTatumManualScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final controller = Get.find<BuyLogController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ResponsiveLayout(
        mobileScaffold: Container(
          decoration: CustomStyle.screenGradientBG,
          child: Scaffold(
            backgroundColor: CustomColor.transparentColor,
            appBar: AppBar(
              backgroundColor: CustomColor.gradientColorTop,
              leading: CustomBackButton(
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              centerTitle: true,
              title: TitleHeading3Widget(
                text:  controller.buyLog.details.data.paymentMethod.name,
              ),
            ),
            body: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                       const AppLogoWidget(),
                      _bottomBodyWidget(context),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  _bottomBodyWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius * 3),
            topRight: Radius.circular(Dimensions.radius * 3),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          verticalSpace(Dimensions.paddingVerticalSize * .7),
          _inputWidget(context),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingHorizontalSize * .5),
            child: Obx(() => Get.find<BuyCryptoController>().isManualSubmitLoading
                ? const CustomLoadingAPI()
                : PrimaryButton(
                    title: Strings.confirm,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        controller.buyCryptoSubmit();
                      }
                    },
                    buttonTextColor: CustomColor.primaryBGLightColor,
                    borderColor: CustomColor.primaryLightColor,
                    buttonColor: CustomColor.primaryLightColor,
                  )),
          ),
          verticalSpace(Dimensions.paddingVerticalSize * 1.5),
        ],
      ),
    );
  }

  _inputWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingHorizontalSize * .7,
        vertical: Dimensions.paddingVerticalSize * .5,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius * 1.5)),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ...Get.find<BuyCryptoController>().inputFields.map((element) {
              return element;
            }),
            verticalSpace(Dimensions.marginBetweenInputBox),
            Visibility(
              visible: Get.find<BuyCryptoController>().inputFileFields.isNotEmpty,
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: .99,
                  ),
                  itemCount: Get.find<BuyCryptoController>().inputFileFields.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Get.find<BuyCryptoController>().inputFileFields[index];
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
