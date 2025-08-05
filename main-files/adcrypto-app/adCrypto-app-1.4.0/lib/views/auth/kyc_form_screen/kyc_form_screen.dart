import 'package:adcrypto/local_storage/local_storage.dart';
import 'package:adcrypto/routes/routes.dart';

import '../../../backend/utils/custom_loading_api.dart';
import '../../../controller/kyc_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../utils/responsive_layout.dart';
import '../../../widgets/others/app_logo_widget.dart';
import '../../../widgets/others/custom_back_button.dart';

class KYCFormScreen extends StatelessWidget {
  KYCFormScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final controller = Get.put(KycController());

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
                onTap: (){
                  LocalStorage.isLoggedIn()
                      ? Navigator.pop(context)
                      : Get.offAllNamed(Routes.signInScreen);
                },
              ),
              title: TitleHeading3Widget(
                padding: EdgeInsets.only(left: Dimensions.paddingSize * 4),
                text: Strings.kycForm.tr,
              ),
            ),

            body: Obx(() => controller.isLoading
                ? const CustomLoadingAPI()
                : Column(
                    children: [
                      const AppLogoWidget(),
                      _bottomBodyWidget(context),
                    ],
                  )),
          ),
        ),
      ),
    );
  }

  _bottomBodyWidget(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: CustomColor.whiteColor.withOpacity(.1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius * 3),
              topRight: Radius.circular(Dimensions.radius * 3),
            )),
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            (controller.kycInfoModel.data.kycStatus == 0 ||
                    controller.kycInfoModel.data.kycStatus == 3)
                ? Column(
                    children: [
                      verticalSpace(Dimensions.paddingVerticalSize * 1),
                      _inputWidget(context),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingHorizontalSize * .5),
                        child: Obx(() => controller.isSubmitLoading
                            ? const CustomLoadingAPI()
                            : PrimaryButton(
                                title: Strings.submit,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    controller.kycSubmitApiProcess();
                                  }
                                },
                                buttonTextColor:
                                    CustomColor.primaryBGLightColor,
                                borderColor: CustomColor.primaryLightColor,
                                buttonColor: CustomColor.primaryLightColor,
                              )),
                      ),
                      verticalSpace(Dimensions.paddingVerticalSize * 1.5),
                    ],
                  )
                : Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingHorizontalSize * .7,
                      vertical: Dimensions.paddingVerticalSize * .7,
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingHorizontalSize * .7,
                      vertical: Dimensions.paddingVerticalSize * .7,
                    ),
                    decoration: BoxDecoration(
                        color: CustomColor.primaryDarkScaffoldBackgroundColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius * 1.5)),
                    child: TitleHeading1Widget(
                      text: controller.kycInfoModel.data.kycStatus == 1
                          ? Strings.verified
                          : Strings.pending,
                      color: CustomColor.primaryLightColor,
                    ),
                  )
          ],
        ),
      ),
    );
  }

  _inputWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingHorizontalSize * .7,
        vertical: Dimensions.paddingVerticalSize * .7,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingHorizontalSize * .7,
        vertical: Dimensions.paddingVerticalSize * .7,
      ),
      decoration: BoxDecoration(
          color: CustomColor.whiteColor.withOpacity(.1),
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
