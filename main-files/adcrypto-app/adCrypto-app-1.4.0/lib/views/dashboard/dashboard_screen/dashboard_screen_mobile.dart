import 'package:adcrypto/backend/utils/custom_loading_api.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../views/tab_screen/tabs/sell_crypto_screen.dart';
import '../../../../widgets/drawer/drawer_widget.dart';
import '../../../backend/language/language_controller.dart';
import '../../../backend/model/buy_crypto/buy_crypto_model.dart';
import '../../../controller/dashboard/buy_crypto/buy_crypto_controller.dart';
import '../../../controller/dashboard/dashboard_controller/dashboard_controller.dart';
import '../../../controller/dashboard/exchange_crypto/exchange_crypto_controller.dart';
import '../../../controller/dashboard/sell_crypto/sell_crypto_controller.dart';
import '../../../controller/dashboard/update_profile/update_profile_controller.dart';
import '../../../controller/dashboard/withdraw_crypto/withdraw_crypto_controller.dart';
import '../../../custom_assets/assets.gen.dart';
import '../../../routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/dashboard/card_widget.dart';
import '../../../widgets/others/app_logo_widget.dart';
import '../../../widgets/others/custom_image_widget.dart';
import '../../tab_screen/tabs/buy_crypto_screen.dart';
import '../../tab_screen/tabs/exchange_crypto_screen.dart';
import '../../tab_screen/tabs/withdraw_crypto_screen.dart';

