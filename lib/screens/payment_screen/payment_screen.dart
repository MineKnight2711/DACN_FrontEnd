import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/controller/address_controller.dart';
import 'package:fooddelivery_fe/controller/payment_controller.dart';
import 'package:fooddelivery_fe/controller/transaction_controller.dart';
import 'package:fooddelivery_fe/model/cart_model.dart';
import 'package:fooddelivery_fe/model/payment_model.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/cart_view/components/payment_method_choose.dart';
import 'package:fooddelivery_fe/screens/payment_screen/components/choose_address_screen.dart';
import 'package:fooddelivery_fe/utils/data_convert.dart';

import 'package:fooddelivery_fe/widgets/custom_appbar.dart';
import 'package:fooddelivery_fe/widgets/custom_button.dart';
import 'package:fooddelivery_fe/widgets/no_glowing_scrollview.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckoutScreen extends GetView {
  final List<CartModel> listItem;
  CheckoutScreen(this.listItem, {super.key});
  final paymentController = Get.find<PaymentController>();
  final transactionController = Get.find<TransactionController>();

  Future<bool> popScreen() async {
    Get.delete<PaymentController>();
    Get.delete<TransactionController>();
    Get.delete<AddressController>();
    paymentController.refresh();
    return true;
  }

  double caculatecartItemHeight(int itemCount) {
    double maxHeight = 280.h;
    double itemHeight = 55.h;
    double dividerHeight = 15.h;
    double height = 0.0;
    height = (itemHeight + dividerHeight) * itemCount;
    if (height < maxHeight) {
      return height;
    } else {
      height = maxHeight;
      return height;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: popScreen,
      child: Scaffold(
        appBar: CustomAppBar(
          onPressed: () {
            popScreen();
            Get.back();
          },
          title: "Thanh toán",
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Container(
                  width: double.infinity,
                  height: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.dark100,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text(
                            "Thông tin người nhận :",
                            style: GoogleFonts.roboto(fontSize: 14.r),
                          ),
                          subtitle: Obx(
                            () => Text(
                              "${transactionController.selectedAddress.value.receiverName} | ${transactionController.selectedAddress.value.receiverPhone}",
                              style: GoogleFonts.roboto(
                                  fontSize: 13.r, color: AppColors.dark20),
                            ),
                          ),
                          trailing: TextButton.icon(
                            label: Text(
                              "Sửa",
                              style: GoogleFonts.roboto(fontSize: 14.r),
                            ),
                            onPressed: () {
                              Get.to(ChooseAddressScreen(),
                                  transition: Transition.rightToLeft);
                            },
                            icon: const Icon(
                              CupertinoIcons.pencil,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 11.w),
                        child: Text(
                          "Địa chỉ :",
                          style: GoogleFonts.roboto(fontSize: 14.r),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 11.w), // Adjust padding as needed
                          child: NoGlowingScrollView(
                            child: Obx(
                              () => Text(
                                "${transactionController.selectedAddress.value.details}, ${transactionController.selectedAddress.value.ward}, ${transactionController.selectedAddress.value.district}, ${transactionController.selectedAddress.value.province}",
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.roboto(
                                    fontSize: 13.r, color: AppColors.dark20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Divider(
                  thickness: 0.5.w,
                  endIndent: 10.w,
                  indent: 10.w,
                  color: AppColors.dark100,
                ),
                SizedBox(height: 10.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sản phẩm đã chọn:',
                    style: GoogleFonts.roboto(
                      fontSize: 14.r,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  width: double.infinity,
                  height: caculatecartItemHeight(listItem.length),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.dark100,
                      width: 1,
                    ),
                  ),
                  child: listItem.isNotEmpty
                      ? NoGlowingScrollView(
                          child: Column(
                            children: listItem
                                .map(
                                  (item) => Column(
                                    children: [
                                      SizedBox(
                                        height: 55.h,
                                        child: ListTile(
                                          leading: Image.network(
                                            "${item.dish?.imageUrl}",
                                          ),
                                          title: Text(
                                            "${item.quantity}x ${item.dish?.dishName}",
                                            style: GoogleFonts.roboto(
                                                fontSize: 14.r),
                                          ),
                                          subtitle: Text(
                                            "${item.dish?.category.categoryName}",
                                            style: GoogleFonts.roboto(
                                                fontSize: 12.r),
                                          ),
                                          trailing: Text(
                                            DataConvert().formatCurrency(
                                                double.parse(
                                                        "${item.quantity}") *
                                                    double.parse(
                                                        "${item.dish?.price}")),
                                            style: GoogleFonts.roboto(
                                                fontSize: 12.r),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        height: 15.h,
                                        indent: 15.w,
                                        endIndent: 15.w,
                                        color: AppColors.gray100,
                                      )
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                SizedBox(height: 20.h),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => PaymentDialog(
                          transactionController: transactionController,
                          paymentController: paymentController),
                    );
                  },
                  child: Text(
                    "Chọn phương thức thanh toán",
                    style: GoogleFonts.roboto(fontSize: 14.r),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Chi tiết thanh toán:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Món ăn (số lượng)'),
                        Text('100'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Phí vận chuyển'),
                        Text('20'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Giảm giá'),
                        Text('10%'),
                      ],
                    ),
                    Divider(color: AppColors.gray100),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tổng cộng',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '110',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25.h),
                RoundIconButton(
                    size: 80.r, onPressed: () {}, title: "Thanh toán"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
