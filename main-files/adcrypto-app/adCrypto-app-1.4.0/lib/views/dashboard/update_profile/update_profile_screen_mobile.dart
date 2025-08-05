import 'package:adcrypto/backend/utils/custom_loading_api.dart';

import '../../../backend/model/settings/country_list_model.dart';
import '../../../controller/dashboard/update_profile/update_profile_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/image_picker/profile_image_update_and_view_widget.dart';
import '../../../widgets/inputs/primary_dropdown_input_widget.dart';
import '../../../widgets/others/custom_back_button.dart';

class UpdateProfileScreenMobile extends StatelessWidget {
  UpdateProfileScreenMobile({super.key});

  final updateProfileFormKey = GlobalKey<FormState>();
  final controller = Get.put(UpdateProfileController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: CustomStyle.screenGradientBG,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColor.gradientColorTop,
          leading: CustomBackButton(
            onTap: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: TitleHeading3Widget(
            text: Strings.updateProfile.tr,
          ),
        ),
        backgroundColor: CustomColor.transparentColor,
        body: Obx(() => controller.isLoading
            ? const CustomLoadingAPI()
            : _bodyWidget(context)),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(
          right: Dimensions.paddingSize,
          left: Dimensions.paddingSize,
          top: Dimensions.marginSizeVertical * 1.25,
          bottom: Dimensions.marginSizeVertical * 1.25,
      ),
      physics: const BouncingScrollPhysics(),
      children: [
        _userImageWidget(context),
        _inputWidget(context),
        _buttonWidget(context),
      ],
    );
  }

  _userImageWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.marginSizeVertical * .5),
      child: const Center(
        child: ProfileImageUpdateAndViewWidget(),
      ),
    );
  }

  _inputWidget(BuildContext context) {
    return Form(
      key: updateProfileFormKey,
      child: Padding(
        padding: EdgeInsets.only(top: Dimensions.paddingSize),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: PrimaryTextInputWidget(
                    keyboardType: TextInputType.emailAddress,
                    hintText: "",
                    controller: controller.firstNameController,
                    borderColor: Get.isDarkMode
                        ? CustomColor.primaryDarkTextColor.withOpacity(.15)
                        : CustomColor.primaryLightTextColor.withOpacity(.15),
                    color: Get.isDarkMode
                        ? CustomColor.primaryDarkColor.withOpacity(.1)
                        : CustomColor.primaryLightColor.withOpacity(.1),
                    labelText: Strings.firstName,
                  ),
                ),
                horizontalSpace(Dimensions.paddingSize),
                Expanded(
                  flex: 1,
                  child: PrimaryTextInputWidget(
                    keyboardType: TextInputType.emailAddress,
                    hintText: "",
                    controller: controller.lastNameController,
                    borderColor: Get.isDarkMode
                        ? CustomColor.primaryDarkTextColor.withOpacity(.15)
                        : CustomColor.primaryLightTextColor.withOpacity(.15),
                    color: Get.isDarkMode
                        ? CustomColor.primaryDarkColor.withOpacity(.1)
                        : CustomColor.primaryLightColor.withOpacity(.1),
                    labelText: Strings.lastName,
                  ),
                ),
              ],
            ),
            verticalSpace(Dimensions.marginSizeVertical * .5),
            PrimaryTextInputWidget(
              keyboardType: TextInputType.number,
              hintText: "XXX XXXX XXX",
              controller: controller.phoneNumberController,
              borderColor: Get.isDarkMode
                  ? CustomColor.primaryDarkTextColor.withOpacity(.15)
                  : CustomColor.primaryLightTextColor.withOpacity(.15),
              color: Get.isDarkMode
                  ? CustomColor.primaryDarkColor.withOpacity(.1)
                  : CustomColor.primaryLightColor.withOpacity(.1),
              labelText: Strings.phoneNumber.tr,
            ),
            verticalSpace(Dimensions.marginSizeVertical * .5),
            PrimaryDropdownWidget<Country>(
                selectedValue: controller.selectedCountry.value,
                items: controller.countries,
                onChanged: (value) {
                  controller.selectedCountry.value = value!;
                  controller.selectedCountryName.value = value.name;
                },
                displayText: (item) => item.name,
                labelText: Strings.country.tr,
                borderColor: Get.isDarkMode
                    ? CustomColor.primaryDarkTextColor.withOpacity(.15)
                    : CustomColor.primaryLightTextColor.withOpacity(.15)),
            verticalSpace(Dimensions.marginSizeVertical * .5),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: PrimaryTextInputWidget(
                    hintText: Strings.enterCity.tr,
                    controller: controller.cityController,
                    borderColor: Get.isDarkMode
                        ? CustomColor.primaryDarkTextColor.withOpacity(.15)
                        : CustomColor.primaryLightTextColor.withOpacity(.15),
                    color: Get.isDarkMode
                        ? CustomColor.primaryDarkColor.withOpacity(.1)
                        : CustomColor.primaryLightColor.withOpacity(.1),
                    labelText: Strings.city,
                  ),
                ),
                horizontalSpace(Dimensions.paddingSize),
                Expanded(
                  flex: 1,
                  child: PrimaryTextInputWidget(
                    hintText: Strings.enterState.tr,
                    controller: controller.stateController,
                    borderColor: Get.isDarkMode
                        ? CustomColor.primaryDarkTextColor.withOpacity(.15)
                        : CustomColor.primaryLightTextColor.withOpacity(.15),
                    color: Get.isDarkMode
                        ? CustomColor.primaryDarkColor.withOpacity(.1)
                        : CustomColor.primaryLightColor.withOpacity(.1),
                    labelText: Strings.state,
                  ),
                ),
              ],
            ),
            verticalSpace(Dimensions.marginSizeVertical * .5),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: PrimaryTextInputWidget(
                    hintText: Strings.enterAddress.tr,
                    controller: controller.addressController,
                    borderColor: Get.isDarkMode
                        ? CustomColor.primaryDarkTextColor.withOpacity(.15)
                        : CustomColor.primaryLightTextColor.withOpacity(.15),
                    color: Get.isDarkMode
                        ? CustomColor.primaryDarkColor.withOpacity(.1)
                        : CustomColor.primaryLightColor.withOpacity(.1),
                    labelText: Strings.address,
                  ),
                ),
                horizontalSpace(Dimensions.paddingSize),
                Expanded(
                  flex: 1,
                  child: PrimaryTextInputWidget(
                    hintText: Strings.enterZipCode.tr,
                    controller: controller.zipController,
                    borderColor: Get.isDarkMode
                        ? CustomColor.primaryDarkTextColor.withOpacity(.15)
                        : CustomColor.primaryLightTextColor.withOpacity(.15),
                    color: Get.isDarkMode
                        ? CustomColor.primaryDarkColor.withOpacity(.1)
                        : CustomColor.primaryLightColor.withOpacity(.1),
                    labelText: Strings.zipCode,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.paddingSize),
      child: Obx(() => controller.isUpdateLoading
          ? const CustomLoadingAPI()
          : PrimaryButton(
              title: Strings.updateProfile.tr,
              onPressed: () {
                if (updateProfileFormKey.currentState!.validate()) {
                  if(controller.imagePath.value.isEmpty){
                    debugPrint("=====  Without Image");
                    controller.profileUpdate();
                  }else{
                    debugPrint("=====  With Image");
                    controller.profileUpdateWithImageProcess();
                  }

                }
              },
              borderColor: Get.isDarkMode
                  ? CustomColor.primaryDarkColor
                  : CustomColor.primaryLightColor,
              buttonColor: Get.isDarkMode
                  ? CustomColor.primaryDarkColor
                  : CustomColor.primaryLightColor,
            )),
    );
  }
}
