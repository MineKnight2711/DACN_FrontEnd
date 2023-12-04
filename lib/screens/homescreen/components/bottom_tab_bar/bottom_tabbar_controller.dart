import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/controller/cart_controller.dart';
import 'package:get/get.dart';

class TabModel {
  final String tag;
  final String name;
  final String imagePath;

  TabModel({required this.tag, required this.name, required this.imagePath});
}

class BottomTabBarController extends GetxController {
  final tabs = <TabModel>[].obs;
  Rx<TabController?> tabController = Rx<TabController?>(null);
  late TickerProvider _tickerProvider;
  late CartController cartController;
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
      TabModel(tag: "Home", name: 'Home', imagePath: 'assets/images/home.png'),
      TabModel(
          tag: "Cart", name: 'Giỏ hàng', imagePath: 'assets/images/cart.png'),
      TabModel(
          tag: "Discount",
          name: 'Ưu đãi',
          imagePath: 'assets/images/voucher.png'),
      TabModel(
          tag: "More", name: 'Nhiều hơn', imagePath: 'assets/images/menu.png'),
    ];
    cartController = Get.find<CartController>();
    super.onInit();
  }
}
