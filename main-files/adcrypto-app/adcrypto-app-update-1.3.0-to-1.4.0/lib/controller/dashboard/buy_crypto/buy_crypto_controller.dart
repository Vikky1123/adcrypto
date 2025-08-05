import 'dart:io';

import '../../../../utils/basic_screen_imports.dart';

import '../../../backend/model/buy_crypto/buy_crypto_automatic_model.dart';
import '../../../backend/model/buy_crypto/buy_crypto_manual_model.dart'
    as manual;
import '../../../backend/model/buy_crypto/buy_crypto_model.dart';
import '../../../backend/model/buy_crypto/buy_crypto_store_model.dart' as store;
import '../../../backend/model/buy_crypto/buy_crypto_tatum_model.dart' as tatum;
import '../../../backend/model/common/common_success_model.dart';
import '../../../backend/services/buy_crypto/buy_crypto_service.dart';
import '../../../backend/utils/api_method.dart';
import '../../../routes/routes.dart';
import '../../../views/congratulation/congratulation_screen.dart';
import '../../../views/dynamic_web_screen/dynamic_web_screen.dart';
import '../../../widgets/dropdown/custom_dropdown_widget.dart';
import '../../../widgets/others/custom_upload_file_widget.dart';
import '../../kyc_controller.dart';

class BuyCryptoController extends GetxController with BuyCryptoService {
  // final sellCryptoAddressController = TextEditingController();

  final amountController = TextEditingController();
  final cryptoAddressController = TextEditingController();

  RxInt selectIndex = 0.obs;

  late Rx<Currency> selectedCoin;
  late Rx<PaymentGateway> selectedPaymentMethod;

  RxList<Network> networkList = <Network>[].obs;
  late Rx<Network> selectedNetwork;

  RxDouble exchangeRate = 0.0.obs;
  RxDouble min = 0.0.obs;
  RxDouble max = 0.0.obs;
  // RxDouble rate = 0.0.obs;
  RxDouble fee = 0.0.obs;

  calculation(String value) {
    // charge calculation
    exchangeRate.value = double.parse(selectedPaymentMethod.value.rate) /
        double.parse(selectedCoin.value.rate);

    // limit calculation
    min.value =
        double.parse(selectedPaymentMethod.value.minLimit) / exchangeRate.value;
    max.value =
        double.parse(selectedPaymentMethod.value.maxLimit) / exchangeRate.value;

    // fees calculation
    if (value.isNotEmpty) {
      double amount = double.parse(value) * exchangeRate.value;
      double fixCharge = double.parse(selectedPaymentMethod.value.fixedCharge);
      double percCharge =
          double.parse(selectedPaymentMethod.value.percentCharge);

      fee.value = fixCharge + (amount * percCharge / 100);
    } else {
      fee.value = double.parse(selectedPaymentMethod.value.fixedCharge);
    }
  }

