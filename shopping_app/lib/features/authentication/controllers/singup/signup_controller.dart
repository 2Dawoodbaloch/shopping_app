import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shopping_app/data/repositories/authentication_repository.dart';
import 'package:shopping_app/data/repositories/user/user_repository.dart';
import 'package:shopping_app/features/authentication/models/user_model.dart';
import 'package:shopping_app/features/authentication/screens/signup/verify_email.dart';
import 'package:shopping_app/utils/helpers/network_manager.dart';
import 'package:shopping_app/utils/popups/full_screen_loader.dart';
import 'package:shopping_app/utils/popups/snackbar_helpers.dart';

class SignupController extends GetxController {
  // static SignupController get Instance => Get.find();

  // Varibale
  final _authRepository = Get.put(AuthenticationRepository());
  final signUpFormKey = GlobalKey<FormState>();
  RxBool isPasswordVisible = false.obs;
  RxBool privacyPolicy = false.obs;

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();

  //function to register the user with email and password
  Future<void> registerUser() async {
    try {
      // start loading
      UFullScreenLoader.openLoadingDialog(
        'We are Processing your information...',
      );

      // check Internet Connectivity
      bool isConnected = await Get.put(NetworkManager()).isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        USnackBarHelpers.warningSnackBar(title: 'No Internet Connection');
        return;
      }

      // Check Privacy Policy
      // if (!privacyPolicy.value) {
      //   UFullScreenLoader.stopLoading();
      //   USnackBarHelpers.warningSnackBar(
      //     title: 'Accept Privacy Policy',
      //     message: 'In order to create account you must accept privacy policy',
      //   );
      //   return;
      // }

      // form validation
      if (!signUpFormKey.currentState!.validate()) {
        UFullScreenLoader.stopLoading(); // ✅ close dialog
        return;
      }
      

      // Resgister user using firebase
      UserCredential userCredential = await _authRepository.registerUser(
        email.text.trim(),
        password.text.trim(),
      );

      // create user model
      UserModel userModel = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text,
        lastName: lastName.text,
        username: '${firstName.text}${lastName.text}716283',
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      // save user record
      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(userModel);

      // success message
      USnackBarHelpers.successSnackBar(
        title: 'Congratulation!',
        message: 'Your account has been created! Verfiy email to continue',
      );
      // stop loading
      UFullScreenLoader.stopLoading();

      // redirect to verify email screen
      Get.to(() => VerifyEmailScreen(email: email.text));
    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}
