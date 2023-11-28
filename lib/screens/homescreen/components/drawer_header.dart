// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/config/mediquerry.dart';
import 'package:fooddelivery_fe/controller/change_image_controller.dart';
import 'package:fooddelivery_fe/controller/login_controller.dart';
import 'package:fooddelivery_fe/model/account_model.dart';
import 'package:fooddelivery_fe/screens/login_signup/login_screen.dart';
import 'package:fooddelivery_fe/utils/transition_animation.dart';
import 'package:fooddelivery_fe/widgets/image_picker/select_image_constant/image_select.dart';
import 'package:fooddelivery_fe/widgets/custom_message.dart';
import 'package:get/get.dart';

class MyDrawerHeader extends StatelessWidget {
  final AccountModel account;
  final changeImageController = Get.put(ChangeImageController());
  MyDrawerHeader({
    Key? key,
    required this.account,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      // margin: EdgeInsets.only(bottom: 50),
      decoration: const BoxDecoration(
        color: Color(0xff06AB8D),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              // padding: EdgeInsets.only(bottom: 30),
              height: CustomMediaQuerry.mediaHeight(context, 6.5),
              width: CustomMediaQuerry.mediaWidth(context, 3.5),
              child: Obx(
                () => ImagePickerWidget(
                  onImageSelected: (selectedImage) async {
                    showLoadingAnimation(
                        context, "assets/animations/loading.json", 180);
                    if (selectedImage != null) {
                      String result = await changeImageController
                          .changeImage("${account.accountID}", selectedImage)
                          .whenComplete(
                            () => Navigator.pop(context),
                          );
                      print(result);
                      if (result == "Success") {
                        showCustomSnackBar(
                                context,
                                "Thông báo",
                                "Cập nhật ảnh thành công!",
                                ContentType.success,
                                2)
                            .whenComplete(
                          () => Navigator.pop(context),
                        );
                      } else {
                        showCustomSnackBar(context, "Cảnh báo", result,
                            ContentType.failure, 2);
                      }
                    }
                  },
                  currentImageUrl:
                      changeImageController.newImageUrl.value.isNotEmpty
                          ? changeImageController.newImageUrl.value
                          : account.imageUrl,
                ),
              ),
            ),
            SizedBox(height: CustomMediaQuerry.mediaHeight(context, 150)),
            Text(
              "${account.fullName}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              // "${account.email}",
              "${account.email}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
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
