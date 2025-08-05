import 'dart:io';

import 'package:adcrypto/backend/model/common/common_success_model.dart';

import '../../../../utils/basic_screen_imports.dart';

import '../../../backend/model/sell_crypto/sell_crypto_model.dart' as index;
import '../../../backend/model/sell_crypto/sell_crypto_payment_info_store.dart';
import '../../../backend/model/sell_crypto/sell_crypto_store_model.dart';
import '../../../backend/services/sell_crypto/sell_crypto_service.dart';
import '../../../backend/utils/api_method.dart';
import '../../../routes/routes.dart';
import '../../../views/congratulation/congratulation_screen.dart';
import '../../../widgets/dropdown/custom_dropdown_widget.dart';
import '../../../widgets/others/custom_upload_file_widget.dart';
import '../../kyc_controller.dart';

class SellCryptoController extends GetxController with SellCryptoService {
  final amountController = TextEditingController();

  @override
  void onInit() {
    sellCryptoProcess();
    super.onInit();
  }

  late Rx<index.Currency> selectedCoin;
  late Rx<index.PaymentGateway> selectedReceivingMethod;

  RxList<index.Network> networkList = <index.Network>[].obs;
  late Rx<index.Network> selectedNetwork;

  RxInt selectIndex = 0.obs;

  RxDouble exchangeRate = 0.0.obs;
  RxDouble min = 0.0.obs;
  RxDouble max = 0.0.obs;
  // RxDouble rate = 0.0.obs;
  RxDouble fee = 0.0.obs;


  calculation(String value) {
    // charge calculation
    exchangeRate.value = double.parse(selectedReceivingMethod.value.rate) /
        double.parse(selectedCoin.value.rate);

    // limit calculation
    min.value =
        double.parse(selectedReceivingMethod.value.minLimit) / exchangeRate.value;
    max.value =
        double.parse(selectedReceivingMethod.value.maxLimit) / exchangeRate.value;

    // fees calculation
    if (value.isNotEmpty) {
      double amount = double.parse(value);
      double fixCharge = double.parse(selectedReceivingMethod.value.fixedCharge) / exchangeRate.value;
      double percCharge =
      double.parse(selectedReceivingMethod.value.percentCharge);

      fee.value = fixCharge + (amount * percCharge / 100);
    } else {
      fee.value = double.parse(selectedReceivingMethod.value.fixedCharge) / exchangeRate.value;
    }
  }


  goToSellCryptoPreviewScreen() {
    Get.toNamed(Routes.sellCryptoPreviewScreen);
  }

  goToSellCryptoPaymentProofScreen() {
    Get.toNamed(Routes.sellCryptoPaymentProofScreen);
  }

//------------------------------------------------------------------------------
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late index.SellCryptoModel _sellCryptoModel;
  index.SellCryptoModel get sellCryptoModel => _sellCryptoModel;