  @override
  void onInit() {
    buyCryptoProcess();
    super.onInit();
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late BuyCryptoModel _buyCryptoModel;
  BuyCryptoModel get buyCryptoModel => _buyCryptoModel;

  ///* Get BuyCrypto in process
  Future<BuyCryptoModel> buyCryptoProcess() async {
    _isLoading.value = true;
    update();
    await buyCryptoProcessApi().then((value) {
      _buyCryptoModel = value!;

      _setValues(_buyCryptoModel);
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _buyCryptoModel;
  }

  void _setValues(BuyCryptoModel buyCryptoModel) {
    selectedCoin = buyCryptoModel.data.currencies.first.obs;
    networkList.value = selectedCoin.value.networks;
    selectedNetwork = networkList.first.obs;
    selectedPaymentMethod = buyCryptoModel.data.paymentGateway.first.obs;

    calculation("");
  }

  final _isStoreLoading = false.obs;
  bool get isStoreLoading => _isStoreLoading.value;

  late store.BuyCryptoStoreModel _buyCryptoStoreModel;
  store.BuyCryptoStoreModel get buyCryptoStoreModel => _buyCryptoStoreModel;

  ///* BuyCryptoStore in process
  Future<store.BuyCryptoStoreModel> buyCryptoStoreProcess() async {
    _isStoreLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'wallet_type': _buyCryptoModel.data.walletType[selectIndex.value],
      'sender_currency': selectedCoin.value.id,
      'network': selectedNetwork.value.networkId,
      'amount': amountController.text,
      'wallet_address':
          selectIndex.value == 1 ? cryptoAddressController.text : "",
      'payment_method': selectedPaymentMethod.value.id
    };
    await buyCryptoStoreProcessApi(body: inputBody).then((value) {
      _buyCryptoStoreModel = value!;

      Get.toNamed(Routes.buyCryptoPreviewScreen);
      _isStoreLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isStoreLoading.value = false;
    update();
    return _buyCryptoStoreModel;
  }

  final _isSubmitLoading = false.obs;
  bool get isSubmitLoading => _isSubmitLoading.value;

  late BuyCryptoAutomaticModel _buyCryptoAutomaticSubmitModel;
  BuyCryptoAutomaticModel get buyCryptoAutomaticSubmitModel =>
      _buyCryptoAutomaticSubmitModel;

  ///* BuyCryptoSubmit in process
  Future<BuyCryptoAutomaticModel> buyCryptoAutomaticSubmitProcess() async {
    _isSubmitLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'identifier': buyCryptoStoreModel.data.data.identifier,
    };
    await buyCryptoAutomaticSubmitProcessApi(body: inputBody).then((value) {
      _buyCryptoAutomaticSubmitModel = value!;

      Get.to(WebViewScreen(
        link: _buyCryptoAutomaticSubmitModel.data.redirectUrl,
        appTitle: buyCryptoStoreModel.data.data.data.paymentMethod.name,
        onFinished: (url) {
          if (url.toString().contains('success/response') ||
              url.toString().contains('complete') ||
              url.toString().contains('status=successful') ||
              url.toString().contains('paystack/pay/callback') ||
              url
                  .toString()
                  .contains('add-money/razor/callback?razorpay_order_id') ||
              url.toString().contains('sslcommerz/success') ||
              url.toString().contains('stripe/payment/success/')) {
            Get.to(
              () => const CongratulationScreen(
                route: Routes.dashboardScreen,
                subTitle: Strings.buyCryptoCongratulationSubtitle,
              ),
            );
          }
        },
      ));

      _isSubmitLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isSubmitLoading.value = false;
    update();
    return _buyCryptoAutomaticSubmitModel;
  }

  late tatum.BuyCryptoTatumModel _buyCryptoTatumModel;
  tatum.BuyCryptoTatumModel get buyCryptoTatumModel => _buyCryptoTatumModel;

  ///* BuyCryptoTatum in process
  Future<tatum.BuyCryptoTatumModel> buyCryptoTatumProcess() async {

    _isSubmitLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'identifier': buyCryptoStoreModel.data.data.identifier,
    };
    await buyCryptoTatumProcessApi(body: inputBody).then((value) {
      _buyCryptoTatumModel = value!;

      getDynamicInputFieldForTatum(data:
          _buyCryptoTatumModel.data.addressInfo.inputFields);

      Get.toNamed(Routes.buyCryptoManualScreen);

      _isSubmitLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isSubmitLoading.value = false;
    update();
    return _buyCryptoTatumModel;
  }

  void getDynamicInputFieldForTatum({ required List<tatum.InputField> data}) {
    inputFields.clear();
    inputFileFields.clear();
    listImagePath.clear();
    idTypeList.clear();
    listFieldName.clear();
    inputFieldControllers.clear();


    for (int item = 0; item < data.length; item++) {
      // make the dynamic controller
      var textEditingController = TextEditingController();
      inputFieldControllers.add(textEditingController);
      if (data[item].type.contains('text')) {
        inputFields.add(
          Column(
            mainAxisAlignment: mainStart,
            crossAxisAlignment: crossStart,
            children: [
              PrimaryTextInputWidget(
                controller: inputFieldControllers[item],
                labelText: data[item].label,
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

  late CommonSuccessModel _buyCryptoTatumSubmitModel;
  CommonSuccessModel get buyCryptoTatumSubmitModel =>
      _buyCryptoTatumSubmitModel;

  ///* BuyCryptoTatumSubmit in process
  Future<CommonSuccessModel> buyCryptoTatumSubmitProcess({ required List<tatum.InputField> data, required String url}) async {
    _isManualSubmitLoading.value = true;
    update();
    Map<String, String> inputBody = {};

    // final data = _buyCryptoTatumModel.data.addressInfo.inputFields;

    for (int i = 0; i < data.length; i += 1) {
      if (data[i].type != 'file') {
        inputBody[data[i].name] = inputFieldControllers[i].text;
      }
    }

    await buyCryptoTatumSubmitProcessApi(
            body: inputBody, url: url)
        .then((value) {
      _buyCryptoTatumSubmitModel = value!;

      inputFields.clear();
      listImagePath.clear();
      listFieldName.clear();
      inputFieldControllers.clear();

      Get.to(
        () => CongratulationScreen(
          route: Routes.dashboardScreen,
          subTitle: _buyCryptoManualSubmitModel.message.success.first,
        ),
      );

      _isManualSubmitLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isManualSubmitLoading.value = false;
    update();
    return _buyCryptoTatumSubmitModel;
  }

  // --------------------------------------
  List<TextEditingController> inputFieldControllers = [];
  RxList inputFields = [].obs;
  RxList inputFileFields = [].obs;

  final selectedIDType = "".obs;
  List<IdTypeModel> idTypeList = [];

  int totalFile = 0;
  List<String> listImagePath = [];
  List<String> listFieldName = [];
  RxBool hasFile = false.obs;

  late manual.BuyCryptoManualModel _buyCryptoManualModel;
  manual.BuyCryptoManualModel get buyCryptoManualModel => _buyCryptoManualModel;

  ///* Get BuyCryptoManual in process
  Future<manual.BuyCryptoManualModel> buyCryptoManualProcess() async {
    inputFields.clear();
    inputFileFields.clear();
    listImagePath.clear();
    idTypeList.clear();
    listFieldName.clear();
    inputFieldControllers.clear();

    _isSubmitLoading.value = true;
    update();
    await buyCryptoManualProcessApi(selectedPaymentMethod.value.alias)
        .then((value) {
      _buyCryptoManualModel = value!;

      final data = _buyCryptoManualModel.data.inputFields;
      _getDynamicInputField(data);
      Get.toNamed(Routes.buyCryptoManualScreen);
      _isSubmitLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isSubmitLoading.value = false;
    update();
    return _buyCryptoManualModel;
  }

  void _getDynamicInputField(List<manual.InputField> data) {
    for (int item = 0; item < data.length; item++) {
      // make the dynamic controller
      var textEditingController = TextEditingController();
      inputFieldControllers.add(textEditingController);
      // make dynamic input widget
      if (data[item].type.contains('select')) {
        hasFile.value = true;
        selectedIDType.value = data[item].validation.options.first.toString();
        inputFieldControllers[item].text = selectedIDType.value;
        for (var element in data[item].validation.options) {
          idTypeList.add(IdTypeModel("", element));
        }
        inputFields.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => CustomDropDown<IdTypeModel>(
                  items: idTypeList,
                  title: data[item].label,
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
      else if (data[item].type.contains('file')) {
        totalFile++;
        hasFile.value = true;
        inputFileFields.add(
          Column(
            mainAxisAlignment: mainStart,
            crossAxisAlignment: crossStart,
            children: [
              CustomUploadFileWidget(
                labelText: data[item].label,
                hint: data[item].validation.mimes.join(","),
                onTap: (File value) {
                  updateImageData(data[item].name, value.path);
                },
              ),
            ],
          ),
        );
      }
      else if (data[item].type.contains('text')) {
        inputFields.add(
          Column(
            mainAxisAlignment: mainStart,
            crossAxisAlignment: crossStart,
            children: [
              PrimaryTextInputWidget(
                controller: inputFieldControllers[item],
                labelText: data[item].label,
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

  final _isManualSubmitLoading = false.obs;
  bool get isManualSubmitLoading => _isManualSubmitLoading.value;

  late CommonSuccessModel _buyCryptoManualSubmitModel;
  CommonSuccessModel get buyCryptoManualSubmitModel =>
      _buyCryptoManualSubmitModel;

  ///* BuyCryptoManualSubmit in process
  Future<CommonSuccessModel> buyCryptoManualSubmitProcess() async {
    _isManualSubmitLoading.value = true;
    update();
    Map<String, String> inputBody = {
      'identifier': buyCryptoStoreModel.data.data.identifier,
    };

    final data = _buyCryptoManualModel.data.inputFields;

    for (int i = 0; i < data.length; i += 1) {
      if (data[i].type != 'file') {
        inputBody[data[i].name] = inputFieldControllers[i].text;
      }
    }

    await buyCryptoManualSubmitProcessApi(
            body: inputBody, fieldList: listFieldName, pathList: listImagePath)
        .then((value) {
      _buyCryptoManualSubmitModel = value!;

      inputFields.clear();
      listImagePath.clear();
      listFieldName.clear();
      inputFieldControllers.clear();

      Get.to(
        () => CongratulationScreen(
          route: Routes.dashboardScreen,
          subTitle: _buyCryptoManualSubmitModel.message.success.first,
        ),
      );

      _isManualSubmitLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isManualSubmitLoading.value = false;
    update();
    return _buyCryptoManualSubmitModel;
  }
}
