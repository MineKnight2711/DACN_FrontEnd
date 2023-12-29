import 'package:easy_localization/easy_localization.dart';
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
    createConstantTabs();
  }

  void _onTabChanged(List<TabModel>? tabs) {
    int newLength = tabs?.length ?? 0;
    if (newLength != tabController.value?.length) {
      initTabController(_tickerProvider);
    }
  }

  void createConstantTabs() {
    tabs.value = [
      TabModel(
          tag: "Home",
          name: tr("home.bottom_navigation_bar.home"),
          imagePath: 'assets/images/home_64.png'),
      TabModel(
          tag: "Cart",
          name: tr("home.bottom_navigation_bar.cart"),
          imagePath: 'assets/images/cart_64.png'),
      TabModel(
          tag: "Discount",
          name: tr("home.bottom_navigation_bar.discount"),
          imagePath: 'assets/images/discount_64.png'),
      TabModel(
          tag: "More",
          name: tr("home.bottom_navigation_bar.more"),
          imagePath: 'assets/images/menu_64.png'),
    ];
  }

  @override
  void onInit() {
    cartController = Get.find<CartController>();
    super.onInit();
  }
}
