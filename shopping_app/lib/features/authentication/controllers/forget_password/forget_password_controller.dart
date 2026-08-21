import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import 'package:shopping_app/data/repositories/authentication_repository.dart';
import 'package:shopping_app/features/authentication/screens/forget_password/reset_password.dart';
import 'package:shopping_app/utils/helpers/network_manager.dart';
import 'package:shopping_app/utils/popups/full_screen_loader.dart';
import 'package:shopping_app/utils/popups/snackbar_helpers.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  /// Variables
  final email = TextEditingController();
  final forgetPasswordFormKey = GlobalKey<FormState>();

  /// Send Email To Forget Password
  Future<void> sendPasswordResetEmail() async {
    try {
      // start loading
      UFullScreenLoader.openLoadingDialog('Processing your request ... ');

      // Check Internet Connectivity
      bool isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        USnackBarHelpers.warningSnackBar(title: 'No Internet Connection');
        return;
      }

      // Form Validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        UFullScreenLoader.stopLoading();
        return;
      }

      // Send Email To Reset Password
      AuthenticationRepository.instance.sendPasswordResetEmail(email.text);

      // Success Message
      USnackBarHelpers.successSnackBar(
        title: "Email Sent",
        message: 'Email Link Sent to Reset Your Password',
      );

      // Redirect
      Get.to(() => ResetPassword(email: email.text.trim()));
    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(
        title: 'Failed Forget Password',
        message: e.toString(),
      );
    }
  }



   /// reSend Email To Forget Password
  Future<void> reSendPasswordResetEmail() async {
    try {
      // start loading
      UFullScreenLoader.openLoadingDialog('Processing your request ... ');

      // Check Internet Connectivity
      bool isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        USnackBarHelpers.warningSnackBar(title: 'No Internet Connection');
        return;
      }

      // Form Validation

      // Send Email To Reset Password
      AuthenticationRepository.instance.sendPasswordResetEmail(email.text);

      // Success Message
      USnackBarHelpers.successSnackBar(
        title: "Email Sent",
        message: 'Email Link Sent to Reset Your Password',
      );

    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(
        title: 'Failed Forget Password',
        message: e.toString(),
      );
    }
  }
}
