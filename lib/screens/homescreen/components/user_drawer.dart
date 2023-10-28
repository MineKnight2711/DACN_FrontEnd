import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/config/mediquerry.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/drawer_header.dart';

class UserDrawer extends StatelessWidget {
  // final AccountResponse accounts;

  // final accountApi = Get.find<AccountApi>();
  UserDrawer({
    Key? key,
    // required this.accounts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: CustomMediaQuerry.mediaHeight(context, 3.3),
            child: MyDrawerHeader()),
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
            // AccountController().logOut();
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
            // Get.put(ChangePasswordController());
            // slideinTransition(context, ChangePasswordScreen());
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
