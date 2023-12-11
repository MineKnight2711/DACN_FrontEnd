import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RatingOrderTabbarController extends GetxController {
  final tabs = <String>[].obs;
  Rx<TabController?> tabController = Rx<TabController?>(null);
  late TickerProvider _tickerProvider;
  double tabSpacing(double screenWidth) {
    double maxSpacingWidth = screenWidth / tabs.length;

    return maxSpacingWidth / (tabs.length - 1);
  }

  void initTabController(TickerProvider tickerProvider) {
    _tickerProvider = tickerProvider;
    tabController.value = TabController(
      length: tabs.length,
      vsync: _tickerProvider,
    );
  }

  @override
  void onInit() {
    tabs.value = [
      "Chưa đánh giá",
      "Đã đánh giá",
    ];
    super.onInit();
  }
}
