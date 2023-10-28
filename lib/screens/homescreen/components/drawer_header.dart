import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/config/mediquerry.dart';

class MyDrawerHeader extends StatelessWidget {
  // final AccountResponse account;
  // final changeImageController = Get.put(ChangeImageController());
  const MyDrawerHeader({
    Key? key,
    // required this.account,
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
              // child:
              // Obx(
              //   () =>
              //    ImagePickerWidget(
              //     onImageSelected: (selectedImage) async {
              //       showOrderLoadingAnimation(
              //           context, "assets/animations/loading_1.json", 180);
              //       String url =
              //           await changeImageController.saveImageToFirebaseStorage(
              //               selectedImage, "${account.accountId}");
              //       Logger().i("$url log url");
              //       Navigator.pop(context);
              //       if (url.isNotEmpty) {
              //         showOrderLoadingAnimation(
              //             context, "assets/animations/loading_1.json", 180);
              //         String result = await changeImageController
              //             .changeImageUrl("${account.accountId}", url);
              //         if (result == "Success") {
              //           CustomSuccessMessage.showMessage(
              //                   "Cập nhật ảnh thành công!")
              //               .then((value) {
              //             changeImageController
              //                 .awaitCurrentAccount()
              //                 .whenComplete(() => Navigator.pop(context));
              //           });
              //         } else {
              //           CustomErrorMessage.showMessage(result);
              //         }
              //       } else {
              //         CustomErrorMessage.showMessage("Có lỗi xảy ra!");
              //       }
              //     },
              //     currentImageUrl:
              //         changeImageController.newImageUrl.value.isNotEmpty
              //             ? changeImageController.newImageUrl.value
              //             : account.imageUrl,
              //   ),

              // ),
            ),
            SizedBox(height: CustomMediaQuerry.mediaHeight(context, 150)),
            Text(
              "Full name",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              // "${account.email}",
              "Email",
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
