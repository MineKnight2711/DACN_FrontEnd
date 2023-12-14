import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/screens/homescreen/homescreen.dart';

import 'package:fooddelivery_fe/widgets/custom_widgets/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends GetView {
  final WebViewController webViewController;
  const PaymentWebView({super.key, required this.webViewController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {
          Get.offAll(const HomeScreen(), transition: Transition.fadeIn);
        },
      ),
      body: WebViewWidget(controller: webViewController),
    );
  }
}