  ///* Get SellCrypto in process
  Future<index.SellCryptoModel> sellCryptoProcess() async {
    _isLoading.value = true;
    update();
    await sellCryptoProcessApi().then((value) {
      _sellCryptoModel = value!;

      _setData(_sellCryptoModel);
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _sellCryptoModel;
  }

  void _setData(index.SellCryptoModel data) {
    selectedCoin = data.data.currencies.first.obs;
    selectedReceivingMethod = data.data.paymentGateway.first.obs;
    networkList.value = selectedCoin.value.networks;
    selectedNetwork = networkList.first.obs;

    calculation("");
  }

//------------------------------------------------------------------------------
  final _isStoreLoading = false.obs;
  bool get isStoreLoading => _isStoreLoading.value;

  late SellCryptoStoreModel _sellCryptoStoreModel;
  SellCryptoStoreModel get sellCryptoStoreModel => _sellCryptoStoreModel;

  ///* SellCryptoStore in process
  Future<SellCryptoStoreModel> sellCryptoStoreProcess() async {
    inputFields.clear();
    inputFileFields.clear();
    listImagePath.clear();
    idTypeList.clear();
    listFieldName.clear();
    inputFieldControllers.clear();


    inputFieldsPaymentProof.clear();
    inputFileFieldsPaymentProof.clear();
    listImagePathPaymentProof.clear();
    idTypeListPaymentProof.clear();
    listFieldNamePaymentProof.clear();
    inputFieldControllersPaymentProof.clear();

    _isStoreLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'wallet_type': sellCryptoModel.data.walletType[selectIndex.value],
      'sender_currency': selectedCoin.value.id,
      'network': selectedNetwork.value.networkId,
      'amount': amountController.text,
      'payment_method': selectedReceivingMethod.value.id
    };
    await sellCryptoStoreProcessApi(body: inputBody).then((value) {
      _sellCryptoStoreModel = value!;

      _dynamicPageBuild(_sellCryptoStoreModel.data);

      if(_sellCryptoStoreModel.data.data.data.senderWallet.type == "Inside Wallet"){
        debugPrint("INSIDE WALLET--------");
        Get.toNamed(Routes.sellCryptoManualScreen);
      }else{
        debugPrint("OUTSIDE WALLET--------");
        sellCryptoOutsideStoreProcess();
      }

      _isStoreLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isStoreLoading.value = false;
    update();
    return _sellCryptoStoreModel;
  }


  List<TextEditingController> inputFieldControllers = [];
  RxList inputFields = [].obs;
  RxList inputFileFields = [].obs;

  final selectedIDType = "".obs;
  List<IdTypeModel> idTypeList = [];

  int totalFile = 0;
  List<String> listImagePath = [];
  List<String> listFieldName = [];
  RxBool hasFile = false.obs;

  // ----------   for payment proof
  List<TextEditingController> inputFieldControllersPaymentProof = [];
  RxList inputFieldsPaymentProof = [].obs;
  RxList inputFileFieldsPaymentProof = [].obs;

  final selectedIDTypePaymentProof = "".obs;
  List<IdTypeModel> idTypeListPaymentProof = [];

  int totalFilePaymentProof = 0;
  List<String> listImagePathPaymentProof = [];
  List<String> listFieldNamePaymentProof = [];
  RxBool hasFilePaymentProof = false.obs;

  void _dynamicPageBuild(SellCryptoStoreModelData model) {

    if(model.paymentGatewayFields.isNotEmpty){
      final List<PaymentField> paymentGatewayFields = [...model.paymentGatewayFields];

      for (int item = 0; item < paymentGatewayFields.length; item++) {
        debugPrint(paymentGatewayFields[item].type);

        // make the dynamic controller
        var textEditingController = TextEditingController();
        inputFieldControllers.add(textEditingController);
        if (paymentGatewayFields[item].type.contains('select')) {
          hasFile.value = true;
          selectedIDType.value = paymentGatewayFields[item].validation.options.first.toString();
          inputFieldControllers[item].text = selectedIDType.value;
          for (var element in paymentGatewayFields[item].validation.options) {
            idTypeList.add(IdTypeModel("", element));
          }
          inputFields.add(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => CustomDropDown<IdTypeModel>(
                    items: idTypeList,
                    title: paymentGatewayFields[item].label,
                    hint: selectedIDType.value.isEmpty
                        ? Strings.selectIDType
                        : selectedIDType.value,
                    onChanged: (value) {
                      selectedIDType.value = value!.title;
                    },
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingHorizontalSize * 0.25,
                    ),
                    titleTextColor:
                    CustomColor.primaryLightTextColor.withOpacity(.2),
                    borderEnable: true,
                    dropDownFieldColor: Colors.transparent,
                    dropDownIconColor:
                    CustomColor.primaryLightTextColor.withOpacity(.2))),
                verticalSpace(Dimensions.marginBetweenInputBox * .8),
              ],
            ),
          );
        }
        else if (paymentGatewayFields[item].type.contains('file')) {
          totalFile++;
          hasFile.value = true;
          inputFileFields.add(
            Column(
              mainAxisAlignment: mainStart,
              crossAxisAlignment: crossStart,
              children: [
                CustomUploadFileWidget(
                  labelText: paymentGatewayFields[item].label,
                  hint: paymentGatewayFields[item].validation.mimes.join(","),
                  onTap: (File value) {
                    updateImageData(paymentGatewayFields[item].name, value.path);
                  },
                ),
              ],
            ),
          );
        }
        else if (paymentGatewayFields[item].type.contains('text')) {
          inputFields.add(
            Column(
              mainAxisAlignment: mainStart,
              crossAxisAlignment: crossStart,
              children: [
                PrimaryTextInputWidget(
                  controller: inputFieldControllers[item],
                  labelText: paymentGatewayFields[item].label,
                  hintText: Strings.enter,
                  borderColor: Get.isDarkMode
                      ? CustomColor.primaryDarkTextColor.withOpacity(.15)
                      : CustomColor.primaryLightTextColor.withOpacity(.15),
                  color: Get.isDarkMode
                      ? CustomColor.primaryDarkColor.withOpacity(.1)
                      : CustomColor.primaryLightColor.withOpacity(.1),
                ),
                verticalSpace(Dimensions.marginBetweenInputBox * .8),
              ],
            ),
          );
        }
      }
    }


