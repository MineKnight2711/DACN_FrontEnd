import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/mediquerry.dart';
import 'package:fooddelivery_fe/config/radius.dart';

import 'package:fooddelivery_fe/config/spacing.dart';
import 'package:fooddelivery_fe/controller/account_controller.dart';
import 'package:fooddelivery_fe/controller/login_controller.dart';
import 'package:fooddelivery_fe/controller/map_controller.dart';
import 'package:fooddelivery_fe/model/address_model.dart';
import 'package:fooddelivery_fe/screens/account_info_screen/profile_screen.dart';
import 'package:fooddelivery_fe/screens/login_signup/login_screen.dart';
import 'package:fooddelivery_fe/screens/mapscreen/map_screen.dart';
import 'package:get/get.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AccountController _accountController = Get.find();
  CustomHomeAppBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: Colors.transparent,
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 14.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      tr("home.delivery_to"),
                      style: TextStyle(
                        color: AppColors.gray100,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    SvgPicture.asset("assets/icons/arrow_down.svg"),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Get.put(MapController());
                    Get.to(
                        () => MapScreen(
                              onChooseAddress: (location) {
                                AddressModel selectedAddress = AddressModel();
                                selectedAddress.details = location.results.name;
                                selectedAddress.ward =
                                    location.results.compound.commune;
                                selectedAddress.district =
                                    location.results.compound.district;
                                selectedAddress.province =
                                    location.results.compound.province;
                                _accountController.selectedAddress.value =
                                    selectedAddress;
                                _accountController.saveSelectedAddress();
                                Get.delete<MapController>();
                                Get.back(closeOverlays: false);
                              },
                            ),
                        transition: Transition.zoom);
                  },
                  child: Row(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 200.w),
                        child: Obx(
                          () => Text(
                            _accountController.selectedAddress.value != null
                                ? "${_accountController.selectedAddress.value?.details}, ${_accountController.selectedAddress.value?.ward}, ${_accountController.selectedAddress.value?.district}, ${_accountController.selectedAddress.value?.province}"
                                : tr("home.choose_location"),
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.orange100,
                            ),

                            overflow: TextOverflow
                                .ellipsis, // Truncate text with ellipsis
                            maxLines: 1, // Limit to one line
                          ),
                        ),
                      ),
                      SizedBox(
                        width: CustomMediaQuerry.mediaWidth(context, 60),
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        color: AppColors.orange100,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Obx(() {
            if (_accountController.accountSession.value != null) {
              return GestureDetector(
                onTap: () {
                  Get.to(ProfileScreen(), transition: Transition.rightToLeft);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.space28,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppRadius.border12),
                    ),
                    child: Image.network(
                      "${_accountController.accountSession.value?.imageUrl}",
                      width: 38.w,
                      height: 38.w,
                    ),
                  ),
                ),
              );
            }
            return GestureDetector(
              onTap: () {
                Get.put(LoginController());
                Get.to(LoginScreen(), transition: Transition.rightToLeft);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.space28,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppRadius.border12),
                  ),
                  child: Image.asset(
                    "assets/images/user_avatar.png",
                    width: 38.w,
                    height: 38.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          })
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  BorderRadiusGeometry circularRadius(double radius) {
    return BorderRadius.all(Radius.circular(radius));
  }
}
