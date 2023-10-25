import 'package:flutter/material.dart';

class MediaQuerry {
  static double mediaWidth(BuildContext context, double? customSize) {
    final givenSize = customSize ?? 1.0;
    return MediaQuery.of(context).size.width / givenSize;
  }

  static double mediaHeight(BuildContext context, double? customSize) {
    final givenSize = customSize ?? 1.0;
    return MediaQuery.of(context).size.height / givenSize;
  }

  static double mediaAspectRatio(BuildContext context, double? customSize) {
    final givenSize = customSize ?? 1.0;
    return MediaQuery.of(context).size.aspectRatio / givenSize;
  }

  static bool screenRotate(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.portrait) {
      return true;
    } else {
      return false;
    }
  }
}
