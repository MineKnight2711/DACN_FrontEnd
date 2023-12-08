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
    tabs.stream.listen(_onTabChanged);
  }

  void _onTabChanged(List<String>? tabs) {
    int newLength = tabs?.length ?? 0;
    if (newLength != tabController.value?.length) {
      initTabController(_tickerProvider);
    }
  }

  @override
  void onInit() {
    tabs.value = [
      "Đang thực hiện",
      "Đã hoàn tất",
      "Đã huỷ",
    ];
    super.onInit();
  }
}
