import '../../../controller/dashboard/sell_crypto/sell_crypto_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../backend/utils/custom_loading_api.dart';
import '../../../utils/responsive_layout.dart';
import '../../../widgets/others/custom_back_button.dart';

class SellCryptoManualScreen extends StatelessWidget {
  SellCryptoManualScreen({super.key});

  final formKey = GlobalKey<FormState>();

  final controller = Get.find<SellCryptoController>();

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
                text: controller.selectedReceivingMethod.value.name,
              ),
            ),
            body: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                _bottomBodyWidget(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _bottomBodyWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingHorizontalSize * .5),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: crossStart,
          children: [


            _paymentProofTextWidget(context),
            Padding(
                padding: const EdgeInsets.all(10),
                child: SelectableText(controller.sellCryptoStoreModel.data.desc2)),
            verticalSpace(Dimensions.paddingVerticalSize * 0.5),
            _inputPaymentProofWidget(context),

            _receivingMethodInformationWidget(context),
            Padding(
                padding: const EdgeInsets.all(10),
                child: SelectableText(controller.sellCryptoStoreModel.data.desc)),
            // TitleHeading3Widget(text: controller.sellCryptoStoreModel.data.desc, padding: const EdgeInsets.all(10)),
            verticalSpace(Dimensions.paddingVerticalSize * 0.5),
            _inputWidget(context),



            verticalSpace(Dimensions.paddingVerticalSize * 0.5),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingHorizontalSize * 0),
              child: Obx(() => controller.isPaymentInfoStoreLoading
                  ? const CustomLoadingAPI()
                  : PrimaryButton(
                      title: Strings.confirm,
                      onPressed: () {
                        if(formKey.currentState!.validate()){
                          controller.sellCryptoPaymentInfoStoreProcess();
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
      ),
    );
  }

  _inputPaymentProofWidget(BuildContext context) {
    return controller.sellCryptoModel.data
                .walletType[controller.selectIndex.value] ==
            "Inside Wallet"
        ? const SizedBox.shrink()
        : Container(
            margin: EdgeInsets.only(bottom: Dimensions.paddingSize * .5),
            padding: EdgeInsets.symmetric(
                vertical: Dimensions.paddingVerticalSize * .5,
                horizontal: Dimensions.paddingHorizontalSize * .5),
            decoration: BoxDecoration(
              color: CustomColor.primaryLightColor.withOpacity(
                .06,
              ),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(
                  Dimensions.radius,
                ),
                bottomLeft: Radius.circular(
                  Dimensions.radius,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ...controller.inputFieldsPaymentProof.map((element) {
                  return element;
                }),
                verticalSpace(
                    (controller.inputFileFieldsPaymentProof.isNotEmpty &&
                            controller.inputFieldsPaymentProof.isNotEmpty)
                        ? Dimensions.marginBetweenInputBox
                        : 0),
                Visibility(
                  visible: controller.inputFileFieldsPaymentProof.isNotEmpty,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.inputFileFieldsPaymentProof.length,
                      itemBuilder: (BuildContext context, int index) {
                        return controller.inputFileFieldsPaymentProof[index];
                      }),
                ),

                verticalSpace(Dimensions.paddingVerticalSize * .7),
              ],
            ),
          );
  }

  _inputWidget(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(bottom: Dimensions.paddingSize * .5),
      padding: EdgeInsets.symmetric(
          vertical: Dimensions.paddingVerticalSize * .5,
          horizontal: Dimensions.paddingHorizontalSize * .5),
      decoration: BoxDecoration(
        color: CustomColor.primaryLightColor.withOpacity(
          .06,
        ),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(
            Dimensions.radius,
          ),
          bottomLeft: Radius.circular(
            Dimensions.radius,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...controller.inputFields.map((element) {
            return element;
          }),
          verticalSpace((controller.inputFileFields.isNotEmpty &&
                  controller.inputFields.isNotEmpty)
              ? Dimensions.marginBetweenInputBox
              : 0),
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
    );
  }

  _paymentProofTextWidget(BuildContext context) {
    return controller.sellCryptoModel.data
                .walletType[controller.selectIndex.value] ==
            "Inside Wallet"
        ? const SizedBox.shrink()
        : Container(
            margin: EdgeInsets.only(bottom: Dimensions.paddingSize * .15),
            height: MediaQuery.of(context).size.height * .05,
            width: double.infinity,
            decoration: BoxDecoration(
              color: CustomColor.primaryLightColor.withOpacity(
                .06,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  Dimensions.radius * 1.5,
                ),
                topRight: Radius.circular(
                  Dimensions.radius * 1.5,
                ),
              ),
            ),
            child: Column(
              mainAxisSize: mainMin,
              crossAxisAlignment: crossStart,
              mainAxisAlignment: mainCenter,
              children: [
                TitleHeading2Widget(
                  padding: EdgeInsets.only(left: Dimensions.paddingSize),
                  text: Strings.paymentProof,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          );
  }

  _receivingMethodInformationWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimensions.paddingSize * .15),
      height: MediaQuery.of(context).size.height * .05,
      width: double.infinity,
      decoration: BoxDecoration(
        color: CustomColor.primaryLightColor.withOpacity(
          .06,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            Dimensions.radius * 1.5,
          ),
          topRight: Radius.circular(
            Dimensions.radius * 1.5,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: mainMin,
        crossAxisAlignment: crossStart,
        mainAxisAlignment: mainCenter,
        children: [
          TitleHeading2Widget(
            padding: EdgeInsets.only(left: Dimensions.paddingSize),
            text: Strings.receivingMethodInformation,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
