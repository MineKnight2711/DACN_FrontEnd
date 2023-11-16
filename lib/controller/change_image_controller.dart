import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fooddelivery_fe/api/account/account_api.dart';
import 'package:fooddelivery_fe/controller/account_controller.dart';
import 'package:fooddelivery_fe/model/account_model.dart';
import 'package:get/get.dart';

class ChangeImageController extends GetxController {
  final newImageUrl = ''.obs;
  late AccountApi _accountApi;
  late AccountController _accountController;
  @override
  void onInit() {
    super.onInit();
    _accountApi = AccountApi();
    _accountController = Get.find<AccountController>();
  }

  //Chờ thông tin người dùng hiện tại
  // Future<AccountResponse?> awaitCurrentAccount() async {
  //   return await accountApi.fetchCurrent().then((currentAccount) {
  //     if (currentAccount != null) {
  //       newImageUrl.value = currentAccount.imageUrl ?? '';
  //       return currentAccount;
  //     }
  //     return null;
  //   });
  // }

  Future<String> changeImageUrl(String accountId, String newImageUrl) async {
    final respone = await _accountApi.changeImageUrl(accountId, newImageUrl);
    if (respone.message == "Success") {
      AccountModel fetchedAccount = AccountModel.fromJson(respone.data);

      await _accountController
          .storedUserToSharedRefererces(fetchedAccount)
          .whenComplete(
              () => _accountController.accountSession.value = fetchedAccount);
      return "Success";
    }
    return respone.message!;
  }

  Future<String> saveImageToFirebaseStorage(
      File? imageFile, String userInfo) async {
    if (imageFile != null) {
      final fileName = 'user_$userInfo.jpg';
      final Reference storageReference =
          FirebaseStorage.instance.ref().child('userImage/$fileName');
      final UploadTask uploadTask = storageReference.putFile(imageFile);
      final TaskSnapshot downloadUrl = (await uploadTask);
      final String url = await downloadUrl.ref.getDownloadURL();
      print(url);
      return url;
    }
    return '';
  }
}
