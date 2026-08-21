import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shopping_app/common/widgets/login_signup/success_screen.dart';
import 'package:shopping_app/data/repositories/authentication_repository.dart';
import 'package:shopping_app/utils/constants/images.dart';
import 'package:shopping_app/utils/constants/texts.dart';
import 'package:shopping_app/utils/popups/snackbar_helpers.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  // variable

  // send email verification link to current user
  Future<void> sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      USnackBarHelpers.successSnackBar(
        title: 'Email Sent',
        message: 'Please check your inbox and verify your email',
      );
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  void setTimerForAutoRedirect() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      FirebaseAuth.instance.currentUser!.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(
          () => SuccessScreen(
            title: UTexts.accountCreatedTitle,
            subTitle: UTexts.accountCreatedSubTitle,
            image: UImages.successfulPaymentIcon,
            onTap: () => AuthenticationRepository.instance.screenRedirect(),
          ),
        );
      }
    });
  }

  // manually check email verification status when user clicks continue button
  Future<void> checkEmailVerificationStatus() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null && currentUser.emailVerified) {
        Get.off(
          () => SuccessScreen(
            title: UTexts.accountCreatedTitle,
            subTitle: UTexts.accountCreatedSubTitle,
            image: UImages.successfulPaymentIcon,
            onTap: () => AuthenticationRepository.instance.screenRedirect(),
          ),
        );
      } else {
        USnackBarHelpers.errorSnackBar(
          title: 'Email Not Verified',
          message: 'Please verify your email and try again.',
        );
      }
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}
