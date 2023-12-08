import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:fooddelivery_fe/config/mediquerry.dart';
import 'package:fooddelivery_fe/controller/order_controller.dart';
import 'package:fooddelivery_fe/screens/order_screen/compinent/order_tabbar_controller.dart';
import 'package:fooddelivery_fe/widgets/custom_appbar.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with TickerProviderStateMixin<OrdersScreen> {
  final tabBarController = Get.put(OrderTabBarController());
  final orderController = Get.find<OrderController>();

  @override
  void initState() {
    super.initState();

    tabBarController.initTabController(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {
          Get.back();
        },
        title: "Lịch sử đơn hàng",
      ),
      body: Column(children: [
        DefaultTabController(
          length: 3,
          child: Column(
            children: [
              TabBar(
                controller: tabBarController.tabController.value,
                tabs: tabBarController.tabs
                    .map(
                      (tab) => Container(
                        decoration: BoxDecoration(),
                        alignment: Alignment.center,
                        height: 35.h,
                        child: Text(
                          tab,
                          style: CustomFonts.customGoogleFonts(fontSize: 14.r),
                        ),
                      ),
                    )
                    .toList(),
                indicatorPadding: EdgeInsets.symmetric(horizontal: 10.w),
                padding: EdgeInsets.all(5.w),
              ),
              SizedBox(
                height: 1.sh - (50.h + 10.w + 35.h + 26),
                child: TabBarView(
                  controller: tabBarController.tabController.value,
                  children: [
                    Container(child: Text("Content of Tab 1")),
                    Container(child: Text("Content of Tab 2")),
                    Container(child: Text("Content of Tab 3")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