class DashboardScreenMobile extends StatelessWidget {
  DashboardScreenMobile({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  final controller = Get.put(DashBoardController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: CustomStyle.screenGradientBG,
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          drawer: DrawerWidget(),
          key: scaffoldKey,
          extendBody: true,
          backgroundColor: CustomColor.transparentColor,
          appBar: appBarWidget(context),
          body: Obx(() => Get.find<BuyCryptoController>().isLoading
              ? const CustomLoadingAPI()
              : _bodyWidget(context)),
        ),
      ),
    );
  }

  appBarWidget(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: CustomColor.transparentColor,
      elevation: 0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          scaffoldKey.currentState!.openDrawer();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingHorizontalSize * .6
          ),
          child: CustomImageWidget(
            path: Assets.icon.drawer,
            color: CustomColor.primaryLightColor,
          ),
        ),
      ),
      title: const AppLogoWidget(),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingHorizontalSize * 0.4),
          child: GestureDetector(
            onTap: () {
              Get.toNamed(Routes.updateProfileScreen);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: isTablet()
                      ? Dimensions.paddingSize * .18
                      : Dimensions.paddingSize * .5),
              child: Padding(
                padding: EdgeInsets.only(right: Dimensions.paddingSize * .25),
                child: SvgPicture.asset(
                  Assets.icon.profile,
                  // ignore: deprecated_member_use
                  color: CustomColor.primaryLightColor,
                  height: Dimensions.heightSize * 2,
                  width: Dimensions.widthSize * 3,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // tab bar widget
  _bodyWidget(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return RefreshIndicator(
      backgroundColor: CustomColor.primaryLightColor,
      color: CustomColor.whiteColor,
      onRefresh: () async{
        Get.find<UpdateProfileController>().profileProcess();
        Get.find<BuyCryptoController>().buyCryptoProcess();
        Get.find<SellCryptoController>().sellCryptoProcess();
        Get.find<WithdrawCryptoController>().withdrawCryptoProcess();
        Get.find<ExchangeCryptoController>().exchangeCryptoProcess();
      },
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height,
            width: double.infinity,
            child: Column(
              children: [
                _cardWidget(context),
                isTablet()
                    ? verticalSpace(Dimensions.heightSize)
                    : verticalSpace(Dimensions.heightSize * .5),
                Expanded(
                  flex: 0,
                  child: TabBar(
                    padding:
                        EdgeInsets.only(left: Dimensions.paddingHorizontalSize * .5),
                    labelPadding: EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingHorizontalSize * .3),
                    indicatorPadding: EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingHorizontalSize * .3),
                    isScrollable: true,
                    labelColor: CustomColor.primaryLightColor,
                    indicatorColor: CustomColor.primaryLightColor,
                    unselectedLabelColor: CustomColor.whiteColor.withOpacity(.30),
                    dividerColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 3,
                    tabAlignment: TabAlignment.start,
                    labelStyle: CustomStyle.lightHeading4TextStyle.copyWith(
                        color: CustomColor.primaryLightColor,
                        fontWeight: FontWeight.w600),
                    unselectedLabelStyle: CustomStyle.lightHeading4TextStyle.copyWith(
                        fontSize: Dimensions.headingTextSize4,
                        fontWeight: FontWeight.w600),
                    tabs: [
                      Tab(
                        child: Text(
                          Get.find<LanguageSettingController>().isLoading ? "": Get.find<LanguageSettingController>().getTranslation(Strings.buyCrypto.tr),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Tab(
                        child: Text(
                          Get.find<LanguageSettingController>().isLoading ? "": Get.find<LanguageSettingController>().getTranslation(Strings.sellCrypto.tr),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Tab(
                        child: Text(
                          Get.find<LanguageSettingController>().isLoading ? "": Get.find<LanguageSettingController>().getTranslation(Strings.withdrawCrypto.tr),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Tab(
                        child: Text(
                          Get.find<LanguageSettingController>().isLoading ? "": Get.find<LanguageSettingController>().getTranslation(Strings.exchangeCrypto.tr),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ).paddingZero,
                ),
                isTablet()
                    ? verticalSpace(Dimensions.heightSize)
                    : verticalSpace(Dimensions.heightSize * 1.5),
                _tabBarViewWidget(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _cardWidget(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return SizedBox(
      height: isTablet()
          ? MediaQuery.sizeOf(context).height * .145
          : MediaQuery.sizeOf(context).height * .13,
      child:  ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(
                    Get.find<BuyCryptoController>()
                                .buyCryptoModel
                                .data
                                .currencies
                                .length >
                            3
                        ? 3
                        : Get.find<BuyCryptoController>()
                            .buyCryptoModel
                            .data
                            .currencies
                            .length,
                    (index) {
                      var model =
                          Get.find<BuyCryptoController>().buyCryptoModel.data;
                      Currency data = model.currencies[index];
                      String currencyImage =
                          "${model.currencyImagePaths.baseUrl}/${model.currencyImagePaths.pathLocation}/${data.flag}";
                      String defaultImage =
                          "${model.currencyImagePaths.baseUrl}/${model.currencyImagePaths.defaultImage}";
                      return GestureDetector(
                        onTap: (){
                          controller.viewDetail(data);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              left:
                                  index == 0 ? Dimensions.paddingSize * 0.6 : 0),
                          child: CardWidget(
                            title: data.name,
                            balance: double.parse(data.wallet.first.balance)
                                .toStringAsFixed(6),
                            currency: data.code,
                            cryptoCurrencyNetworkLogo:
                                data.flag.isEmpty ? defaultImage : currencyImage,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: Get.find<BuyCryptoController>()
                          .buyCryptoModel
                          .data
                          .currencies
                          .length >
                      3,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(Dimensions.radius * 1.5),
                    onTap: () {
                      controller.viewMore();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          right: Dimensions.marginSizeHorizontal * 0.3),
                      padding: EdgeInsets.all(Dimensions.paddingSize * 0.8),
                      decoration: ShapeDecoration(
                        color: CustomColor.primaryLightColor.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius * 1.5),
                        ),
                      ),
                      child: const TitleHeading4Widget(
                        text: Strings.viewAll,
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }

  _tabBarViewWidget(BuildContext context) {
    return Expanded(
      child: TabBarView(
        children: [
          BuyCryptoScreen(),
          SellCryptoScreen(),
          WithdrawCryptoScreen(),
          ExchangeCryptoScreen()
        ],
      ),
    );
  }
}
