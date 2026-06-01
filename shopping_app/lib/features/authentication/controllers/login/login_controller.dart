import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shopping_app/data/repositories/user/user_repository.dart';
import 'package:shopping_app/features/authentication/models/user_model.dart';
import 'package:shopping_app/features/personalization/controllers/user_controller.dart';
import 'package:shopping_app/utils/constants/keys.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopping_app/data/repositories/authentication_repository.dart';
import 'package:shopping_app/utils/helpers/network_manager.dart';
import 'package:shopping_app/utils/popups/full_screen_loader.dart';
import 'package:shopping_app/utils/popups/snackbar_helpers.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  // variables
  final _userController = Get.put(UserController());
  final email = TextEditingController();
  final password = TextEditingController();
  RxBool isPasswordVisible = false.obs;
  RxBool rememberMe = false.obs;
  final loginFormKey = GlobalKey<FormState>();

  final localStorage = GetStorage();

  @override
  void onInit() {
    // check if user has previously logged in with remember me checked
    email.text = localStorage.read(UKeys.rememberMeEmail) ?? '';
    password.text = localStorage.read(UKeys.rememberMePassword) ?? '';
    super.onInit();
  }

  // check if user has previously logged in with remember me checked
  Future<void> loginWithEMailAndPassword() async {
    try {
      // start loading
      UFullScreenLoader.openLoadingDialog('Logging you in...');

      // check Internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        USnackBarHelpers.warningSnackBar(
          title: 'No Internet',
          message: 'Please check your internet connection and try again',
        );
        return;
      }

      if (!loginFormKey.currentState!.validate()) {
        UFullScreenLoader.stopLoading();
        return;
      }

      // save data if remember me is checked
      if (rememberMe.value) {
        localStorage.write(UKeys.rememberMeEmail, email.text.trim());
        localStorage.write(UKeys.rememberMePassword, password.text.trim());
      }

      // login User with email and password
      await AuthenticationRepository.instance.loginWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      // stop loading
      UFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      // stop loading
      UFullScreenLoader.stopLoading();

      // show error message
      USnackBarHelpers.errorSnackBar(
        title: 'Login Failed',
        message: e.toString(),
      );
    }
  }

  /// Google Sign in
  Future<void> googleSignIn() async {
    try {
      // start loading
      UFullScreenLoader.openLoadingDialog('Logging you in...');

      // check Internet connectivity
      final isConnected = await Get.put(NetworkManager()).isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        USnackBarHelpers.warningSnackBar(
          title: 'No Internet',
          message: 'Please check your internet connection and try again',
        );
        print("No Internet Connection");
        return;
      }

      // google authentication
      UserCredential userCredential = await AuthenticationRepository.instance
          .signInWithGoogle();

      // save user Record
      await _userController.saveUserRecord(userCredential);
      // stop loading
      UFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      // stop loading
      UFullScreenLoader.stopLoading();
      print("Google Sign-In Error: $e");
      // show error message
      USnackBarHelpers.errorSnackBar(
        title: 'Login Failed',
        message: e.toString(),
      );
    }
  }
}
