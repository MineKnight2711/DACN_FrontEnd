import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabModel {
  final String name;
  final String imagePath;

  TabModel({required this.name, required this.imagePath});
}

class BottomTabBarController extends GetxController {
  final tabs = <TabModel>[].obs;
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

  void _onTabChanged(List<TabModel>? tabs) {
    int newLength = tabs?.length ?? 0;
    if (newLength != tabController.value?.length) {
      initTabController(_tickerProvider);
    }
  }

  @override
  void onInit() {
    tabs.value = [
      TabModel(name: 'Home', imagePath: 'assets/images/home.png'),
      TabModel(name: 'Giỏ hàng', imagePath: 'assets/images/cart.png'),
      TabModel(name: 'Ưu đãi', imagePath: 'assets/images/voucher.png'),
      TabModel(name: 'Nhiều hơn', imagePath: 'assets/images/menu.png'),
    ];

    super.onInit();
  }
}
