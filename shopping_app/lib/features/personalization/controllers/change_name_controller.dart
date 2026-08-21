import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/data/repositories/user/user_repository.dart';
import 'package:shopping_app/features/personalization/controllers/user_controller.dart';
import 'package:shopping_app/utils/helpers/network_manager.dart';
import 'package:shopping_app/utils/popups/full_screen_loader.dart';
import 'package:shopping_app/utils/popups/snackbar_helpers.dart';

class ChangeNameController extends GetxController {
  static ChangeNameController get instance => Get.find();

  /// Variables
  final _userController = UserController.instance;
  final _userRepository = UserRepository.instance;

  final firstName = TextEditingController();
  final lastName = TextEditingController();

  final updateUserFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  void initializeNames() {
    firstName.text = _userController.user.value.firstName;
    lastName.text = _userController.user.value.lastName;
  }

  /// Update User Name
  Future<void> updateUserName() async {

    try {
      // Start Loading
      UFullScreenLoader.openLoadingDialog(
        'We are updating your information ... ',
      );

      // Check Internet Connectivity
      bool isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!updateUserFormKey.currentState!.validate()) {
        UFullScreenLoader.stopLoading();
        return;
      }

      // Update User Name From Fire store
      // Update User Name From Fire store
      Map<String, dynamic> map = {
        'firstName': firstName.text,
        'lastName': lastName.text,
      };
      await _userRepository.updateSingleField(map);

      // Update user from RX User
      _userController.user.value.firstName = firstName.text;
      _userController.user.value.lastName = lastName.text;

      // Stop Loading
      UFullScreenLoader.stopLoading();

      // Redirect
      // Get.offAll(() => NavigationMenu());
        Navigator.of(Get.context!).pop();


      // Success Message
      USnackBarHelpers.successSnackBar(
        title: 'Congratulations',
        message: 'Your name has been updated',
      );
      // Update user from RX User
      // Stop Loading
    } catch (e) {
      // Stop Loading
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(
        title: 'Update Name Failed!',
        message: e.toString(),
      );
    }
  }
}
