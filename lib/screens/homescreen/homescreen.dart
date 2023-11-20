import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/mediquerry.dart';
import 'package:fooddelivery_fe/controller/category_controller.dart';

import 'package:fooddelivery_fe/model/account_model.dart';
import 'package:fooddelivery_fe/model/category_model.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/bottom_tab_bar/bottom_tabbar.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/bottom_tab_bar/bottom_tabbar_controller.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/homescreen_appbar.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/product_view/product_view.dart';
import 'package:fooddelivery_fe/widgets/round_textfield.dart';

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
        controller: tabBarController.tabController.value,
        children: [
          // Center(child: Text('Home')),
          ProductView(categoryController: categoryController),
          Center(child: Text('Giỏ hàng')),
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
