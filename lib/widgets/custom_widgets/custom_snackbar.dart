import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'package:fooddelivery_fe/config/colors.dart';

class CustomSnackBar {
  static void showCustomSnackBar(BuildContext context, String message,
      {int? duration, FlushbarType? type, bool? isShowOnTop}) {
    Flushbar(
      flushbarPosition: isShowOnTop != null
          ? (isShowOnTop ? FlushbarPosition.TOP : FlushbarPosition.BOTTOM)
          : FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      message: message,
      icon: type?.iconData != null
          ? Icon(
              type?.iconData,
              color: AppColors.white100,
            )
          : null,
      duration: Duration(seconds: duration ?? 2),
      leftBarIndicatorColor: AppColors.orange100,
      backgroundGradient: type?.colorGradient ??
          LinearGradient(colors: [
            Colors.blue[800] ?? Colors.blue, // Use Colors.green as a fallback
            Colors.blue[600] ?? Colors.blue,
            Colors.blue[300] ?? Colors.blue
          ]),
    ).show(context);
  }
}

class FlushbarType {
  final String message;
  final IconData iconData;
  final LinearGradient colorGradient;

  FlushbarType(
    this.message,
    this.iconData,
    this.colorGradient,
  );

  static FlushbarType internetConnected = FlushbarType(
    'internetConnected',
    Icons.wifi,
    LinearGradient(colors: [
      Colors.green[800] ?? Colors.green, // Use Colors.green as a fallback
      Colors.green[600] ?? Colors.green,
      Colors.green[300] ?? Colors.green
    ]),
  );
  static FlushbarType noInternet = FlushbarType(
    'noInternet',
    Icons.wifi_off,
    LinearGradient(colors: [
      Colors.red[800] ?? Colors.red, // Use Colors.green as a fallback
      Colors.red[600] ?? Colors.red,
      Colors.red[300] ?? Colors.red
    ]),
  );
}
