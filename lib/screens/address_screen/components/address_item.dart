// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/controller/account_controller.dart';
import 'package:fooddelivery_fe/controller/address_controller.dart';
import 'package:fooddelivery_fe/model/address_model.dart';
import 'package:fooddelivery_fe/screens/address_screen/update_address_screen.dart';
import 'package:fooddelivery_fe/utils/transition_animation.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/custom_message.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddressItem extends StatelessWidget {
  final AddressModel add;
  AddressItem({super.key, required this.add});
  final accountController = Get.find<AccountController>();
  final addressController = Get.find<AddressController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Slidable(
        closeOnScroll: true,
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              label: tr("address_screen.edit"),
              backgroundColor: Colors.green,
              icon: CupertinoIcons.pencil_ellipsis_rectangle,
              onPressed: (con) {
                Get.to(
                    UpdateAddressScreen(
                      address: add,
                    ),
                    transition: Transition.rightToLeft);
                addressController.fetchCurrent(add);
              },
            ),
            SlidableAction(
              label: tr("address_screen.remove"),
              backgroundColor: Colors.red,
              icon: CupertinoIcons.pencil_ellipsis_rectangle,
              onPressed: (con) async {
                showLoadingAnimation(
                    context, "assets/animations/loading.json", 180);
                String? result = await addressController
                    .deleteAddress("${add.addressID}")
                    .whenComplete(
                      () => Navigator.pop(context),
                    );
                if (result == "Success") {
                  showCustomSnackBar(context, "Thông báo",
                      "Xoá địa chỉ thành công", ContentType.success, 2);
                  addressController.getAllAddress();
                } else {
                  showCustomSnackBar(
                      context,
                      "Lỗi",
                      "Xoá địa chỉ thất bại\n Chi tiết:$result",
                      ContentType.failure,
                      2);
                }
              },
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                leading: const Icon(
                  CupertinoIcons.bookmark_fill,
                  color: AppColors.orange100,
                ),
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${add.addressName}",
                            style: GoogleFonts.roboto(fontSize: 16.r),
                          ),
                          Text(
                            "${add.details}, ${add.ward}, ${add.district}, ${add.province}",
                            style: GoogleFonts.roboto(fontSize: 14.r),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${add.receiverName}",
                            style: GoogleFonts.roboto(fontSize: 14.r),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            width: 1.w,
                            height: 20.h,
                            color: Colors.black.withOpacity(0.3),
                          ),
                          Text(
                            "${add.receiverPhone}",
                            style: GoogleFonts.roboto(fontSize: 14.r),
                          ),
                          const Spacer(),
                          add.defaultAddress ?? false
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        30.0), // Adjust the circular shape
                                    border: Border.all(
                                      color: AppColors.orange100,
                                      width: 1.0.r,
                                    ),
                                  ),
                                  child: Text(
                                    tr("address_screen.default_address"),
                                    style: GoogleFonts.roboto(
                                      fontSize: 14.r,
                                      color: AppColors.orange100,
                                    ),
                                  ),
                                )
                              // Text(
                              //     "Mặc định",
                              //     style: GoogleFonts.roboto(
                              //       fontSize: 14.r,
                              //       color: AppColors.orange100,
                              //     ),
                              //   )
                              : const SizedBox.shrink(),
                        ],
                      ),
                      Divider(
                        thickness: 0.8.r,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
