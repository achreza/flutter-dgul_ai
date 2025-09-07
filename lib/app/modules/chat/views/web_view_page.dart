import 'package:dgul_ai/app/modules/chat/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends GetView<ChatController> {
  final String url;

  WebViewPage({required this.url});

  @override
  Widget build(BuildContext context) {
    final webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) async {},
          onHttpError: (HttpResponseError error) {
            // Handle HTTP error
          },
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(
        Uri.parse(url),
      );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            if (await webController.canGoBack()) {
              webController.goBack();
            } else {
              Get.back();
              controller.refreshSubscriptionProfile();
            }
          },
        ),
      ),
      body: WebViewWidget(
        controller: webController,
      ),
    );
  }
}
