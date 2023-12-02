import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/api/vietnam_province_api/province_api.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/controller/account_controller.dart';
import 'package:fooddelivery_fe/controller/address_controller.dart';
import 'package:fooddelivery_fe/controller/login_controller.dart';
import 'package:fooddelivery_fe/screens/account_info_screen/profile_screen.dart';
import 'package:fooddelivery_fe/screens/address_screen/address_list_screen.dart';
import 'package:fooddelivery_fe/screens/address_screen/add_address_screen.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tiện ích",
            style:
                GoogleFonts.roboto(fontSize: 16.r, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 200.h,
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 2.r,
              mainAxisSpacing: 10.h,
              crossAxisSpacing: 10.w,
              children: extensionsCard.map((e) => e).toList(),
            ),
          ),
          Text(
            "Tài khoản",
            style:
                GoogleFonts.roboto(fontSize: 16.r, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 200.h,
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
                            "Thông tin tài khoản",
                            style: GoogleFonts.roboto(
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
                            final provinceApi = Get.put(ProvinceApi());
                            final addressController =
                                Get.put(AddressController());
                            provinceApi.getAllProvine();
                            addressController.getListAddressByAccountId(
                                "${accountController.accountSession.value?.accountID}");
                            Get.to(AddressListScreen(),
                                transition: Transition.rightToLeft);
                          },
                          splashColor: AppColors.lightOrange,
                          leading: const Icon(CupertinoIcons.location_solid),
                          title: Text(
                            "Địa chỉ đã lưu",
                            style: GoogleFonts.roboto(
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
                Obx(() {
                  if (accountController.accountSession.value != null) {
                    return ListTile(
                      onTap: () {
                        accountController.logOut();
                      },
                      splashColor: AppColors.lightOrange,
                      leading: const Icon(Icons.logout_sharp),
                      title: Text(
                        "Đăng xuất",
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
                      "Đăng nhập",
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

const List<ExtensionCard> extensionsCard = [
  ExtensionCard(
    icon: CupertinoIcons.square_list,
    title: 'Lịch sử đơn hàng',
  ),
  ExtensionCard(
    icon: Icons.discount,
    title: 'Nhận mã ưu đãi',
  ),
  ExtensionCard(
    icon: Icons.star,
    title: 'Đánh giá đơn hàng',
  ),
  ExtensionCard(
    icon: Icons.chat,
    title: 'Liên hệ và góp ý',
  ),
];

class ExtensionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  const ExtensionCard({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.grey.withOpacity(1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        splashColor: AppColors.lightOrange,
        highlightColor: Colors.transparent,
        onTap: () {},
        child: Container(
          margin: EdgeInsets.all(16.r),
          height: 20.h,
          width: 200.w - 50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                icon,
                color: AppColors.orange100,
                size: 24.r,
              ),
              Text(
                title,
                style: GoogleFonts.roboto(
                  fontSize: 13.r,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
