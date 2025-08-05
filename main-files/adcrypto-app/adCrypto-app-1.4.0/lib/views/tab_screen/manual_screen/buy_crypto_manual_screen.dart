import '../../../controller/dashboard/buy_crypto/buy_crypto_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../backend/utils/custom_loading_api.dart';
import '../../../utils/responsive_layout.dart';
import '../../../widgets/others/app_logo_widget.dart';
import '../../../widgets/others/custom_back_button.dart';
import '../../../widgets/text_labels/html_widget.dart';

class BuyCryptoManualScreen extends StatelessWidget {
  BuyCryptoManualScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final controller = Get.find<BuyCryptoController>();

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
                text: controller.selectedPaymentMethod.value.name,
              ),
            ),
            body: Obx(() => controller.isSubmitLoading
                ? const CustomLoadingAPI()
                : ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      controller.selectedPaymentMethod.value.alias
                              .contains("tatum")
                          ? const AppLogoWidget()
                          : HTMLWidget(
                              data: controller
                                  .buyCryptoManualModel.data.gateway.desc,
                            ),
                      _bottomBodyWidget(context),
                    ],
                  )),
          ),
        ),
      ),
    );
  }

  _bottomBodyWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: controller.selectedPaymentMethod.value.alias.contains("tatum")
              ? Colors.transparent
              : CustomColor.whiteColor.withOpacity(.1),
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
            child: Obx(() => controller.isManualSubmitLoading
                ? const CustomLoadingAPI()
                : PrimaryButton(
                    title: Strings.confirm,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (controller.selectedPaymentMethod.value.alias
                            .contains("tatum")) {
                          controller.buyCryptoTatumSubmitProcess(
                            data: controller.buyCryptoTatumModel.data.addressInfo.inputFields,
                            url: controller.buyCryptoTatumModel.data.addressInfo.submitUrl
                          );
                        } else {
                          controller.buyCryptoManualSubmitProcess();
                        }
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
            ...controller.inputFields.map((element) {
              return element;
            }),
            verticalSpace(Dimensions.marginBetweenInputBox),
            Visibility(
              visible: controller.inputFileFields.isNotEmpty,
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: .99,
                  ),
                  itemCount: controller.inputFileFields.length,
                  itemBuilder: (BuildContext context, int index) {
                    return controller.inputFileFields[index];
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
