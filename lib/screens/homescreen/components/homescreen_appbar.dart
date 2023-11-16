import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/radius.dart';

import 'package:fooddelivery_fe/config/spacing.dart';
import 'package:fooddelivery_fe/controller/account_controller.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/user_drawer.dart';
import 'package:fooddelivery_fe/screens/mapscreen/map_screen.dart';
import 'package:get/get.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final AccountController _accountController = Get.find();
  // final cartController = Get.find<CartController>();
  CustomHomeAppBar({Key? key, required this.scaffoldKey}) : super(key: key);
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
            child: SingleChildScrollView(
              // Wrap the Column with SingleChildScrollView
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        tr("deliver_to"),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AutocompleteMap()),
                      );
                    },
                    child: Text(
                      "Chọn địa chỉ ->",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.orange100,
                      ),
                      overflow:
                          TextOverflow.ellipsis, // Truncate text with ellipsis
                      maxLines: 1, // Limit to one line
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(() {
            if (_accountController.accountSession.value != null) {
              return GestureDetector(
                onTap: () {
                  print("hello world");
                  scaffoldKey.currentState?.openEndDrawer();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.space28,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppRadius.border12),
                    ),
                    child: CachedNetworkImage(
                      imageUrl:
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
                print("hello world");
                scaffoldKey.currentState?.openEndDrawer();
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

  Widget buildDrawer(BuildContext context) {
    // accountApi.fetchCurrent();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Obx(() {
            if (_accountController.accountSession.value != null) {
              final accounts = _accountController.accountSession.value!;
              return UserDrawer(
                accounts: accounts,
              );
            }
            return const NoUserDrawer();
          }),
        ],
      ),
    );
  }
}
