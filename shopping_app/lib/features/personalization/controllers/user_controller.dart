import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shopping_app/data/repositories/user/user_repository.dart';
import 'package:shopping_app/features/authentication/models/user_model.dart';
import 'package:shopping_app/utils/popups/snackbar_helpers.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final _userRepository = Get.put(UserRepository());

  // variables

  Future<void> saveUserRecord(UserCredential userCredential) async {
    try {
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
    } catch (e) {
      USnackBarHelpers.warningSnackBar(
        title: 'Data not saved',
        message: 'something went wrong while saving',
      );
    }
  }
}
