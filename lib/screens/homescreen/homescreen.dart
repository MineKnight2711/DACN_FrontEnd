import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/controller/account_controller.dart';
import 'package:fooddelivery_fe/controller/account_voucher_controller.dart';
import 'package:fooddelivery_fe/controller/cart_controller.dart';
import 'package:fooddelivery_fe/controller/category_controller.dart';
import 'package:fooddelivery_fe/controller/dish_controller.dart';
import 'package:fooddelivery_fe/controller/internet_connection_controller.dart';
import 'package:fooddelivery_fe/model/account_model.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/bottom_tab_bar/bottom_tabbar.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/bottom_tab_bar/bottom_tabbar_controller.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/cart_view/cart_view.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/homescreen_appbar.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/product_view/product_view.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/settings_view/components/utilities_list.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/settings_view/setting_view.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/voucher_view/voucher_view.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class HomeScreen extends StatefulWidget {
  final AccountModel? accountModel;
  const HomeScreen({super.key, this.accountModel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _internetConnectionController = Get.put(InternetConnectionController());
  final tabBarController = Get.find<BottomTabBarController>();
  final accountController = Get.find<AccountController>();
  final categoryController = Get.find<CategoryController>();
  final dishController = Get.find<DishController>();
  final cartController = Get.find<CartController>();
  final accountVoucherController = Get.find<AccountVoucherController>();
  late StreamSubscription<InternetConnectionStatus> internetSub;
  @override
  void initState() {
    super.initState();
    internetSub =
        _internetConnectionController.listenToInternetChange(context, refresh);
    UltilitiesList.initUtilitiesList();
    tabBarController.initTabController(this);
  }

  @override
  void dispose() {
    internetSub.cancel();
    super.dispose();
  }

  Future<void> refresh() async {
    await categoryController.getAllCategory();
    await dishController.getAllDish();
    await cartController.getAccountCart();
  }

  Future<void> cartRefresh() async {
    await cartController.getAccountCart();
  }

  Future<void> voucherRefresh() async {
    await accountVoucherController.getAllAccountVouchers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHomeAppBar(),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabBarController.tabController.value,
        children: [
          RefreshIndicator(
            onRefresh: () => refresh(),
            displacement: 40.0,
            child: ProductView(categoryController: categoryController),
          ),
          RefreshIndicator(
            onRefresh: () => cartRefresh(),
            displacement: 40.0,
            child: CartView(cartController: cartController),
          ),
          RefreshIndicator(
            onRefresh: () => voucherRefresh(),
            child: Container(
              color: AppColors.white100,
              child: VoucherView(
                accountVoucherController: accountVoucherController,
              ),
            ),
          ),
          SettingsView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationTabBar(
        bottomTabBarController: tabBarController,
      ),
    );
  }
}