    if(model.paymentProofFields.isNotEmpty){
      final List<PaymentField> paymentProofFields = [...model.paymentProofFields];

      for (int item = 0; item < paymentProofFields.length; item++) {
        debugPrint(paymentProofFields[item].type);

        // make the dynamic controller
        var textEditingController = TextEditingController();
        inputFieldControllersPaymentProof.add(textEditingController);
        if (paymentProofFields[item].type.contains('select')) {
          hasFilePaymentProof.value = true;
          selectedIDTypePaymentProof.value = paymentProofFields[item].validation.options.first.toString();
          inputFieldControllersPaymentProof[item].text = selectedIDType.value;
          for (var element in paymentProofFields[item].validation.options) {
            idTypeListPaymentProof.add(IdTypeModel("", element));
          }
          inputFieldsPaymentProof.add(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => CustomDropDown<IdTypeModel>(
                    items: idTypeListPaymentProof,
                    title: paymentProofFields[item].label,
                    hint: selectedIDTypePaymentProof.value.isEmpty
                        ? Strings.selectIDType
                        : selectedIDTypePaymentProof.value,
                    onChanged: (value) {
                      selectedIDTypePaymentProof.value = value!.title;
                    },
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingHorizontalSize * 0.25,
                    ),
                    titleTextColor:
                    CustomColor.primaryLightTextColor.withOpacity(.2),
                    borderEnable: true,
                    dropDownFieldColor: Colors.transparent,
                    dropDownIconColor:
                    CustomColor.primaryLightTextColor.withOpacity(.2))),
                verticalSpace(Dimensions.marginBetweenInputBox * .8),
              ],
            ),
          );
        }
        else if (paymentProofFields[item].type.contains('file')) {
          totalFilePaymentProof++;
          hasFilePaymentProof.value = true;
          inputFileFieldsPaymentProof.add(
            Column(
              mainAxisAlignment: mainStart,
              crossAxisAlignment: crossStart,
              children: [
                CustomUploadFileWidget(
                  labelText: paymentProofFields[item].label,
                  hint: paymentProofFields[item].validation.mimes.join(","),
                  onTap: (File value) {
                    updateImageDataPaymentProof(paymentProofFields[item].name, value.path);
                  },
                ),
              ],
            ),
          );
        }
        else if (paymentProofFields[item].type.contains('text')) {
          inputFieldsPaymentProof.add(
            Column(
              mainAxisAlignment: mainStart,
              crossAxisAlignment: crossStart,
              children: [
                PrimaryTextInputWidget(
                  controller: inputFieldControllersPaymentProof[item],
                  labelText: paymentProofFields[item].label,
                  hintText: Strings.enter,
                  borderColor: Get.isDarkMode
                      ? CustomColor.primaryDarkTextColor.withOpacity(.15)
                      : CustomColor.primaryLightTextColor.withOpacity(.15),
                  color: Get.isDarkMode
                      ? CustomColor.primaryDarkColor.withOpacity(.1)
                      : CustomColor.primaryLightColor.withOpacity(.1),
                ),
                verticalSpace(Dimensions.marginBetweenInputBox * .8),
              ],
            ),
          );
        }
      }
    }
  }

  updateImageData(String fieldName, String imagePath) {
    if (listFieldName.contains(fieldName)) {
      int itemIndex = listFieldName.indexOf(fieldName);
      listImagePath[itemIndex] = imagePath;
    } else {
      listFieldName.add(fieldName);
      listImagePath.add(imagePath);
    }
    update();
  }

  updateImageDataPaymentProof(String fieldName, String imagePath) {
    if (listFieldNamePaymentProof.contains(fieldName)) {
      int itemIndex = listFieldNamePaymentProof.indexOf(fieldName);
      listImagePathPaymentProof[itemIndex] = imagePath;
    } else {
      listFieldNamePaymentProof.add(fieldName);
      listImagePathPaymentProof.add(imagePath);
    }
    update();
  }


