import 'dart:io';


import '../backend/model/auth/kyc_info_model.dart';
import '../backend/model/common/common_success_model.dart';
import '../backend/services/auth_service/settings_service.dart';
import '../backend/utils/api_method.dart';
import '../routes/routes.dart';
import '../utils/basic_screen_imports.dart';
import '../views/congratulation/congratulation_screen.dart';
import '../widgets/dropdown/custom_dropdown_widget.dart';
import '../widgets/others/custom_upload_file_widget.dart';

class KycController extends GetxController with SettingsService {
  @override
  void onInit() {
    kycInfoProcess();
    super.onInit();
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

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late KycInfoModel _kycInfoModel;
  KycInfoModel get kycInfoModel => _kycInfoModel;

  ///* KycInfo in process
  Future<KycInfoModel> kycInfoProcess() async {
    inputFields.clear();
    inputFileFields.clear();
    listImagePath.clear();
    idTypeList.clear();
    listFieldName.clear();
    inputFieldControllers.clear();

    _isLoading.value = true;
    update();

    await kycInfoProcessApi().then((value) {
      _kycInfoModel = value!;

      final data = _kycInfoModel.data.inputFields;
      _getDynamicInputField(data);

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _kycInfoModel;
  }

  void _getDynamicInputField(List<InputField> data) {
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
                isFilePicker: false,
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

  final _isSubmitLoading = false.obs;
  bool get isSubmitLoading => _isSubmitLoading.value;

  late CommonSuccessModel _commonSuccessModel;
  CommonSuccessModel get commonSuccessModel => _commonSuccessModel;

  ///* Kyc submit api process
  Future<CommonSuccessModel> kycSubmitApiProcess() async {
    _isSubmitLoading.value = true;
    Map<String, String> inputBody = {};

    final data = kycInfoModel.data.inputFields;

    for (int i = 0; i < data.length; i += 1) {
      if (data[i].type != 'file') {
        inputBody[data[i].name] = inputFieldControllers[i].text;
      }
    }

    await kycSubmitProcessApi(
            body: inputBody, fieldList: listFieldName, pathList: listImagePath)
        .then((value) {
      _commonSuccessModel = value!;

      inputFields.clear();
      listImagePath.clear();
      listFieldName.clear();
      inputFieldControllers.clear();

      Get.to(
        () => CongratulationScreen(
          route: Routes.dashboardScreen,
          subTitle: _commonSuccessModel.message.success.first,
        ),
      );

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isSubmitLoading.value = false;
    update();
    return _commonSuccessModel;
  }
}

class IdTypeModel implements DropdownModel {
  @override
  final String id;
  final String name;

  IdTypeModel(this.id, this.name);

  @override
  // TODO: implement title
  String get title => name;
}
