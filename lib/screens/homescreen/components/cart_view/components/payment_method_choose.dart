import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/controller/payment_controller.dart';
import 'package:fooddelivery_fe/controller/transaction_controller.dart';
import 'package:fooddelivery_fe/model/payment_model.dart';
import 'package:fooddelivery_fe/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentDialog extends StatelessWidget {
  final TransactionController transactionController;
  final PaymentController paymentController;
  const PaymentDialog({
    super.key,
    required this.transactionController,
    required this.paymentController,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        dialogBackgroundColor: AppColors.white100,
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontSize: 16.0,
            color: Colors.grey[800],
          ),
        ),
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
      ),
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          "Chọn phương thức thanh toán",
          style: GoogleFonts.roboto(fontSize: 16.r),
        ),
        content: Obx(
          () {
            if (paymentController.listPayment.isNotEmpty) {
              return SizedBox(
                width: 180.w,
                //Chiều cao image của CheckoutMethod 24.h , padding ngoài 12.h, padding trong 20.h
                height: 60.h * paymentController.listPayment.length,
                child: Column(
                  children: paymentController.listPayment
                      .map(
                        (payment) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.h),
                          child: CheckoutMethod(
                            onTap: () {
                              transactionController.selectedPayment.value =
                                  payment;
                            },
                            isSelected: transactionController
                                    .selectedPayment.value.paymentID ==
                                payment.paymentID,
                            paymentMethod: payment,
                            imagePath: 'assets/images/card.jpg',
                          ),
                        ),
                      )
                      .toList(),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        actions: [
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(bottom: 20.r),
              height: 30.h,
              width: 110.w,
              child: RoundIconButton(
                title: "OK",
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
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
        width: 150.w,
        padding: EdgeInsets.all(10.h),
        decoration: BoxDecoration(
          border: Border.all(
              color: isSelected ? AppColors.orange100 : AppColors.dark100,
              width: 1),
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 24.h,
              width: 24.w,
            ),
            const Spacer(),
            // SizedBox(width: 10.w),
            Text(
              "${paymentMethod.paymentMethod}",
              style: GoogleFonts.roboto(
                fontSize: 14.r,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
