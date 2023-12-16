import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:fooddelivery_fe/controller/order_controller.dart';
import 'package:fooddelivery_fe/model/order_model.dart';
import 'package:fooddelivery_fe/screens/order_screen/components/list_details_dishes.dart';
import 'package:fooddelivery_fe/screens/order_screen/components/order_details_bottom_sheet.dart';
import 'package:fooddelivery_fe/screens/order_screen/components/order_tabbar_controller.dart';
import 'package:fooddelivery_fe/utils/data_convert.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/custom_appbar.dart';
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
        title: tr("order_history_screen.appbar.order_history_text"),
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
                                            onTap: () {
                                              _showBottomSheet(orderDetails);
                                            },
                                            leading: Image.asset(
                                              "assets/images/delivery-man.png",
                                              width: 25.w,
                                            ),
                                            title: ListDetailsDishes(
                                              detailList:
                                                  orderDetails.detailList,
                                            ),
                                            subtitle: Text(DataConvert()
                                                .formattedOrderDate(orderDetails
                                                    .order?.orderDate)),
                                            trailing: Text(
                                              DataConvert().formatCurrency(
                                                  caculateCartTotal(
                                                      orderDetails)),
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
                                          groupTag: "listOnDeliverOrder",
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
                                            onTap: () {
                                              _showBottomSheet(orderDetails);
                                            },
                                            leading: Image.asset(
                                              "assets/images/delivery-man.png",
                                              width: 25.w,
                                            ),
                                            title: ListDetailsDishes(
                                              detailList:
                                                  orderDetails.detailList,
                                            ),
                                            subtitle: Text(DataConvert()
                                                .formattedOrderDate(orderDetails
                                                    .order?.orderDate)),
                                            trailing: Text(
                                              DataConvert().formatCurrency(
                                                  caculateCartTotal(
                                                      orderDetails)),
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
                                            onTap: () {
                                              _showBottomSheet(orderDetails);
                                            },
                                            leading: Image.asset(
                                              "assets/images/delivery-man.png",
                                              width: 25.w,
                                            ),
                                            title: ListDetailsDishes(
                                              detailList:
                                                  orderDetails.detailList,
                                            ),
                                            subtitle: Text(DataConvert()
                                                .formattedOrderDate(orderDetails
                                                    .order?.orderDate)),
                                            trailing: Text(
                                              DataConvert().formatCurrency(
                                                  caculateCartTotal(
                                                      orderDetails)),
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
                                          groupTag: "listCancelOrder",
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
                                            onTap: () {
                                              _showBottomSheet(orderDetails);
                                            },
                                            leading: Image.asset(
                                              "assets/images/delivery-man.png",
                                              width: 25.w,
                                            ),
                                            title: ListDetailsDishes(
                                              detailList:
                                                  orderDetails.detailList,
                                            ),
                                            subtitle: Text(DataConvert()
                                                .formattedOrderDate(orderDetails
                                                    .order?.orderDate)),
                                            trailing: Text(
                                              DataConvert().formatCurrency(
                                                  caculateCartTotal(
                                                      orderDetails)),
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

  double caculateCartTotal(OrderDetailsDTO orderDetails) {
    double total = orderDetails.detailList?.fold<double>(
          0.0,
          (previousValue, details) => previousValue + (details.price ?? 0.0),
        ) ??
        0.0;
    if (orderDetails.order != null && orderDetails.order?.voucher != null) {
      final voucher = orderDetails.order!.voucher!;
      switch (voucher.type) {
        case "Percent":
          total = total - (total * ((voucher.discountPercent ?? 0) / 100));
          return total;
        case "Amount":
          total = total - (voucher.discountAmount ?? 0);
          return total;
        default:
          break;
      }
    }
    return total;
  }

  void _showBottomSheet(OrderDetailsDTO orderDetails) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.8, //Kích cỡ sheet khi vừa hiện lên
          minChildSize:
              0.3, //Khi ta kéo sheet về 0.3 chiều cao của nó, nó sẽ đóng
          maxChildSize: 0.95, //Chiều cao tối đa của sheet được phép kéo lên
          expand: false,
          builder: (context, scrollController) {
            return NoGlowingScrollView(
              scrollController: scrollController,
              child: OrderDetailsBottomSheet(
                scrollController: scrollController,
                orderDetails: orderDetails,
              ),
            );
          },
        );
      },
    );
  }
}
