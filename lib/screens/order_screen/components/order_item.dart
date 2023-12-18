import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:fooddelivery_fe/model/order_model.dart';
import 'package:fooddelivery_fe/screens/order_screen/components/list_details_dishes.dart';
import 'package:fooddelivery_fe/screens/order_screen/components/order_details_bottom_sheet.dart';
import 'package:fooddelivery_fe/utils/data_convert.dart';
import 'package:fooddelivery_fe/widgets/no_glowing_scrollview.dart';

class OrderItem extends StatelessWidget {
  final OrderDetailsDTO orderDetails;
  const OrderItem({super.key, required this.orderDetails});

  @override
  Widget build(BuildContext context) {
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
              _showBottomSheet(orderDetails, context);
            },
            leading: Image.asset(
              "assets/images/delivery-man.png",
              width: 25.w,
            ),
            title: Wrap(
              runSpacing: 1.w,
              children: [
                Text(
                  "Mã đơn hàng : ${orderDetails.order?.orderID}",
                  style: CustomFonts.customGoogleFonts(fontSize: 14.r),
                ),
                const SizedBox(
                  width: double
                      .infinity, //Cho chiều dài vô cực để buộc wrap phải xuống hàng mới
                ),
                ListDetailsDishes(
                  detailList: orderDetails.detailList,
                ),
              ],
            ),
            subtitle: Text(DataConvert()
                .formattedOrderDate(orderDetails.order?.orderDate)),
            trailing: Text(
              DataConvert().formatCurrency(caculateCartTotal(orderDetails)),
              style: CustomFonts.customGoogleFonts(fontSize: 14.r),
            ),
          ),
        ),
        Divider(
          height: 5.h,
          thickness: 1.w,
          endIndent: 10.w,
          indent: 10.w,
        ),
      ],
    );
  }

  void _showBottomSheet(OrderDetailsDTO orderDetails, BuildContext context) {
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
}
