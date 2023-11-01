import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fooddelivery_fe/model/account_model.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountController extends GetxController {
  Rx<AccountModel?> accountSession = Rx<AccountModel?>(null);
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> storedUserToSharedRefererces(
      AccountModel accountResponse) async {
    final prefs = await SharedPreferences.getInstance();
    final accountJsonEncode = jsonEncode(accountResponse.toJson());
    await prefs.setString('current_account', accountJsonEncode);
  }

  Future<AccountModel?> loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('current_account') ?? '';
    if (jsonString.isNotEmpty) {
      return AccountModel.fromJson(jsonDecode(jsonString));
    }
    return null;
  }

  Future<AccountModel?> getUserFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('current_account') ?? '';
    if (jsonString.isNotEmpty) {
      return AccountModel.fromJson(jsonDecode(jsonString));
    }
    return null;
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
