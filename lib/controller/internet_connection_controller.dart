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
            Logger().i("Times connected : ${timesConnectedDisconnected.value}");
            print('Data connection is available.');
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
            Logger().i("Times connected : ${timesConnectedDisconnected.value}");
            print('You are disconnected from the internet.');
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

  // Future<bool> execute(
  //   InternetConnectionChecker internetConnectionChecker,
  // ) async {
  //   // Simple check to see if we have Internet
  //   // ignore: avoid_print
  //   print('''The statement 'this machine is connected to the Internet' is: ''');
  //   final bool isConnected = await InternetConnectionChecker().hasConnection;
  //   print(
  //     'Current status: ${await InternetConnectionChecker().connectionStatus}',
  //   );
  //   final StreamSubscription<InternetConnectionStatus> listener =

  //   );

  //   await Future<void>.delayed(const Duration(seconds: 30));
  //   await listener.cancel();
  //   return isConnected;
  // }
}
