import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping_app/data/repositories/authentication_repository.dart';
import 'package:shopping_app/data/repositories/user/user_repository.dart';
import 'package:shopping_app/features/authentication/models/user_model.dart';
import 'package:shopping_app/features/authentication/screens/login/login.dart';
import 'package:shopping_app/features/personalization/screens/edit_profile/widgets/re_authenticate_screen.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:shopping_app/utils/helpers/network_manager.dart';
import 'package:shopping_app/utils/popups/full_screen_loader.dart';
import 'package:shopping_app/utils/popups/snackbar_helpers.dart';
import 'package:dio/dio.dart' as dio;

class UserController extends GetxController {
  static UserController get instance => Get.find();

  // variables
  final _userRepository = Get.put(UserRepository());
  Rx<UserModel> user = UserModel.empty().obs;
  RxBool profileLoading = false.obs;

  // Re-authenticate variables
  final email = TextEditingController();
  final password = TextEditingController();
  final reAuthFormKey = GlobalKey<FormState>();
  RxBool isPasswordVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserDetails();
  }

  //save user record
  Future<void> saveUserRecord(UserCredential userCredential) async {
    try {
      await fetchUserDetails();
      if (user.value.id.isEmpty) {
        // convert full name to first and last name
        final nameParts = UserModel.nameParts(userCredential.user!.displayName);
        final username = '${userCredential.user!.displayName}2312637';

        // create user model
        UserModel user = UserModel(
          id: userCredential.user!.uid,
          firstName: nameParts[0],
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
          username: username,
          email: userCredential.user!.email ?? '',
          phoneNumber: userCredential.user!.phoneNumber ?? '',
          profilePicture: userCredential.user!.photoURL ?? '',
        );

        // save user record
        await _userRepository.saveUserRecord(user);
      }
    } catch (e) {
      USnackBarHelpers.warningSnackBar(
        title: 'Data not saved',
        message: 'something went wrong while saving',
      );
    }
  }

  // FUNCTION TO FETCH USER BASED ON CURRENT USER
  Future<void> fetchUserDetails() async {
    try {
      profileLoading.value = true;
      UserModel user = await UserRepository.instance.fetchUserRecord();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // delete account popup
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: EdgeInsets.all(USizes.md),
      title: 'Delete Account',
      middleText: 'Are you sure you want to delete account permanently?',
      confirm: ElevatedButton(
        onPressed: () => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: BorderSide(color: Colors.red),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: USizes.lg),
          child: Text('Delete'),
        ),
      ), // Padding, ElevatedButton
      cancel: OutlinedButton(
        onPressed: () => Get.back(),
        child: Text('Cancel'),
      ),
    );
  }

  //delete user account
  Future<void> deleteUserAccount() async {
    try {
      // Start Loading
      UFullScreenLoader.openLoadingDialog('Processing ... ');

      // Re-Authentication User
      final authRepository = AuthenticationRepository.instance;
      final provider = authRepository.currentUser!.providerData
          .map((e) => e.providerId)
          .first;

      // If Google Provider
      if (provider == 'google.com') {
        await authRepository.signInWithGoogle();
        await authRepository.deleteAccount();
        UFullScreenLoader.stopLoading();
        Get.offAll(() => LoginScreen());

        // If Email/Password Provider
      } else if (provider == 'password') {
        UFullScreenLoader.stopLoading();
        Get.to(() => ReAuthenticateScreen());
      }
    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(title: "error", message: e.toString());
    }
  }

  // re-authenticate user with email and password
  Future<void> reAuthenticateUser() async {
    try {
      // Start Loading
      UFullScreenLoader.openLoadingDialog('Processing ... ');

      // Check Internet Connectivity
      bool isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        return;
      }
      // Form Validation
      if (!reAuthFormKey.currentState!.validate()) {
        UFullScreenLoader.stopLoading();
        return;
      }
      // Re Authenticate User with email and password
      await AuthenticationRepository.instance
          .reAuthenticateUserWithEmailAndPassword(
            email.text.trim(),
            password.text.trim(),
          );

      // delete account
      AuthenticationRepository.instance.deleteAccount();

      // stop loading
      UFullScreenLoader.stopLoading();

      // redirect user
      Get.offAll(() => LoginScreen());
    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(title: 'Failed', message: e.toString());
    }
  }

  Future<void> updateUserProfilePicture() async {
    try {
      // Pick Image From Gallery
      XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 512,
        maxWidth: 512,
      );
      if (image == null) return;

      // Convert XFile to File
      File file = File(image.path);

      // delete user current profile picture
      if (user.value.publicId.isNotEmpty) {
        await _userRepository.deleteProfilePicture(user.value.publicId);

        // Upload profile Picture To Cloudinary
        dio.Response response = await _userRepository.uploadImage(file);
        if (response.statusCode == 200) {
          // Get Data
          final data = response.data;
          final imageUrl = data['url'];
          final publicId = data['public_id'];

          // update profile picture from Fire store
          await _userRepository.updateSingleField({
            'profilePicture': imageUrl,
            'publicId': publicId,
          });

          // update profile and publicId from RX User
          user.value.profilePicture = imageUrl;
          user.value.publicId = publicId;
          user.refresh();

          //Success Message
          USnackBarHelpers.successSnackBar(
            title: 'Congratulation',
            message: 'Profile picture updated successfully',
          );
        }
      } else {
        throw 'Failed to upload profile picture. Please try again';
      }
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: "Failed", message: e.toString());
    }
  }
}
