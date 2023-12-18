import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:fooddelivery_fe/controller/account_controller.dart';
import 'package:fooddelivery_fe/controller/address_controller.dart';
import 'package:fooddelivery_fe/controller/login_controller.dart';
import 'package:fooddelivery_fe/screens/account_info_screen/profile_screen.dart';
import 'package:fooddelivery_fe/screens/address_screen/address_list_screen.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/settings_view/components/language_slider.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/settings_view/components/utilities_list.dart';
import 'package:fooddelivery_fe/screens/login_signup/login_screen.dart';
import 'package:fooddelivery_fe/widgets/no_glowing_scrollview.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});
  final accountController = Get.find<AccountController>();

  @override
  Widget build(BuildContext context) {
    return NoGlowingScrollView(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Visibility(
              visible: accountController.accountSession.value != null,
              child: Column(
                children: [
                  Text(
                    tr("more.utilities"),
                    style: GoogleFonts.roboto(
                        fontSize: 16.r, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 200.h,
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 2.r,
                      mainAxisSpacing: 10.h,
                      crossAxisSpacing: 10.w,
                      children:
                          UltilitiesList.extensionsCard.map((e) => e).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            tr("more.account_info.account"),
            style:
                GoogleFonts.roboto(fontSize: 16.r, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 300.h,
            child: ListView(
              children: [
                Obx(
                  () => Visibility(
                    visible: accountController.accountSession.value != null,
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Get.to(ProfileScreen(),
                                transition: Transition.rightToLeft);
                          },
                          splashColor: AppColors.lightOrange,
                          leading: const Icon(CupertinoIcons.person),
                          title: Text(
                            tr("more.account_info.profile_account"),
                            style: CustomFonts.customGoogleFonts(
                              fontSize: 14.r,
                            ),
                          ),
                          trailing: const Icon(CupertinoIcons.arrow_right),
                        ),
                        Divider(
                          thickness: 1.w,
                        ),
                        ListTile(
                          onTap: () {
                            final addressController =
                                Get.put(AddressController());
                            addressController.getAllProvine();
                            addressController.getAllAddress();
                            Get.to(AddressListScreen(),
                                transition: Transition.rightToLeft);
                          },
                          splashColor: AppColors.lightOrange,
                          leading: const Icon(CupertinoIcons.location_solid),
                          title: Text(
                            tr("more.account_info.saved_address"),
                            style: CustomFonts.customGoogleFonts(
                              fontSize: 14.r,
                            ),
                          ),
                          trailing: const Icon(CupertinoIcons.arrow_right),
                        ),
                        Divider(
                          thickness: 1.w,
                        ),
                      ],
                    ),
                  ),
                ),
                const LanguageSlider(),
                Divider(
                  thickness: 1.w,
                ),
                Obx(() {
                  if (accountController.accountSession.value != null) {
                    return ListTile(
                      onTap: () {
                        accountController.logOut();
                      },
                      splashColor: AppColors.lightOrange,
                      leading: const Icon(Icons.logout_sharp),
                      title: Text(
                        tr("more.account_info.log_out"),
                        style: GoogleFonts.roboto(
                          fontSize: 14.r,
                        ),
                      ),
                      trailing: const Icon(CupertinoIcons.arrow_right),
                    );
                  }
                  return ListTile(
                    onTap: () {
                      Get.put(LoginController());

                      Get.to(LoginScreen(), transition: Transition.rightToLeft);
                    },
                    splashColor: AppColors.lightOrange,
                    leading: const Icon(Icons.logout_sharp),
                    title: Text(
                      tr("login.login_text"),
                      style: GoogleFonts.roboto(
                        fontSize: 14.r,
                      ),
                    ),
                    trailing: const Icon(CupertinoIcons.arrow_right),
                  );
                })
              ],
            ),
          )
        ],
      ),
    ));
  }
}