//------------------------------------------------------------------------------
  final _isOutsideStoreLoading = false.obs;
  bool get isOutsideStoreLoading => _isOutsideStoreLoading.value;

  late CommonSuccessModel _sellCryptoOutsideStoreModel;
  CommonSuccessModel get sellCryptoOutsideStoreModel =>
      _sellCryptoOutsideStoreModel;

  ///* SellCryptoOutsideStore in process
  Future<CommonSuccessModel> sellCryptoOutsideStoreProcess() async {

    _isOutsideStoreLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'identifier': _sellCryptoStoreModel.data.data.identifier,
      'slug': _sellCryptoStoreModel.data.slug,
    };
    await sellCryptoOutsideStoreProcessApi(body: inputBody).then((value) {
      _sellCryptoOutsideStoreModel = value!;

      Get.toNamed(Routes.sellCryptoQRScreen);

      _isOutsideStoreLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isOutsideStoreLoading.value = false;
    update();
    return _sellCryptoOutsideStoreModel;
  }

//------------------------------------------------------------------------------
  final _isPaymentInfoStoreLoading = false.obs;
  bool get isPaymentInfoStoreLoading => _isPaymentInfoStoreLoading.value;

  late SellCryptoPaymentInfoStoreModel _sellCryptoPaymentInfoStoreModel;
  SellCryptoPaymentInfoStoreModel get sellCryptoPaymentInfoStoreModel =>
      _sellCryptoPaymentInfoStoreModel;

  ///* SellCryptoPaymentInfoStore in process
  Future<SellCryptoPaymentInfoStoreModel>
      sellCryptoPaymentInfoStoreProcess() async {
    _isPaymentInfoStoreLoading.value = true;
    update();
    Map<String, String> inputBody = {
      'identifier': _sellCryptoStoreModel.data.data.identifier,
    };


    if(_sellCryptoStoreModel.data.paymentGatewayFields.isNotEmpty){
      final data = _sellCryptoStoreModel.data.paymentGatewayFields;

      for (int i = 0; i < data.length; i += 1) {
        if (data[i].type != 'file') {
          inputBody[data[i].name] = inputFieldControllers[i].text;
        }
      }
    }

    // for payment proof
    if(_sellCryptoStoreModel.data.paymentProofFields.isNotEmpty){
      final data = _sellCryptoStoreModel.data.paymentProofFields;

      for (int i = 0; i < data.length; i += 1) {
        if (data[i].type != 'file') {
          inputBody[data[i].name] = inputFieldControllersPaymentProof[i].text;
        }
      }
    }

    List<String> fieldList = [
      ...listFieldName,
      ...listFieldNamePaymentProof,
    ];

    List<String> pathList = [
      ...listImagePath,
      ...listImagePathPaymentProof,
    ];


    await sellCryptoPaymentInfoStoreProcessApi(body: inputBody,  fieldList: fieldList, pathList: pathList).then((value) {
      _sellCryptoPaymentInfoStoreModel = value!;

      _dynamicPreview(_sellCryptoPaymentInfoStoreModel.data);

      Get.toNamed(Routes.sellCryptoPreviewScreen);
      _isPaymentInfoStoreLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isPaymentInfoStoreLoading.value = false;
    update();
    return _sellCryptoPaymentInfoStoreModel;
  }

  final List<DynamicPreview> paymentProofPreview = [];
  final List<DynamicPreview> receivingMethodPreview = [];

  void _dynamicPreview(SellCryptoPaymentInfoStoreModelData data) {
    if(data.details.gatewayInputValues.isNotEmpty){
      for (var element in data.details.gatewayInputValues) {

        receivingMethodPreview.add(DynamicPreview(
            name: element.label,
            value: element.value,
            type: element.type.contains("file") ? PreviewType.image: PreviewType.text
        ));
      }

    }

    if(data.details.outsideAddressInputValues.isNotEmpty){
      for (var element in data.details.outsideAddressInputValues) {

        paymentProofPreview.add(DynamicPreview(
            name: element.label,
            value: element.value,
            type: element.type.contains("file") ? PreviewType.image: PreviewType.text
        ));
      }

    }

    debugPrint("Payment Method: ${receivingMethodPreview.length}");
    debugPrint("Proof Method: ${paymentProofPreview.length}");
  }



//------------------------------------------------------------------------------
  final _isConfirmLoading = false.obs;
  bool get isConfirmLoading => _isConfirmLoading.value;

  late CommonSuccessModel _sellConfirmStoreModel;
  CommonSuccessModel get sellConfirmStoreModel => _sellConfirmStoreModel;

  ///* SellConfirmStore in process
  Future<CommonSuccessModel> sellConfirmStoreProcess() async {
    _isConfirmLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'identifier': _sellCryptoStoreModel.data.data.identifier,
    };
    await sellConfirmStoreProcessApi(body: inputBody).then((value) {
      _sellConfirmStoreModel = value!;

      inputFields.clear();
      listImagePath.clear();
      listFieldName.clear();
      inputFieldControllers.clear();

      inputFieldsPaymentProof.clear();
      listImagePathPaymentProof.clear();
      listFieldNamePaymentProof.clear();
      inputFieldControllersPaymentProof.clear();

      Get.to(
            () => CongratulationScreen(
          route: Routes.dashboardScreen,
          subTitle: _sellConfirmStoreModel.message.success.first,
        ),
      );

      _isConfirmLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isConfirmLoading.value = false;
    update();
    return _sellConfirmStoreModel;
  }

}
