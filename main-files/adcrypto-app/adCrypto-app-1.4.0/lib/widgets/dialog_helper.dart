
import '../backend/language/language_controller.dart';
import '../utils/basic_screen_imports.dart';

class DialogHelper{
  static show({
    required BuildContext context,
    required String title,
    required String subTitle,
    required String actionText,
    required VoidCallback action
}){

    bool isBigText = Get.find<LanguageSettingController>()
        .getTranslation(actionText)
        .length >
        8;
    bool isBigText2 = Get.find<LanguageSettingController>()
        .getTranslation(Strings.cancel)
        .length >
        8;

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            alignment: Alignment.center,
            insetPadding: EdgeInsets.all(Dimensions.paddingSize * 0.3),
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Builder(
              builder: (context) {
                var width = MediaQuery.of(context).size.width;
                return Container(
                  width: width * 0.84,
                  margin: EdgeInsets.all(Dimensions.paddingSize * 0.5),
                  padding: EdgeInsets.all(Dimensions.paddingSize * 0.9),
                  decoration: BoxDecoration(
                    color: CustomColor.whiteColor,
                    borderRadius:
                    BorderRadius.circular(Dimensions.radius * 1.4),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: crossCenter,
                    children: [
                      SizedBox(height: Dimensions.heightSize * 2),
                      TitleHeading2Widget(text: title, color: CustomColor.primaryDarkScaffoldBackgroundColor),
                      verticalSpace(Dimensions.heightSize * 1),
                      TitleHeading4Widget(text: subTitle, color: CustomColor.primaryDarkScaffoldBackgroundColor.withOpacity(.8)),
                      verticalSpace(Dimensions.heightSize * 1),
                      if (isBigText || isBigText2) ...[
                        PrimaryButton(
                          title: Strings.cancel.tr,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          borderColor: CustomColor.primaryDarkScaffoldBackgroundColor.withOpacity(.7),
                          buttonColor: CustomColor.primaryDarkScaffoldBackgroundColor.withOpacity(.7),
                        ),
                        verticalSpace(Dimensions.heightSize),
                        PrimaryButton(
                          title: actionText,
                          onPressed: action,
                          borderColor: CustomColor.redColor,
                          buttonColor: CustomColor.redColor,
                        )
                      ]
                      else ... [
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * .25,
                                child: PrimaryButton(
                                  title: Strings.cancel.tr,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  borderColor: CustomColor.primaryDarkScaffoldBackgroundColor.withOpacity(.7),
                                  buttonColor: CustomColor.primaryDarkScaffoldBackgroundColor.withOpacity(.7),
                                ),
                              ),
                            ),
                            horizontalSpace(Dimensions.widthSize),
                            Expanded(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * .25,
                                child: PrimaryButton(
                                  title: actionText,
                                  onPressed: action,
                                  borderColor: CustomColor.redColor,
                                  buttonColor: CustomColor.redColor,
                                ),
                              ),
                            ),
                          ],
                        )
                      ]
                    ],
                  ),
                );
              },
            ),
          );
        });
  }
}