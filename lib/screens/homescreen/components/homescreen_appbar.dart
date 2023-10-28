import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/radius.dart';

import 'package:fooddelivery_fe/config/spacing.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/user_drawer.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  // final cartController = Get.find<CartController>();
  const CustomHomeAppBar({Key? key, required this.scaffoldKey})
      : super(key: key);
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
                  Text(
                    "33/39 Van Kiep, Binh Thanh, Ho Chi Minh City",
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.orange100,
                    ),
                    overflow:
                        TextOverflow.ellipsis, // Truncate text with ellipsis
                    maxLines: 1, // Limit to one line
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
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
          ),
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
        children: const [
          // Obx(() {
          //   if (accountApi.accountRespone.value != null) {
          //     final accounts = accountApi.accountRespone.value!;
          //     return UserDrawer(
          //       accounts: accounts,
          //     );
          //   }
          //   return const NoUserDrawer();
          // }),
          NoUserDrawer()
        ],
      ),
    );
  }
}
