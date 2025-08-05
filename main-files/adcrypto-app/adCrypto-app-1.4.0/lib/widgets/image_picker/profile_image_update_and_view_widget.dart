import 'dart:io';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/dashboard/update_profile/update_profile_controller.dart';
import '../../custom_assets/assets.gen.dart';
import '../../utils/basic_screen_imports.dart';
import '../others/custom_image_widget.dart';
import '../text_labels/title_heading5_widget.dart';

class ProfileImageUpdateAndViewWidget extends StatefulWidget {
  const ProfileImageUpdateAndViewWidget({super.key, this.heightSize = 12.0});

  final double heightSize;

  @override
  State<ProfileImageUpdateAndViewWidget> createState() =>
      _ProfileImageUpdateAndViewWidgetState();
}

class _ProfileImageUpdateAndViewWidgetState
    extends State<ProfileImageUpdateAndViewWidget> {
  @override
  Widget build(BuildContext context) {
    return _imageWidget();
  }

  _imageWidget() {
    return Obx(() => Get.find<UpdateProfileController>().isLoading
        ? const SizedBox.shrink()
        : Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.height * 0.21,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: pickedFile == null
                          ? NetworkImage(
                              Get.find<UpdateProfileController>().image.value,
                            )
                          : FileImage(pickedFile!) as ImageProvider,
                      fit: BoxFit.cover),
                  color: CustomColor.primaryLightColor.withOpacity(.76),
                  borderRadius: BorderRadius.circular(Dimensions.radius * 2),
                  border: Border.all(
                    color: CustomColor.primaryLightColor,
                    width: 4,
                  ),
                ),
              ),
              Positioned(
                child: SizedBox(
                  height: Dimensions.heightSize * 2,
                  width: Dimensions.widthSize * 2,
                  child: InkWell(
                      onTap: () {
                        _openImageSourceOptionsNew(context);
                      },
                      child: CustomImageWidget(path: Assets.icon.camera)),
                ),
              )
            ],
          ));
  }

  // _openImageSourceOptions(BuildContext context) {
  //   return showGeneralDialog(
  //     context: context,
  //     pageBuilder: (ctx, a1, a2) {
  //       return const Icon(
  //         Icons.close,
  //         color: Colors.red,
  //       );
  //     },
  //     transitionBuilder: (ctx, a1, a2, child) {
  //       var curve = Curves.easeInOut.transform(a1.value);
  //       return Transform.scale(
  //         scale: curve,
  //         child: AlertDialog(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(Dimensions.radius * 2),
  //           ),
  //           content: SizedBox(
  //             width: 270,
  //             height: MediaQuery.of(context).size.height * 0.15,
  //             child: Stack(
  //               children: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Padding(
  //                       padding: EdgeInsets.all(Dimensions.paddingSize),
  //                       child: IconButton(
  //                           onPressed: () {
  //                             takePhoto(ImageSource.gallery);
  //                             Navigator.pop(context);
  //                           },
  //                           icon: const Icon(
  //                             Icons.image,
  //                             color: CustomColor.primaryLightColor,
  //                             size: 50,
  //                           )),
  //                     ),
  //                     Padding(
  //                       padding: EdgeInsets.all(Dimensions.paddingSize),
  //                       child: IconButton(
  //                           onPressed: () {
  //                             takePhoto(ImageSource.camera);
  //                             Navigator.pop(context);
  //                           },
  //                           icon: const Icon(
  //                             Icons.camera,
  //                             color: CustomColor.primaryLightColor,
  //                             size: 50,
  //                           )),
  //                     ),
  //                   ],
  //                 ),
  //                 Positioned(
  //                   top: -12,
  //                   right: -15,
  //                   child: IconButton(
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                     },
  //                     icon: const Icon(
  //                       Icons.close,
  //                       color: Colors.red,
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //     transitionDuration: const Duration(milliseconds: 400),
  //   );
  // }


  _openImageSourceOptionsNew(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: double.infinity,
          child: ImagePickerSheet(
            fromCamera: () {
              Navigator.pop(context);
              takePhoto(ImageSource.camera);
            },
            fromGallery: () {
              Navigator.pop(context);
              takePhoto(ImageSource.gallery);
            },
          ),
        );
      },
    );
  }

  takePhoto(ImageSource source) async {
    final pickedImage =
        await imagePicker.pickImage(source: source, imageQuality: 100);

    pickedFile = File(pickedImage!.path);
    Get.find<UpdateProfileController>().imagePath.value = pickedImage.path;
    setState(() {});
  }
}

File? pickedFile;
ImagePicker imagePicker = ImagePicker();

class ImagePickerSheet extends StatelessWidget {
  final VoidCallback fromCamera, fromGallery;
  const ImagePickerSheet({
    super.key,
    required this.fromCamera,
    required this.fromGallery,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: mainMin,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: mainMin,
          children: [
            InkWell(
              onTap: fromGallery,
              child: Animate(
                effects: const [FadeEffect(), ScaleEffect()],
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.marginSizeHorizontal * 0.5,
                    vertical: Dimensions.marginSizeVertical * 0.5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(Dimensions.radius * 1.4),
                    color: CustomColor.whiteColor,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.image,
                          color: CustomColor.primaryLightColor,
                          size: Dimensions.iconSizeLarge,
                        ),
                      ),
                      TitleHeading5Widget(
                        text: Strings.fromGallery,
                        color: CustomColor.primaryLightColor,
                        fontSize: Dimensions.headingTextSize6,
                      )
                    ],
                  ),
                ),
              ),
            ),
            horizontalSpace(Dimensions.widthSize * 4),
            InkWell(
              onTap: fromCamera,
              child: Animate(
                effects: const [FadeEffect(), ScaleEffect()],
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.marginSizeHorizontal * 0.5,
                      vertical: Dimensions.marginSizeVertical * 0.5),
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(Dimensions.radius * 1.4),
                    color: CustomColor.whiteColor,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.camera_alt,
                          color: CustomColor.primaryLightColor,
                          size: Dimensions.iconSizeLarge,
                        ),
                      ),
                      TitleHeading5Widget(
                        text: Strings.fromCamera,
                        color: CustomColor.primaryLightColor,
                        fontSize: Dimensions.headingTextSize6,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ).paddingSymmetric(vertical: Dimensions.marginSizeVertical * 1.2),
      ],
    );
  }
}