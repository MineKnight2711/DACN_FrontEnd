import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/controller/payment_controller.dart';
import 'package:fooddelivery_fe/model/payment_model.dart';

import 'package:fooddelivery_fe/widgets/custom_appbar.dart';
import 'package:fooddelivery_fe/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentMethodScreen extends GetView {
  PaymentMethodScreen({super.key});
  final paymentController = Get.find<PaymentController>();
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {
          paymentController.refresh();
          Get.back();
        },
        title: "Thanh toán",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.r),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 40.h),
              Obx(
                () {
                  if (paymentController.listPayment.isNotEmpty) {
                    return Column(
                      children: paymentController.listPayment
                          .map(
                            (payment) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: CheckoutMethod(
                                onTap: () {
                                  paymentController.selectedPayment.value =
                                      payment;
                                },
                                isSelected: paymentController
                                        .selectedPayment.value.paymentID ==
                                    payment.paymentID,
                                paymentMethod: payment,
                                imagePath: 'assets/images/card.jpg',
                              ),
                            ),
                          )
                          .toList(),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              SizedBox(height: 20.h),
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
                  SizedBox(height: 10.r),
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
                  SizedBox(height: 10),
                  Divider(color: Colors.grey),
                  SizedBox(height: 10),
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
              SizedBox(height: 50),
              RoundIconButton(
                  size: 80.r, onPressed: () {}, title: "Thanh toán"),
            ],
          ),
        ),
      ),
    );
  }
}

class CheckoutMethod extends StatelessWidget {
  final String imagePath;
  final PaymentModel paymentMethod;
  final Function()? onTap;
  final bool isSelected;
  const CheckoutMethod({
    super.key,
    required this.imagePath,
    required this.paymentMethod,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          border: Border.all(
              color: isSelected ? AppColors.orange100 : AppColors.dark100,
              width: 1),
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
        ),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              height: 24.h,
              width: 24.w,
            ),
            SizedBox(width: 10.w),
            Text(
              "${paymentMethod.paymentMethod}",
              style: GoogleFonts.roboto(
                fontSize: 14.r,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
