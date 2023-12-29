import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/bottom_tab_bar/bottom_tabbar_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavigationTabBar extends StatelessWidget {
  final BottomTabBarController bottomTabBarController;
  const BottomNavigationTabBar(
      {super.key, required this.bottomTabBarController});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      physics: const NeverScrollableScrollPhysics(),
      tabs: bottomTabBarController.tabs
          .map((tab) => SizedBox(
              width: 1.sw / 4.5,
              height: 1.sh / 12,
              child: Tab(
                  icon: Stack(
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            tab.imagePath,
                            scale: 1.8,
                          )),
                      tab.tag == "Cart"
                          ? Align(
                              alignment: Alignment.topRight,
                              child: Obx(
                                () => Text(
                                  "${bottomTabBarController.cartController.listCart.length}",
                                  style: GoogleFonts.roboto(fontSize: 16.r),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                  text: tab.name)))
          .toList(),
      labelStyle: GoogleFonts.roboto(fontSize: 14.r),
      unselectedLabelStyle: GoogleFonts.roboto(fontSize: 12.r),
      labelColor: AppColors.dark100,
      unselectedLabelColor: AppColors.dark20,
      controller: bottomTabBarController.tabController.value,
      indicatorPadding: EdgeInsets.symmetric(horizontal: 5.w),
      labelPadding: EdgeInsets.symmetric(horizontal: 5.w),
    );
  }
}
