import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:fooddelivery_fe/controller/order_controller.dart';
import 'package:fooddelivery_fe/screens/order_screen/components/order_item.dart';
import 'package:fooddelivery_fe/screens/order_screen/components/order_tabbar_controller.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/custom_appbar.dart';
import 'package:fooddelivery_fe/widgets/empty_widget.dart';
import 'package:fooddelivery_fe/widgets/no_glowing_scrollview.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
    onChangedtabListener();
  }

  void onChangedtabListener() {
    if (tabBarController.tabController.value != null) {
      tabBarController.tabController.value!.addListener(() {
        if (!tabBarController.tabController.value!.indexIsChanging) {
          int index = tabBarController.tabController.value!.index;

          orderController.getOrderByStatus(tabBarController.tabs[index]);
        }
      });
    }
  }

  Future<bool> refresh() async {
    await orderController.getAccountOrders();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {
          Get.back();
        },
        title: tr("order_history_screen.appbar.order_history_text"),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: NoGlowingScrollView(
          child: Column(children: [
            DefaultTabController(
              length: tabBarController.tabs.length,
              child: Column(
                children: [
                  TabBar(
                    controller: tabBarController.tabController.value,
                    splashBorderRadius: BorderRadius.circular(30),
                    labelStyle: CustomFonts.customGoogleFonts(fontSize: 14.r),
                    unselectedLabelStyle:
                        CustomFonts.customGoogleFonts(fontSize: 12.r),
                    labelColor: AppColors.orange100,
                    unselectedLabelColor: AppColors.dark50,
                    tabs: tabBarController.tabs
                        .map(
                          (tab) => Container(
                            alignment: Alignment.center,
                            height: 35.h,
                            child: Text(
                              tab,
                              style: GoogleFonts.roboto(fontSize: 12.r),
                            ),
                          ),
                        )
                        .toList(),
                    indicatorPadding: EdgeInsets.symmetric(horizontal: 5.w),
                    padding: EdgeInsets.symmetric(vertical: 5.w),
                  ),
                  SizedBox(
                    height: 1.sh - (50.h + 10.w + 35.h + 26),
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: tabBarController.tabController.value,
                      children: [
                        Obx(() {
                          if (orderController.listOnWaitOrder.isNotEmpty) {
                            return NoGlowingScrollView(
                              child: Column(
                                children: orderController.listOnWaitOrder
                                    .map((orderDetails) => OrderItem(
                                          orderDetails: orderDetails,
                                        ))
                                    .toList(),
                              ),
                            );
                          }
                          return Container(
                            color: Colors.white10,
                            height: 0.8.sh,
                            width: 1.sw,
                            child: EmptyWidget(
                              assetsAnimations: "cat_sleep",
                              tilte: tr("order_history_screen.no_order"),
                            ),
                          );
                        }),
                        Obx(() {
                          if (orderController.listOnDeliverOrder.isNotEmpty) {
                            return NoGlowingScrollView(
                              child: Column(
                                children: orderController.listOnDeliverOrder
                                    .map((orderDetails) => OrderItem(
                                          orderDetails: orderDetails,
                                        ))
                                    .toList(),
                              ),
                            );
                          }
                          return Container(
                            color: Colors.white10,
                            height: 0.8.sh,
                            width: 1.sw,
                            child: EmptyWidget(
                              assetsAnimations: "cat_sleep",
                              tilte: tr("order_history_screen.no_order"),
                            ),
                          );
                        }),
                        Obx(() {
                          if (orderController.listCompleteOrder.isNotEmpty) {
                            return NoGlowingScrollView(
                              child: Column(
                                children: orderController.listCompleteOrder
                                    .map((orderDetails) => OrderItem(
                                          orderDetails: orderDetails,
                                        ))
                                    .toList(),
                              ),
                            );
                          }
                          return Container(
                            color: Colors.white10,
                            height: 0.8.sh,
                            width: 1.sw,
                            child: EmptyWidget(
                              assetsAnimations: "cat_sleep",
                              tilte: tr("order_history_screen.no_order"),
                            ),
                          );
                        }),
                        Obx(() {
                          if (orderController.listCancelOrder.isNotEmpty) {
                            return NoGlowingScrollView(
                              child: Column(
                                children: orderController.listCancelOrder
                                    .map((orderDetails) => OrderItem(
                                          orderDetails: orderDetails,
                                        ))
                                    .toList(),
                              ),
                            );
                          }
                          return Container(
                            color: Colors.white10,
                            height: 0.8.sh,
                            width: 1.sw,
                            child: EmptyWidget(
                              assetsAnimations: "cat_sleep",
                              tilte: tr("order_history_screen.no_order"),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
