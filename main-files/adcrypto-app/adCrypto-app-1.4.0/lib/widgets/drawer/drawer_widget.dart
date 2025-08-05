import 'package:adcrypto/backend/utils/custom_loading_api.dart';
import 'package:flutter_svg/svg.dart';

import '../../controller/basic_settings_controller.dart';
import '../../controller/dashboard/dashboard_controller/dashboard_controller.dart';
import '../../controller/dashboard/update_profile/update_profile_controller.dart';
import '../../custom_assets/assets.gen.dart';
import '../../routes/routes.dart';
import '../../utils/basic_widget_imports.dart';
import '../../views/dynamic_web_screen/dynamic_web_screen.dart';
import '../dialog_helper.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});
  final controller = Get.put(DashBoardController());

  @override
  Widget build(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return Drawer(
      width: isTablet()
          ? MediaQuery.of(context).size.width * .6
          : MediaQuery.of(context).size.width * .7,
      child: Container(
        decoration: BoxDecoration(
          color: Get.isDarkMode
              ? CustomColor.blackColor
              : CustomColor.gradientColorTop,
        ),
        child: _allItemListView(context),
      ),
    );
  }

  buildMenuItem(
    BuildContext context, {
    required String title,
    required String imagePath,
    required VoidCallback onTap,
    double scaleImage = 1,
  }) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSize * .25,
          ),
          child: ListTile(
            dense: true,
            leading: Container(
              padding: EdgeInsets.all(Dimensions.paddingSize * .25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  Dimensions.radius * .5,
                ),
                color: CustomColor.primaryLightColor.withOpacity(.15),
              ),
              child: SvgPicture.asset(
                imagePath,
                // ignore: deprecated_member_use
                color: CustomColor.primaryLightColor,
                height: Dimensions.heightSize * 1.5,
                width: Dimensions.widthSize * 1.5,
              ),
            ),
            title: TitleHeading4Widget(
              text: title,
              fontWeight: FontWeight.w700,
            ),
            onTap: (){
              Get.close(1);
              onTap();
            },
          ),
        ),
      ],
    );
  }

  _drawerItems(BuildContext context) {
    return Column(
      children: [
        buildMenuItem(
          context,
          imagePath: Assets.icon.notification,
          title: Strings.notification,
          onTap: () {
            Get.toNamed(Routes.notificationScreen);
          },
        ),
        buildMenuItem(
          context,
          imagePath: Assets.icon.buyLog,
          title: Strings.buyLog,
          onTap: () {
            Get.toNamed(Routes.buyLogScreen);
          },
        ),
        buildMenuItem(
          context,
          imagePath: Assets.icon.sellLog,
          title: Strings.sellLog,
          onTap: () {
            Get.toNamed(Routes.sellLogScreen);
          },
        ),
        buildMenuItem(
          context,
          imagePath: Assets.icon.withdrawLog,
          title: Strings.withdrawLog,
          onTap: () {
            Get.toNamed(Routes.withdrawLogScreen);
          },
        ),
        buildMenuItem(
          context,
          imagePath: Assets.icon.exchangeLog,
          title: Strings.exchangeLog,
          onTap: () {
            Get.toNamed(Routes.exchangeLogScreen);
          },
        ),
        buildMenuItem(
          context,
          imagePath: Assets.icon.settings,
          title: Strings.settings,
          onTap: () {
            Get.toNamed(Routes.settingsScreen);
          },
        ),
        buildMenuItem(
          context,
          imagePath: Assets.icon.helpCenter,
          title: Strings.helpCenter,
          onTap: () {

            Get.to(WebViewScreen(
              link: Get.find<BasicSettingsController>().basicSettingsModel.data.contactPageLink,
              appTitle: Strings.helpCenter,
            ));
          },
        ),
        buildMenuItem(
          context,
          imagePath: Assets.icon.privacyAndPolicy,
          title: Strings.privacyAndPolicy,
          onTap: () {
            Get.to(WebViewScreen(
              link: Get.find<BasicSettingsController>().basicSettingsModel.data.privacyPolicyLink,
              appTitle: Strings.privacyAndPolicy,
            ));
          },
        ),
        buildMenuItem(
          context,
          imagePath: Assets.icon.aboutUs,
          title: Strings.aboutUs,
          onTap: () {
            Get.to(WebViewScreen(
              link: Get.find<BasicSettingsController>().basicSettingsModel.data.aboutPageLink,
              appTitle: Strings.aboutUs,
            ));
          },
        ),
        Obx(
          () => controller.isLoading
              ? const CustomLoadingAPI()
              : buildMenuItem(
                  context,
                  imagePath: Assets.icon.signOut,
                  title: Strings.signOut,
                  onTap: () {
                    DialogHelper.show(
                        context: context,
                        title: Strings.signOut.tr,
                        subTitle: Strings.signOutMessage.tr,
                        actionText: Strings.signOut.tr,
                        action: () {
                          Get.close(1);
                          controller.logOutProcess();
                        });
                  },
                ),
        )
      ],
    );
  }

  _allItemListView(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        ClipRect(
          child: Opacity(
            opacity: .4,
            child: Align(
              alignment: Alignment.centerLeft,
              widthFactor: 0.7, // Adjust this value to control the visible width
              child: Image.asset(
                Assets.logo.basicIcon.path,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        ListView(
          padding: EdgeInsets.only(
            left: Dimensions.paddingSize * .3,
          ),
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: Dimensions.heightSize * 1.5,
            ),
            IconButton(
              iconSize: isTablet()
                  ? Dimensions.widthSize * 1.5
                  : Dimensions.widthSize * 2,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: CustomColor.primaryLightColor,
              ),
              alignment: Alignment.topLeft,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _userImage(context),
                SizedBox(
                  height: Dimensions.heightSize,
                ),
                TitleHeading2Widget(
                    text: Get.find<UpdateProfileController>().isLoading
                        ? ""
                        : "${Get.find<UpdateProfileController>().firstNameController.text} ${Get.find<UpdateProfileController>().lastNameController.text}"),
                SizedBox(
                  height: Dimensions.heightSize * 0.2,
                ),
                TitleHeading4Widget(
                  text: Get.find<UpdateProfileController>().isLoading
                      ? ""
                      : Get.find<UpdateProfileController>()
                          .profileModel
                          .data
                          .userInfo
                          .email,
                  opacity: 0.5,
                ),
                SizedBox(
                  height: Dimensions.heightSize,
                ),
              ],
            ),
            _drawerItems(context),
          ],
        ),
      ],
    );
  }

  _userImage(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return Container(
      width: isTablet()
          ? MediaQuery.of(context).size.width * 0.20
          : MediaQuery.of(context).size.width * 0.25,
      height: MediaQuery.of(context).size.height * 0.12,
      decoration: BoxDecoration(
          border: Border.all(
            color: CustomColor.primaryLightColor,
            width: isTablet()
                ? Dimensions.widthSize * .25
                : Dimensions.widthSize * .4,
          ),
          borderRadius: BorderRadius.circular(Dimensions.radius * 1.5),
          color: CustomColor.transparentColor
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimensions.radius * 1.2),
        child: Center(
          child: Obx(() => Get.find<UpdateProfileController>().isLoading
              ? const CustomLoadingAPI()
              : FadeInImage(
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      Get.find<UpdateProfileController>().image.value),
                  placeholder: AssetImage(Assets.clipart.sampleProfile.path),
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(Assets.clipart.sampleProfile.path,
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover);
                  },
                )),
        ),
      ),
    );
  }
}
