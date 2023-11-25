import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/config/mediquerry.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/bottom_tab_bar/bottom_tabbar_controller.dart';
import 'package:get/get.dart';

class BottomNavigationTabBar extends StatelessWidget {
  final BottomTabBarController bottomTabBarController;
  const BottomNavigationTabBar(
      {super.key, required this.bottomTabBarController});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TabBar(
        physics: const NeverScrollableScrollPhysics(),
        tabs: bottomTabBarController.tabs
            .map((tab) => SizedBox(
                width: CustomMediaQuerry.mediaWidth(context, 4.5),
                height: CustomMediaQuerry.mediaHeight(context, 12),
                child: Tab(icon: Image.asset(tab.imagePath), text: tab.name)))
            .toList(),
        labelStyle: const TextStyle(fontSize: 16.0),
        unselectedLabelStyle: const TextStyle(fontSize: 14.0),
        labelColor: Colors.black87,
        unselectedLabelColor: const Color.fromRGBO(0, 0, 0, 0.5),
        isScrollable: true,
        controller: bottomTabBarController.tabController.value,
        indicatorPadding: EdgeInsets.symmetric(
            horizontal: CustomMediaQuerry.mediaWidth(context, 80)),
        labelPadding: EdgeInsets.symmetric(
            horizontal: CustomMediaQuerry.mediaWidth(context, 80)),
      ),
    );
  }
}
