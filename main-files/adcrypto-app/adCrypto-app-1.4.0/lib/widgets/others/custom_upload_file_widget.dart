import 'dart:io';

import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;

import '../../utils/basic_widget_imports.dart';
import '../text_labels/title_heading5_widget.dart';

class CustomUploadFileWidget extends StatefulWidget {
  const CustomUploadFileWidget(
      {super.key,
      required this.labelText,
      required this.onTap,
      this.hint = "",
      this.optional = "",
      this.isFilePicker = true});

  final String labelText, optional, hint;
  final Function onTap;
  final bool isFilePicker;

  @override
  State<CustomUploadFileWidget> createState() => _CustomUploadFileWidgetState();
}

class _CustomUploadFileWidgetState extends State<CustomUploadFileWidget> {
  File? file;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TitleHeading4Widget(
              text: widget.labelText.tr,
              fontWeight: FontWeight.w600,
            ),
            Visibility(
              visible: widget.optional.isNotEmpty,
              child: TitleHeading4Widget(
                text: widget.optional.tr,
                opacity: .4,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        verticalSpace(Dimensions.marginBetweenInputTitleAndBox * 1),
        InkWell(
          onTap: () async {

              _openImageSourceOptionsNew(context);

          },
          child: Container(
            width: double.infinity,
            height: Dimensions.buttonHeight * 1.5,
            alignment: Alignment.center,
            decoration: DottedDecoration(
              shape: Shape.box,
              dash: const [3, 3],
              color: CustomColor.primaryLightColor.withOpacity(.2),
              borderRadius: BorderRadius.circular(Dimensions.radius * .5),
            ),
            child: file == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Animate(
                        effects: const [FadeEffect(), ScaleEffect()],
                        child: Icon(
                          Icons.backup_outlined,
                          size: 30,
                          color:
                              CustomColor.primaryLightTextColor.withOpacity(.2),
                        ),
                      ),
                      verticalSpace(3),
                      TitleHeading3Widget(
                        text: Strings.upload,
                        color:
                            CustomColor.primaryLightTextColor.withOpacity(.2),
                      ),
                    ],
                  )
                : isImage(file!)
                    ? Image.file(
                        file!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                    : Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(getFileNameFromPath(file!),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: CustomColor.primaryLightColor)),
                      ),
          ),
        ),
        verticalSpace(Dimensions.marginBetweenInputTitleAndBox * .7),
        Visibility(
          visible: widget.hint.isNotEmpty,
          child: TitleHeading4Widget(
            text: widget.hint.tr,
            opacity: .4,
            fontWeight: FontWeight.w500,
            fontSize: Dimensions.headingTextSize4 * .8,
          ),
        )
      ],
    );
  }

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
            fromFile: () async{
              Navigator.pop(context);
              FilePickerResult? result = await FilePicker.platform.pickFiles();

              if (result != null) {
                setState(() {
                  file = File(result.files.single.path!);
                  debugPrint("Picked ${file!.path}");
                  // file.
                  widget.onTap(file);
                });
              }
            },
          ),
        );
      },
    );
  }

  takePhoto(ImageSource source) async {
    final pickedImage =
        await imagePicker.pickImage(source: source, imageQuality: 100);

    file = File(pickedImage!.path);
    widget.onTap(file);
    setState(() {});
  }
}

// Function to check if the file is an image
bool isImage(File file) {
  String? mimeType = lookupMimeType(file.path);

  if (mimeType != null && mimeType.split('/').first == 'image') {
    return true;
  }
  return false;
}

String getFileNameFromPath(File file) {
  String fileName = p.basename(file.path);
  return fileName;
}

ImagePicker imagePicker = ImagePicker();

class ImagePickerSheet extends StatelessWidget {
  final VoidCallback fromCamera, fromGallery, fromFile;
  const ImagePickerSheet({
    super.key,
    required this.fromCamera,
    required this.fromGallery, required this.fromFile,
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
            horizontalSpace(Dimensions.widthSize * 4),
            InkWell(
              onTap: fromFile,
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
                          Icons.file_open,
                          color: CustomColor.primaryLightColor,
                          size: Dimensions.iconSizeLarge,
                        ),
                      ),
                      TitleHeading5Widget(
                        text: Strings.fromFile,
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



/// make dynamic letter
bool containsImage(String text) {
  // Regular expression to match common image file extensions
  RegExp imageRegex = RegExp(r'\.(?:jpg|jpeg|png|gif|bmp|svg|webp)$', caseSensitive: false);

  // Regular expressions to match file extensions that are not images
  RegExp nonImageRegex = RegExp(r'\.(?:zip|pdf)$', caseSensitive: false);

  // Check if the text contains an image extension
  bool containsImage = imageRegex.hasMatch(text);

  // Check if the text contains a non-image extension
  bool containsNonImage = nonImageRegex.hasMatch(text);

  // Return true if the text contains an image extension and no non-image extension
  return containsImage && !containsNonImage;
}