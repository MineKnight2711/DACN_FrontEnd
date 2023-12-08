import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/controller/transaction_controller.dart';
import 'package:fooddelivery_fe/widgets/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseAddressScreen extends GetView {
  ChooseAddressScreen({super.key});
  final transactionController = Get.find<TransactionController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          onPressed: () {
            Get.back();
          },
          title: "Chọn địa chỉ",
        ),
        body: Obx(() {
          if (transactionController.listAddress.isNotEmpty) {
            return Column(
              children: transactionController.listAddress
                  .map(
                    (address) => ListTile(
                      onTap: () {
                        transactionController.selectedAddress.value = address;
                      },
                      leading: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 150),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(-1.0, 0.0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          );
                        },
                        child: transactionController
                                    .selectedAddress.value?.addressID ==
                                address.addressID
                            ? const Icon(
                                Icons.check,
                                color: Colors.blue,
                              )
                            : const SizedBox(),
                      ),
                      title: Text(
                        "${address.addressName}",
                        style: GoogleFonts.roboto(fontSize: 15.r),
                      ),
                      subtitle: Text(
                        "${address.details}, ${address.ward}, ${address.district}, ${address.province}",
                        style: GoogleFonts.roboto(fontSize: 13.r),
                      ),
                      trailing: address.defaultAddress ?? false
                          ? Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: AppColors.orange100, width: 1.w),
                              ),
                              width: 70.w,
                              height: 20.h,
                              child: Text(
                                "Mặc định",
                                style: GoogleFonts.roboto(fontSize: 13.r),
                              ))
                          : const SizedBox.shrink(),
                    ),
                  )
                  .toList(),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }));
  }
}
