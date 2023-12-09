import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderTabBarController extends GetxController {
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

  // void _onTabChanged(List<String> tabs) {
  //   int newLength = tabs.length;
  //   if (tabController.value != null) {
  //     int index = tabController.value!.index;

  //     // Access passed in tabs parameter
  //     print(tabs[index]);
  //   }
  //   if (newLength != tabController.value?.length) {
  //     initTabController(_tickerProvider);
  //   }
  // }

  @override
  void onInit() {
    tabs.value = [
      "Chờ thanh toán",
      "Đang thực hiện",
      "Đã hoàn tất",
      "Đã huỷ",
    ];
    super.onInit();
  }
}
