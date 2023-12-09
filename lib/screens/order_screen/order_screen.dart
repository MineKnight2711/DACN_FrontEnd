import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:fooddelivery_fe/controller/order_controller.dart';
import 'package:fooddelivery_fe/screens/order_screen/compinent/order_tabbar_controller.dart';
import 'package:fooddelivery_fe/utils/data_convert.dart';
import 'package:fooddelivery_fe/widgets/custom_appbar.dart';
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
                padding: EdgeInsets.all(5.w),
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
                                .map(
                                  (orderDetails) => Builder(builder: (context) {
                                    return Column(
                                      children: [
                                        Slidable(
                                          groupTag: "listOnWaitOrder",
                                          endActionPane: ActionPane(
                                            motion: const DrawerMotion(),
                                            extentRatio: 0.2,
                                            children: [
                                              SlidableAction(
                                                icon: Icons.delete,
                                                backgroundColor: Colors.red,
                                                label: "Xoá",
                                                onPressed: (context) {},
                                              )
                                            ],
                                          ),
                                          child: ListTile(
                                            onTap: () {},
                                            leading: Image.asset(
                                              "assets/images/delivery-man.png",
                                              width: 25.w,
                                            ),
                                            title: RichText(
                                              text: TextSpan(
                                                style: CustomFonts
                                                    .customGoogleFonts(
                                                        fontSize: 14.r),
                                                children: orderDetails
                                                    .detailList
                                                    ?.map((details) {
                                                  if (orderDetails.detailList !=
                                                      null) {
                                                    final index = orderDetails
                                                        .detailList!
                                                        .indexOf(details);
                                                    if (orderDetails.detailList!
                                                            .length ==
                                                        1) {
                                                      return TextSpan(
                                                        text:
                                                            "${details.dish?.dishName}",
                                                        style: CustomFonts
                                                            .customGoogleFonts(
                                                                fontSize: 14.r),
                                                      );
                                                    } else if (orderDetails
                                                            .detailList!
                                                            .isNotEmpty &&
                                                        index < 2) {
                                                      if (index == 1 &&
                                                          orderDetails
                                                                  .detailList!
                                                                  .length ==
                                                              2) {
                                                        return TextSpan(
                                                          text:
                                                              "${details.dish?.dishName}",
                                                          style: CustomFonts
                                                              .customGoogleFonts(
                                                                  fontSize:
                                                                      14.r),
                                                        );
                                                      } else {
                                                        return TextSpan(
                                                          text:
                                                              "${details.dish?.dishName}${index == 1 ? '' : ', '}",
                                                          style: CustomFonts
                                                              .customGoogleFonts(
                                                                  fontSize:
                                                                      14.r),
                                                        );
                                                      }
                                                    } else if (orderDetails
                                                                .detailList!
                                                                .length >
                                                            2 &&
                                                        index == 2) {
                                                      int remainingCount =
                                                          orderDetails
                                                                  .detailList!
                                                                  .length -
                                                              2;
                                                      return TextSpan(
                                                        text:
                                                            " và $remainingCount món khác...",
                                                        style: CustomFonts
                                                            .customGoogleFonts(
                                                                fontSize: 14.r),
                                                      );
                                                    }
                                                  }
                                                  return const TextSpan(
                                                      text: "");
                                                }).toList(),
                                              ),
                                            ),
                                            subtitle: Text(DataConvert()
                                                .formattedOrderDate(orderDetails
                                                    .order?.orderDate)),
                                            trailing: Text(
                                              DataConvert().formatCurrency(
                                                  orderDetails.detailList?.fold<
                                                              double>(
                                                          0.0,
                                                          (previousValue,
                                                                  details) =>
                                                              previousValue +
                                                              (details.price ??
                                                                  0.0)) ??
                                                      0.0),
                                              style:
                                                  CustomFonts.customGoogleFonts(
                                                      fontSize: 14.r),
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          height: 5.h,
                                          thickness: 1.w,
                                          endIndent: 10.w,
                                          indent: 10.w,
                                        )
                                      ],
                                    );
                                  }),
                                )
                                .toList(),
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
                    Obx(() {
                      if (orderController.listOnDeliverOrder.isNotEmpty) {
                        return NoGlowingScrollView(
                          child: Column(
                            children: orderController.listOnDeliverOrder
                                .map(
                                  (orderDetails) => Builder(builder: (context) {
                                    return Column(
                                      children: [
                                        Slidable(
                                          groupTag: "listOnWaitOrder",
                                          endActionPane: ActionPane(
                                            motion: const DrawerMotion(),
                                            extentRatio: 0.2,
                                            children: [
                                              SlidableAction(
                                                icon: Icons.delete,
                                                backgroundColor: Colors.red,
                                                label: "Xoá",
                                                onPressed: (context) {},
                                              )
                                            ],
                                          ),
                                          child: ListTile(
                                            onTap: () {},
                                            leading: Image.asset(
                                              "assets/images/delivery-man.png",
                                              width: 25.w,
                                            ),
                                            title: RichText(
                                              text: TextSpan(
                                                style: CustomFonts
                                                    .customGoogleFonts(
                                                        fontSize: 14.r),
                                                children: orderDetails
                                                    .detailList
                                                    ?.map((details) {
                                                  if (orderDetails.detailList !=
                                                      null) {
                                                    final index = orderDetails
                                                        .detailList!
                                                        .indexOf(details);
                                                    if (orderDetails.detailList!
                                                            .length ==
                                                        1) {
                                                      return TextSpan(
                                                        text:
                                                            "${details.dish?.dishName}",
                                                        style: CustomFonts
                                                            .customGoogleFonts(
                                                                fontSize: 14.r),
                                                      );
                                                    } else if (orderDetails
                                                            .detailList!
                                                            .isNotEmpty &&
                                                        index < 2) {
                                                      if (index == 1 &&
                                                          orderDetails
                                                                  .detailList!
                                                                  .length ==
                                                              2) {
                                                        return TextSpan(
                                                          text:
                                                              "${details.dish?.dishName}",
                                                          style: CustomFonts
                                                              .customGoogleFonts(
                                                                  fontSize:
                                                                      14.r),
                                                        );
                                                      } else {
                                                        return TextSpan(
                                                          text:
                                                              "${details.dish?.dishName}${index == 1 ? '' : ', '}",
                                                          style: CustomFonts
                                                              .customGoogleFonts(
                                                                  fontSize:
                                                                      14.r),
                                                        );
                                                      }
                                                    } else if (orderDetails
                                                                .detailList!
                                                                .length >
                                                            2 &&
                                                        index == 2) {
                                                      int remainingCount =
                                                          orderDetails
                                                                  .detailList!
                                                                  .length -
                                                              2;
                                                      return TextSpan(
                                                        text:
                                                            " và $remainingCount món khác...",
                                                        style: CustomFonts
                                                            .customGoogleFonts(
                                                                fontSize: 14.r),
                                                      );
                                                    }
                                                  }
                                                  return const TextSpan(
                                                      text: "");
                                                }).toList(),
                                              ),
                                            ),
                                            subtitle: Text(DataConvert()
                                                .formattedOrderDate(orderDetails
                                                    .order?.orderDate)),
                                            trailing: Text(
                                              DataConvert().formatCurrency(
                                                  orderDetails.detailList?.fold<
                                                              double>(
                                                          0.0,
                                                          (previousValue,
                                                                  details) =>
                                                              previousValue +
                                                              (details.price ??
                                                                  0.0)) ??
                                                      0.0),
                                              style:
                                                  CustomFonts.customGoogleFonts(
                                                      fontSize: 14.r),
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          height: 5.h,
                                          thickness: 1.w,
                                          endIndent: 10.w,
                                          indent: 10.w,
                                        )
                                      ],
                                    );
                                  }),
                                )
                                .toList(),
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
                    Obx(() {
                      if (orderController.listCompleteOrder.isNotEmpty) {
                        return NoGlowingScrollView(
                          child: Column(
                            children: orderController.listCompleteOrder
                                .map(
                                  (orderDetails) => Builder(builder: (context) {
                                    return Column(
                                      children: [
                                        Slidable(
                                          groupTag: "listOnWaitOrder",
                                          endActionPane: ActionPane(
                                            motion: const DrawerMotion(),
                                            extentRatio: 0.2,
                                            children: [
                                              SlidableAction(
                                                icon: Icons.delete,
                                                backgroundColor: Colors.red,
                                                label: "Xoá",
                                                onPressed: (context) {},
                                              )
                                            ],
                                          ),
                                          child: ListTile(
                                            onTap: () {},
                                            leading: Image.asset(
                                              "assets/images/delivery-man.png",
                                              width: 25.w,
                                            ),
                                            title: RichText(
                                              text: TextSpan(
                                                style: CustomFonts
                                                    .customGoogleFonts(
                                                        fontSize: 14.r),
                                                children: orderDetails
                                                    .detailList
                                                    ?.map((details) {
                                                  if (orderDetails.detailList !=
                                                      null) {
                                                    final index = orderDetails
                                                        .detailList!
                                                        .indexOf(details);
                                                    if (orderDetails.detailList!
                                                            .length ==
                                                        1) {
                                                      return TextSpan(
                                                        text:
                                                            "${details.dish?.dishName}",
                                                        style: CustomFonts
                                                            .customGoogleFonts(
                                                                fontSize: 14.r),
                                                      );
                                                    } else if (orderDetails
                                                            .detailList!
                                                            .isNotEmpty &&
                                                        index < 2) {
                                                      if (index == 1 &&
                                                          orderDetails
                                                                  .detailList!
                                                                  .length ==
                                                              2) {
                                                        return TextSpan(
                                                          text:
                                                              "${details.dish?.dishName}",
                                                          style: CustomFonts
                                                              .customGoogleFonts(
                                                                  fontSize:
                                                                      14.r),
                                                        );
                                                      } else {
                                                        return TextSpan(
                                                          text:
                                                              "${details.dish?.dishName}${index == 1 ? '' : ', '}",
                                                          style: CustomFonts
                                                              .customGoogleFonts(
                                                                  fontSize:
                                                                      14.r),
                                                        );
                                                      }
                                                    } else if (orderDetails
                                                                .detailList!
                                                                .length >
                                                            2 &&
                                                        index == 2) {
                                                      int remainingCount =
                                                          orderDetails
                                                                  .detailList!
                                                                  .length -
                                                              2;
                                                      return TextSpan(
                                                        text:
                                                            " và $remainingCount món khác...",
                                                        style: CustomFonts
                                                            .customGoogleFonts(
                                                                fontSize: 14.r),
                                                      );
                                                    }
                                                  }
                                                  return const TextSpan(
                                                      text: "");
                                                }).toList(),
                                              ),
                                            ),
                                            subtitle: Text(DataConvert()
                                                .formattedOrderDate(orderDetails
                                                    .order?.orderDate)),
                                            trailing: Text(
                                              DataConvert().formatCurrency(
                                                  orderDetails.detailList?.fold<
                                                              double>(
                                                          0.0,
                                                          (previousValue,
                                                                  details) =>
                                                              previousValue +
                                                              (details.price ??
                                                                  0.0)) ??
                                                      0.0),
                                              style:
                                                  CustomFonts.customGoogleFonts(
                                                      fontSize: 14.r),
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          height: 5.h,
                                          thickness: 1.w,
                                          endIndent: 10.w,
                                          indent: 10.w,
                                        )
                                      ],
                                    );
                                  }),
                                )
                                .toList(),
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
                    Obx(() {
                      if (orderController.listCancelOrder.isNotEmpty) {
                        return NoGlowingScrollView(
                          child: Column(
                            children: orderController.listCancelOrder
                                .map(
                                  (orderDetails) => Builder(builder: (context) {
                                    return Column(
                                      children: [
                                        Slidable(
                                          groupTag: "listOnWaitOrder",
                                          endActionPane: ActionPane(
                                            motion: const DrawerMotion(),
                                            extentRatio: 0.2,
                                            children: [
                                              SlidableAction(
                                                icon: Icons.delete,
                                                backgroundColor: Colors.red,
                                                label: "Xoá",
                                                onPressed: (context) {},
                                              )
                                            ],
                                          ),
                                          child: ListTile(
                                            onTap: () {},
                                            leading: Image.asset(
                                              "assets/images/delivery-man.png",
                                              width: 25.w,
                                            ),
                                            title: RichText(
                                              text: TextSpan(
                                                style: CustomFonts
                                                    .customGoogleFonts(
                                                        fontSize: 14.r),
                                                children: orderDetails
                                                    .detailList
                                                    ?.map((details) {
                                                  if (orderDetails.detailList !=
                                                      null) {
                                                    final index = orderDetails
                                                        .detailList!
                                                        .indexOf(details);
                                                    if (orderDetails.detailList!
                                                            .length ==
                                                        1) {
                                                      return TextSpan(
                                                        text:
                                                            "${details.dish?.dishName}",
                                                        style: CustomFonts
                                                            .customGoogleFonts(
                                                                fontSize: 14.r),
                                                      );
                                                    } else if (orderDetails
                                                            .detailList!
                                                            .isNotEmpty &&
                                                        index < 2) {
                                                      if (index == 1 &&
                                                          orderDetails
                                                                  .detailList!
                                                                  .length ==
                                                              2) {
                                                        return TextSpan(
                                                          text:
                                                              "${details.dish?.dishName}",
                                                          style: CustomFonts
                                                              .customGoogleFonts(
                                                                  fontSize:
                                                                      14.r),
                                                        );
                                                      } else {
                                                        return TextSpan(
                                                          text:
                                                              "${details.dish?.dishName}${index == 1 ? '' : ', '}",
                                                          style: CustomFonts
                                                              .customGoogleFonts(
                                                                  fontSize:
                                                                      14.r),
                                                        );
                                                      }
                                                    } else if (orderDetails
                                                                .detailList!
                                                                .length >
                                                            2 &&
                                                        index == 2) {
                                                      int remainingCount =
                                                          orderDetails
                                                                  .detailList!
                                                                  .length -
                                                              2;
                                                      return TextSpan(
                                                        text:
                                                            " và $remainingCount món khác...",
                                                        style: CustomFonts
                                                            .customGoogleFonts(
                                                                fontSize: 14.r),
                                                      );
                                                    }
                                                  }
                                                  return const TextSpan(
                                                      text: "");
                                                }).toList(),
                                              ),
                                            ),
                                            subtitle: Text(DataConvert()
                                                .formattedOrderDate(orderDetails
                                                    .order?.orderDate)),
                                            trailing: Text(
                                              DataConvert().formatCurrency(
                                                  orderDetails.detailList?.fold<
                                                              double>(
                                                          0.0,
                                                          (previousValue,
                                                                  details) =>
                                                              previousValue +
                                                              (details.price ??
                                                                  0.0)) ??
                                                      0.0),
                                              style:
                                                  CustomFonts.customGoogleFonts(
                                                      fontSize: 14.r),
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          height: 5.h,
                                          thickness: 1.w,
                                          endIndent: 10.w,
                                          indent: 10.w,
                                        )
                                      ],
                                    );
                                  }),
                                )
                                .toList(),
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
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
