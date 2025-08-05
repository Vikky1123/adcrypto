import 'package:adcrypto/backend/model/common/common_success_model.dart';

import '../../../../utils/basic_screen_imports.dart';
import '../../../backend/model/profile/profile_model.dart';
import '../../../backend/model/settings/country_list_model.dart';
import '../../../backend/services/auth_service/settings_service.dart';
import '../../../backend/utils/api_method.dart';
import '../../../backend/utils/custom_snackbar.dart';
import '../../basic_settings_controller.dart';

class UpdateProfileController extends GetxController with SettingsService {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final addressController = TextEditingController();
  final zipController = TextEditingController();
  RxString selectedCountryName = "".obs;
  RxString image = "".obs;
  RxString imagePath = "".obs;
  late Rx<Country> selectedCountry;
  RxList<Country> countries = <Country>[].obs;

  @override
  void onInit() {
    profileProcess();
    super.onInit();
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late ProfileModel _profileModel;
  ProfileModel get profileModel => _profileModel;

  ///* Profile in process
  Future<ProfileModel> profileProcess() async {
    imagePath.value = "";
    _isLoading.value = true;
    update();

    await profileProcessApi().then((value) {
      _profileModel = value!;

      var data = _profileModel.data.userInfo;
      var imagePath = _profileModel.data.imagePaths;

      firstNameController.text = data.firstname;
      lastNameController.text = data.lastname;
      phoneNumberController.text = data.mobile;
      stateController.text = data.state;
      cityController.text = data.city;
      zipController.text = data.zip;
      addressController.text = data.address;

      if(data.image.isNotEmpty){
        image.value = "${imagePath.baseUrl}/${imagePath.pathLocation}/${data.image}";
      }else{
        image.value = "${imagePath.baseUrl}/${imagePath.defaultImage}";
      }

      countries.value = Get.find<BasicSettingsController>().countryListModel.data.countries;
      if(_profileModel.data.userInfo.country.isEmpty){
        selectedCountry = countries.first.obs;
        selectedCountryName.value = countries.first.name;
      }
      else{
        for (var element in countries) {
          if(element.name == _profileModel.data.userInfo.country){
            selectedCountry = element.obs;
            selectedCountryName.value = element.name;
            break;
          }
        }
      }
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _profileModel;
  }


  void profileUpdate() {
    var data = _profileModel.data.userInfo;

    if (firstNameController.text == data.firstname &&
        lastNameController.text == data.lastname &&
        phoneNumberController.text == data.mobile &&
        stateController.text == data.state &&
        cityController.text == data.city &&
        zipController.text == data.zip &&
        addressController.text == data.address) {
      debugPrint("The values are the same.");
      CustomSnackBar.error("The values are the same.");
    } else {
      debugPrint("The values are not the same.");
      profileUpdateProcess();
    }
  }


  final _isUpdateLoading = false.obs;
  bool get isUpdateLoading => _isUpdateLoading.value;

  late CommonSuccessModel _profileUpdateModel;
  CommonSuccessModel get profileUpdateModel => _profileUpdateModel;

  ///* ProfileUpdate in process
  Future<CommonSuccessModel> profileUpdateProcess() async {
    _isUpdateLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'firstname': firstNameController.text,
      'lastname': lastNameController.text,
      'country': selectedCountryName.value,
      'mobile': phoneNumberController.text,
      'state': stateController.text,
      'city': cityController.text,
      'zip': zipController.text,
      'address': addressController.text,
    };
    await profileUpdateProcessApi(body: inputBody).then((value) {
      _profileUpdateModel = value!;
      profileProcess();
      _isUpdateLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isUpdateLoading.value = false;
    update();
    return _profileUpdateModel;
  }

  ///* ProfileUpdate in process with Image
  Future<CommonSuccessModel> profileUpdateWithImageProcess() async {
    _isUpdateLoading.value = true;
    update();

    Map<String, String> inputBody = {
      'firstname': firstNameController.text,
      'lastname': lastNameController.text,
      'country': selectedCountryName.value,
      'mobile': phoneNumberController.text,
      'state': stateController.text,
      'city': cityController.text,
      'zip': zipController.text,
      'address': addressController.text,
    };

    await profileUpdateWithImageProcessApi(body: inputBody, filepath: imagePath.value)
        .then((value) {
      _profileUpdateModel = value!;
      profileProcess();
      _isUpdateLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isUpdateLoading.value = false;
    update();
    return _profileUpdateModel;
  }

}