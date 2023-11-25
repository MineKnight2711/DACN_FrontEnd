import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/controller/cart_controller.dart';
import 'package:fooddelivery_fe/controller/category_controller.dart';

import 'package:fooddelivery_fe/model/account_model.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/bottom_tab_bar/bottom_tabbar.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/bottom_tab_bar/bottom_tabbar_controller.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/cart_view/cart_view.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/homescreen_appbar.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/product_view/product_view.dart';

import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  final AccountModel? accountModel;

  HomeScreen({super.key, this.accountModel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final tabBarController = Get.put(BottomTabBarController());

  final categoryController = Get.find<CategoryController>();
  final cartController = Get.find<CartController>();

  @override
  void initState() {
    super.initState();

    tabBarController.initTabController(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: CustomHomeAppBar(scaffoldKey: scaffoldKey),
      endDrawer:
          CustomHomeAppBar(scaffoldKey: scaffoldKey).buildDrawer(context),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabBarController.tabController.value,
        children: [
          // Center(child: Text('Home')),
          ProductView(categoryController: categoryController),
          CartView(cartController: cartController),
          Center(child: Text('Ưu đãi')),
          Center(child: Text('Settings')),
        ],
      ),
      bottomNavigationBar: BottomNavigationTabBar(
        bottomTabBarController: tabBarController,
      ),
    );
  }
}
