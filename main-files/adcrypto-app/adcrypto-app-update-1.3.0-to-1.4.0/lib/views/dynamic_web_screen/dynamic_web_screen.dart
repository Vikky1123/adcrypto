import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:adcrypto/local_storage/local_storage.dart' as local;

import '../../../backend/utils/custom_loading_api.dart';
import '../../../routes/routes.dart';
import '../../../utils/custom_color.dart';
import '../../utils/custom_style.dart';
import '../../widgets/others/custom_back_button.dart';
import '../../widgets/text_labels/title_heading2_widget.dart';

class WebViewScreen extends StatefulWidget {
  final String link, appTitle;
  final Function? onFinished;

  const WebViewScreen(
      {super.key, required this.link, required this.appTitle, this.onFinished});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: CustomStyle.screenGradientBG,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: CustomColor.transparentColor,
            leading: CustomBackButton(
              onTap: () => Navigator.pop(context),
            ),
            centerTitle: true,
            title: TitleHeading2Widget(
              text: widget.appTitle,
              fontWeight: FontWeight.w600,
            ),
            actions: [
              local.LocalStorage.isLoggedIn()
                  ? IconButton(
                      onPressed: () {
                        Get.offAllNamed(Routes.dashboardScreen);
                      },
                      icon: Icon(
                        Icons.home,
                        color: Get.isDarkMode
                            ? CustomColor.blackColor
                            : CustomColor.whiteColor,
                      ))
                  : const SizedBox.shrink()
            ],
          ),
          body: Stack(
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri(widget.link)),
                onWebViewCreated: (InAppWebViewController controller) {},
                onLoadStart: (InAppWebViewController controller, Uri? url) {
                  widget.onFinished!(url);
                  setState(() {
                    isLoading = true;
                  });
                },
                onLoadStop: (InAppWebViewController controller, Uri? url) {
                  isLoading = false;
                  setState(() {});
                },
              ),
              Visibility(visible: isLoading, child: const CustomLoadingAPI())
            ],
          )),
    );
  }
}
