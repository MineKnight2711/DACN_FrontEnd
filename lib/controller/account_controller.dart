import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fooddelivery_fe/api/account/account_api.dart';
import 'package:fooddelivery_fe/model/account_model.dart';
import 'package:fooddelivery_fe/model/address_model.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountController extends GetxController {
  Rx<AccountModel?> accountSession = Rx<AccountModel?>(null);
  User? user = FirebaseAuth.instance.currentUser;
  late AccountApi _accountApi;
  Rx<AddressModel?> selectedAddress = Rx<AddressModel?>(null);
  @override
  void onInit() {
    super.onInit();
    _accountApi = AccountApi();
    getCurrentSelectedAddress();
  }

  Future<void> fetchCurrentUser() async {
    if (accountSession.value != null) {
      final responseBaseModel =
          await _accountApi.login("${accountSession.value?.email}");
      if (responseBaseModel?.message == "Success") {
        accountSession.value = AccountModel.fromJson(responseBaseModel?.data);
        await storedUserToSharedRefererces(
            AccountModel.fromJson(responseBaseModel?.data));
        accountSession.value = await getUserFromSharedPreferences();
      }
    }
  }

  Future<void> storedUserToSharedRefererces(
      AccountModel accountResponse) async {
    final prefs = await SharedPreferences.getInstance();

    final accountJsonEncode = jsonEncode(accountResponse.toJson());
    await prefs.setString("current_account", accountJsonEncode);
  }

  Future<AccountModel?> getUserFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('current_account') ?? '';
    if (jsonString.isNotEmpty) {
      return AccountModel.fromJson(jsonDecode(jsonString));
    }
    return null;
  }

  Future<void> saveSelectedAddress() async {
    if (selectedAddress.value != null) {
      await SharedPreferences.getInstance().then((prefs) {
        final addressToJson =
            jsonEncode(selectedAddress.value?.toAddressOnlyJson());
        prefs.setString("current_address", addressToJson);
      });
    }
  }

  Future<void> getCurrentSelectedAddress() async {
    final prefs = await SharedPreferences.getInstance();
    String addressToJson = prefs.getString("current_address") ?? "";
    if (addressToJson.isNotEmpty) {
      selectedAddress.value = AddressModel.fromJson(jsonDecode(addressToJson));
    }
  }

  Future logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('current_account');
    accountSession.value = null;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
      FirebaseAuth.instance.authStateChanges();
      FirebaseAuth.instance.userChanges();
    }
    bool isSignin = await GoogleSignIn().isSignedIn();
    if (isSignin) {
      GoogleSignIn().signOut();
    }
    // MainController.destroyControllers();
  }
}
