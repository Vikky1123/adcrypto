// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';

import '../../custom_assets/assets.gen.dart';
import '../../utils/basic_screen_imports.dart';
import '../others/custom_image_widget.dart';

class SSImageUploadWidget extends StatefulWidget {
  SSImageUploadWidget({super.key, this.image, required this.title});

  File? image;
  String title;

  @override
  State<SSImageUploadWidget> createState() => _SSImageUploadWidgetState();
}

class _SSImageUploadWidgetState extends State<SSImageUploadWidget> {
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: const [3, 3],
      radius: Radius.circular(Dimensions.radius),
      color: CustomColor.primaryLightTextColor.withOpacity(0.15),
      strokeWidth: 2,
      child: InkWell(
        onTap: (() {
          openImageSourceOptions(context);
        }),
        child: widget.image == null
            ? Container(
                height: MediaQuery.sizeOf(context).height * .1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: mainCenter,
                  children: [
                    CustomImageWidget(
                      path: Assets.icon.documentUpload,
                      height: Dimensions.heightSize*2,
                      width: Dimensions.widthSize,
                    ),
                    TitleHeading3Widget(
                      text: Strings.uploadImage.tr,
                      color: CustomColor.primaryLightTextColor.withOpacity(0.2),
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              )
            : Container(
                height: MediaQuery.sizeOf(context).height * .11,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                  image: DecorationImage(
                      image: FileImage(widget.image!), fit: BoxFit.cover),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: mainCenter,
                  children: [
                    CustomImageWidget(
                      path: Assets.icon.documentUpload,
                      height: Dimensions.heightSize*2,
                      width: Dimensions.widthSize,
                    ),
                    TitleHeading3Widget(
                      text: Strings.uploadImage.tr,
                      color: CustomColor.primaryLightTextColor.withOpacity(0.2),
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  final picker = ImagePicker();

  Future chooseFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      widget.image = File(pickedFile.path);
      setState(() {});
    } else {}
  }

  Future chooseFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      widget.image = File(pickedFile.path);
      setState(() {});
    } else {}
  }

  openImageSourceOptions(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return const Icon(
          Icons.close,
          color: Colors.red,
        );
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius * 2),
            ),
            content: SizedBox(
              width: 270,
              height: MediaQuery.of(context).size.height * 0.15,
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(isTablet()
                            ? Dimensions.paddingSize * .5
                            : Dimensions.paddingSize),
                        child: IconButton(
                            onPressed: () {
                              chooseFromGallery();
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.image,
                              color: CustomColor.primaryLightColor,
                              size: 50,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Dimensions.paddingSize),
                        child: IconButton(
                            onPressed: () {
                              chooseFromCamera();
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.camera,
                              color: CustomColor.primaryLightColor,
                              size: 50,
                            )),
                      ),
                    ],
                  ),
                  Positioned(
                    top: -12,
                    right: -15,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }
}