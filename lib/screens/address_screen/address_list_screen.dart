import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/mediquerry.dart';
import 'package:fooddelivery_fe/controller/account_controller.dart';
import 'package:fooddelivery_fe/controller/address_controller.dart';
import 'package:fooddelivery_fe/screens/address_screen/add_address_screen.dart';
import 'package:fooddelivery_fe/widgets/custom_appbar.dart';
import 'package:fooddelivery_fe/widgets/custom_button.dart';
import 'package:fooddelivery_fe/widgets/no_glowing_scrollview.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddressListScreen extends GetView {
  AddressListScreen({super.key});
  final accountController = Get.find<AccountController>();
  final addressController = Get.find<AddressController>();
  Future<void> refresh() async {
    await addressController.getListAddressByAccountId(
        "${accountController.accountSession.value?.accountID}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {
          Get.delete<AddressController>();
          Navigator.pop(context);
        },
        showLeading: true,
        title: "Địa chỉ của bạn",
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: NoGlowingScrollView(
          child: Obx(() {
            if (addressController.listAddress.isNotEmpty) {
              return Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: addressController.listAddress
                        .map(
                          (add) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Slidable(
                              closeOnScroll: true,
                              endActionPane: ActionPane(
                                motion: const DrawerMotion(),
                                children: [
                                  SlidableAction(
                                    label: "Sửa",
                                    backgroundColor: Colors.green,
                                    icon: CupertinoIcons
                                        .pencil_ellipsis_rectangle,
                                    onPressed: (con) {},
                                  ),
                                  SlidableAction(
                                    label: "Xoá",
                                    backgroundColor: Colors.red,
                                    icon: CupertinoIcons
                                        .pencil_ellipsis_rectangle,
                                    onPressed: (con) {},
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      leading: const Icon(
                                        CupertinoIcons.bookmark_fill,
                                        color: AppColors.orange100,
                                      ),
                                      title: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  add.addressName,
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 16.r),
                                                ),
                                                Text(
                                                  "${add.details}, ${add.ward}, ${add.district}, ${add.province}",
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 14.r),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  add.receiverName,
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 14.r),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(horizontal: 6),
                                                  width: 1.w,
                                                  height: 20.h,
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                ),
                                                Text(
                                                  add.receiverPhone,
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 14.r),
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              thickness: 0.8.r,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(
                    height: 80.h,
                  ),
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: RoundIconButton(
          size: 90.r,
          title: "Thêm địa chỉ",
          onPressed: () {
            Get.to(() => AddAddressScreen(), transition: Transition.downToUp);
          },
        ),
      ),
    );
  }
}

// class Address {
//   String address;
//   String addressName;
//   String receiver;
//   Address({
//     required this.address,
//     required this.addressName,
//     required this.receiver,
//   });
// }

// RxList<Address> listAddress = [
//   Address(address: "Quận 9", addressName: "Nhà", receiver: "Nhật 9"),
//   Address(
//       address:
//           "330/4b,phường 3,Quận 8, Thành Phố Hồ CHí Minh,Việt Nam,Đông Nam Á, Châu Á, Trái Đất, Hệ Mặt Trời, Dải ngân hà Milky way, kéo dài từ chòm sao Tiên Hậu (Cassiopeia) ở phía bắc đến chòm sao Nam Thập Tự (Crux) ở phía nam, Virgo Supercluster, Observable Universe",
//       addressName: "Trường",
//       receiver: "Nhật 8"),
//   Address(address: "Quận 7", addressName: "Bệnh viện", receiver: "Nhật 7"),
//   Address(address: "Quận 6", addressName: "Công ty", receiver: "Nhật 6"),
//   Address(address: "Quận 5", addressName: "Công sở", receiver: "Nhật 5"),
//   Address(address: "Quận 4", addressName: "Sân bay", receiver: "Nhật 4"),
//   Address(address: "Quận 3", addressName: "Cổng chính", receiver: "Nhật 3"),
//   Address(address: "Quận 2", addressName: "Demo", receiver: "Nhật 2"),
//   Address(
//       address: "Quận 1", addressName: "Công an Thành Phố", receiver: "Nhật 1"),
// ].obs;
