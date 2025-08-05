import 'package:adcrypto/backend/utils/custom_loading_api.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../controller/dashboard/sell_crypto/sell_crypto_controller.dart';
import '../../../custom_assets/assets.gen.dart';
import '../../../routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/others/custom_back_button.dart';
import '../../../widgets/others/custom_image_widget.dart';

class OutsideQRScreenScreenMobile extends StatelessWidget {
  OutsideQRScreenScreenMobile({super.key});

  final controller = Get.find<SellCryptoController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isOutsideStoreLoading ? const CustomLoadingAPI(): Container(
      decoration: CustomStyle.screenGradientBG,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColor.gradientColorTop,
          leading: CustomBackButton(
            onTap: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: TitleHeading3Widget(
            text: Strings.sellCrypto.tr,
          ),
        ),
        backgroundColor: CustomColor.transparentColor,
        body: _bodyWidget(context),
      ),
    ));
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSize,
          vertical: Dimensions.paddingSize * 2),
      children: [
        _qrCodeWidget(context),
        _addressFieldWidget(),
        _amountFieldWidget(),
        _backToHomeButtonWidget(context),
      ],
    );
  }

  _qrCodeWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.paddingSize * 1.5),
      height: MediaQuery.of(context).size.height * .40,
      decoration: BoxDecoration(
        color: CustomColor.primaryLightColor.withOpacity(.06),
        borderRadius: BorderRadius.circular(
          Dimensions.radius,
        ),
      ),
      child: Center(
        child: QrImageView(
          data: controller.sellCryptoStoreModel.data.slug,
          version: QrVersions.auto,
          dataModuleStyle: QrDataModuleStyle(
            color: CustomColor.primaryLightColor,
            dataModuleShape: QrDataModuleShape.square,
          ),
          eyeStyle: QrEyeStyle(
              color: CustomColor.primaryLightColor,
              eyeShape: QrEyeShape.square),
          backgroundColor: Colors.transparent
        ),
      ),
    );
  }

  _backToHomeButtonWidget(BuildContext context) {
    return controller.isOutsideStoreLoading ? const CustomLoadingAPI(): Padding(
      padding: EdgeInsets.only(
        top: Dimensions.paddingSize * 1.25,
        bottom: Dimensions.paddingSize * .75,
      ),
      child: PrimaryButton(
        title: Strings.continueBtn.tr,
        onPressed: () {
          Get.toNamed(Routes.sellCryptoManualScreen);
        },
        borderColor: Get.isDarkMode
            ? CustomColor.primaryDarkColor
            : CustomColor.primaryLightColor,
        buttonColor: Get.isDarkMode
            ? CustomColor.primaryDarkColor
            : CustomColor.primaryLightColor,
      ),
    );
  }

  _addressFieldWidget() {
    return Padding(
      padding: EdgeInsets.only(
        top: Dimensions.paddingVerticalSize * .1,
      ),
      child: PrimaryTextInputWidget(
        readOnly: true,
        controller: TextEditingController(text: controller.sellCryptoStoreModel.data.slug),
        labelText: "",
        hintText: "",
        borderColor: Get.isDarkMode
            ? CustomColor.primaryDarkTextColor.withOpacity(.15)
            : CustomColor.primaryLightTextColor.withOpacity(.15),
        suffixIcon: InkWell(
          onTap: () async {
            await Clipboard.setData(ClipboardData(text: controller.sellCryptoStoreModel.data.slug));
          },
          child: Padding(
            padding: EdgeInsets.only(
              right: Dimensions.paddingSize * .5,
              top: Dimensions.paddingSize * .30,
              bottom: Dimensions.paddingSize * .30,
            ),
            child: CircleAvatar(
              radius: Dimensions.radius,
              backgroundColor: CustomColor.primaryLightColor,
              child: CustomImageWidget(
                path: Assets.icon.iconPasteSvg,
                height: Dimensions.heightSize * 1.5,
                width: Dimensions.widthSize * 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
  _amountFieldWidget() {
    return Padding(
      padding: EdgeInsets.only(
        top: Dimensions.paddingVerticalSize * .1,
      ),
      child: PrimaryTextInputWidget(
        readOnly: true,
        controller: TextEditingController(text: controller.sellCryptoStoreModel.data.data.data.totalPayable.toString()),
        labelText: "",
        hintText: "",
        borderColor: Get.isDarkMode
            ? CustomColor.primaryDarkTextColor.withOpacity(.15)
            : CustomColor.primaryLightTextColor.withOpacity(.15),
        suffixIcon: InkWell(
          onTap: () async {
            await Clipboard.setData(ClipboardData(text: controller.sellCryptoStoreModel.data.data.data.totalPayable.toString()));
          },
          child: Padding(
            padding: EdgeInsets.only(
              right: Dimensions.paddingSize * .5,
              top: Dimensions.paddingSize * .30,
              bottom: Dimensions.paddingSize * .30,
            ),
            child: CircleAvatar(
              radius: Dimensions.radius,
              backgroundColor: CustomColor.primaryLightColor,
              child: CustomImageWidget(
                path: Assets.icon.iconPasteSvg,
                height: Dimensions.heightSize * 1.5,
                width: Dimensions.widthSize * 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}