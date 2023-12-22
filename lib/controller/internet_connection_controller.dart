// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';

class InternetConnectionController extends GetxController {
  RxInt timesConnectedDisconnected = 0.obs;

  StreamSubscription<InternetConnectionStatus> listenToInternetChange(
      BuildContext context, Function()? onReconnect) {
    return InternetConnectionChecker().onStatusChange.listen(
      (status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            timesConnectedDisconnected.value++;
            if (timesConnectedDisconnected.value > 1) {
              CustomSnackBar.showCustomSnackBar(
                context,
                "Đã có kết nối trở lại",
                duration: 2,
                type: FlushbarType.internetConnected,
                isShowOnTop: true,
              );
              onReconnect;
            }
            break;
          case InternetConnectionStatus.disconnected:
            timesConnectedDisconnected.value++;
            CustomSnackBar.showCustomSnackBar(
              context,
              "Bạn đang offline",
              duration: 2,
              type: FlushbarType.noInternet,
              isShowOnTop: true,
            );
            break;
        }
      },
    );
  }
}
