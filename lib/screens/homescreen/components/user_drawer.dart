import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/config/mediquerry.dart';
import 'package:fooddelivery_fe/controller/account_controller.dart';
import 'package:fooddelivery_fe/controller/login_controller.dart';
import 'package:fooddelivery_fe/model/account_model.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/drawer_header.dart';
import 'package:fooddelivery_fe/screens/login_signup/login_screen.dart';
import 'package:fooddelivery_fe/utils/transition_animation.dart';
import 'package:get/get.dart';

class UserDrawer extends StatelessWidget {
  final AccountModel accounts;

  final AccountController _accountController = Get.find();
  UserDrawer({
    Key? key,
    required this.accounts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: CustomMediaQuerry.mediaHeight(context, 3.3),
            child: MyDrawerHeader(
              account: accounts,
            )),
        ListTile(
          title: const Text('Cập nhật thông tin'),
          onTap: () {
            // Navigator.pop(context);
            // Get.put(UpdateProfileController(accounts));
            // slideInTransition(
            //   context,
            //   ChangeInfo(account: accounts),
            // );
          },
        ),
        ListTile(
          title: const Text('Địa chỉ đã lưu'),
          onTap: () {
            // Navigator.pop(context);
            // final addressController = Get.put(AddressController());
            // addressController.getListAddress();
            // slideInTransition(
            //   context,
            //   AddressListScreen(),
            // );
          },
        ),
        ListTile(
          title: const Text('Đổi mật khẩu'),
          onTap: () {
            Navigator.pop(context);
            // Get.put(ChangePasswordController());
            // slideInTransition(
            //     context,
            //     ChangePasswordScreen(
            //       email: '${accounts.email}',
            //     ));
          },
        ),
        ListTile(
            title: const Text('Xác thực vân tay'),
            trailing: Switch(
              value: false,
              onChanged: (value) {},
            )
            // Obx(() => Switch(
            //       value: accountApi.enableFingerprint.value,
            //       onChanged: (newValue) {
            //         accounts.isFingerPrintAuthentication =
            //             accountApi.enableFingerprint.value = newValue;
            //         Logger()
            //             .i("${accounts.isFingerPrintAuthentication} fingerprint");
            //         accountApi.updateFingerprintAuthentication(
            //             accounts.toAccountModel());
            //       },
            //     )),
            ),
        ListTile(
          title: const Text('Đơn hàng'),
          onTap: () {
            Navigator.pop(context);
            // slideInTransition(context, ListOrderScreen());
          },
        ),
        ListTile(
          title: const Text('Đăng xuất'),
          onTap: () {
            _accountController.logOut();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class NoUserDrawer extends StatelessWidget {
  const NoUserDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('Đăng nhập'),
          onTap: () {
            Navigator.pop(context);
            Get.put(LoginController());
            slideInTransition(context, LoginScreen());
          },
        ),
        ListTile(
          title: const Text('Thoát'),
          onTap: () {
            // controller.logout();
            // Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
