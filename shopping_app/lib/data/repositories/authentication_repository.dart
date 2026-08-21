import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopping_app/data/repositories/user/user_repository.dart';
import 'package:shopping_app/features/authentication/screens/login/login.dart';
import 'package:shopping_app/features/authentication/screens/onboarding/onboarding.dart';
import 'package:shopping_app/features/authentication/screens/signup/verify_email.dart';
import 'package:shopping_app/features/personalization/controllers/user_controller.dart';
import 'package:shopping_app/navigation_menu.dart';
import 'package:shopping_app/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:shopping_app/utils/exceptions/firebase_exceptions.dart';
import 'package:shopping_app/utils/exceptions/format_exceptions.dart';
import 'package:shopping_app/utils/exceptions/platform_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final localStorage = GetStorage();
  final _auth = FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;

  @override
  void onReady() {
    FlutterNativeSplash.remove();

    // redirect screen
    screenRedirect();

// Get.put(CategoryRepository()).uploadBrandCategory(UDummyData.brandCategory);
// Get.put(CategoryRepository()).uploadProductCategory(UDummyData.productCategory);
// Get.put(ProductRepository()).uploadProducts(UDummyData.products);

    // category repository
    // Get.put(CategoryRepository()).uploadCategories(UDummyData.categories);
    // Get.put(BannerRepository()).uploadBanners(UDummyData.banner); // runs only once to upload bannes on cloudinary then comment or remove this line so that it not again and again upload data
  }

  // fucntion to redirect user to appropriate screen based on authentication status
  void screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      // check if user is verified or not
      if (user.emailVerified) {
        // if verified then go to navigation menu
        Get.offAll(() => NavigationMenu());

        // initlized user specific box
        await GetStorage.init(user.uid);

      } else {
        // if not verified then go to verify email screen
        Get.offAll(() => VerifyEmailScreen(email: user.email));
      }
    } else {
      // write isFirstTime if Null
      localStorage.writeIfNull('isFirstTime', true);
      // Check if user is first time
      localStorage.read('isFirstTime') != true
          ? Get.offAll(() => LoginScreen())
          : Get.offAll(() => OnboardingScreen());
    }
  }

  // authentication - with email & password
  Future<UserCredential> registerUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  // email authentication - sign in with email & password
  Future<UserCredential> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  // email verification - send email
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  // Logout - logout the user
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn.instance.signOut();
      Get.offAll(() => LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

Future<void> sendPasswordResetEmail(String email) async {

try {

  await _auth.sendPasswordResetEmail(email: email);

}  on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
}


  // Google Sign in

  // Future<UserCredential> signInWithGoogle() async {
  //   try {
  //     // get instance of google
  //     GoogleSignIn googleSignIn = GoogleSignIn.instance;

  //     // initialize google sign in
  //     await googleSignIn.initialize(
  //       serverClientId:
  //           "247599199257-me0l013c6o1pl1m5jun718mss3acatd9.apps.googleusercontent.com",
  //     );

  //     // create user account
  //     GoogleSignInAccount googleUser = await googleSignIn.authenticate(
  //       scopeHint: ['email'],
  //     );
  //     final googleAuth =  googleUser.authentication;
  //     // create credentails
  //     final OAuthCredential credential = GoogleAuthProvider.credential(
  //       idToken: googleAuth.idToken,

  //     );

  //     UserCredential userCredential = await _auth.signInWithCredential(
  //       credential,
  //     );

  //     return userCredential;
  //   } on FirebaseAuthException catch (e) {
  //     throw UFirebaseAuthException(e.code).message;
  //   } on FirebaseException catch (e) {
  //     throw UFirebaseException(e.code).message;
  //   } on FormatException catch (_) {
  //     throw UFormatException();
  //   } on PlatformException catch (e) {
  //     throw UPlatformException(e.code).message;
  //   } catch (e) {
  //     throw 'Something went wrong, Please try again';
  //   }
  // }

  Future<UserCredential> signInWithGoogle() async {
  try {
    debugPrint('========== GOOGLE SIGN-IN START ==========');

    // ============================================================
    // STEP 1: Get GoogleSignIn instance
    // ============================================================
    debugPrint('STEP 1: Getting GoogleSignIn instance...');

    final GoogleSignIn googleSignIn = GoogleSignIn.instance;

    debugPrint('STEP 1 SUCCESS: GoogleSignIn instance obtained');


    // ============================================================
    // STEP 2: Initialize Google Sign-In
    // ============================================================
    debugPrint('STEP 2: Initializing Google Sign-In...');

    await googleSignIn.initialize(
      serverClientId:
          "YOUR_WEB_CLIENT_ID",
    );

    debugPrint('STEP 2 SUCCESS: Google Sign-In initialized');


    // ============================================================
    // STEP 3: Check whether authentication is supported
    // ============================================================
    debugPrint('STEP 3: Checking authenticate support...');

    final bool supportsAuthenticate =
        googleSignIn.supportsAuthenticate();

    debugPrint(
      'STEP 3 RESULT: supportsAuthenticate = $supportsAuthenticate',
    );


    // ============================================================
    // STEP 4: Open Google account picker
    // ============================================================
    debugPrint('STEP 4: Opening Google account picker...');

    final GoogleSignInAccount googleUser =
        await googleSignIn.authenticate(
      scopeHint: ['email'],
    );

    debugPrint('STEP 4 SUCCESS: Google account selected');
    debugPrint('Google account email: ${googleUser.email}');
    debugPrint('Google account display name: ${googleUser.displayName}');
    debugPrint('Google account ID: ${googleUser.id}');


    // ============================================================
    // STEP 5: Get Google authentication data
    // ============================================================
    debugPrint('STEP 5: Getting Google authentication...');

    final GoogleSignInAuthentication googleAuth =
        googleUser.authentication;

    debugPrint('STEP 5 SUCCESS: Google authentication obtained');

    debugPrint(
      'ID token available: ${googleAuth.idToken != null}',
    );


    // ============================================================
    // STEP 6: Create Firebase credential
    // ============================================================
    debugPrint('STEP 6: Creating Firebase credential...');

    final OAuthCredential credential =
        GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    debugPrint('STEP 6 SUCCESS: Firebase credential created');


    // ============================================================
    // STEP 7: Sign in to Firebase
    // ============================================================
    debugPrint('STEP 7: Signing in to Firebase...');

    final UserCredential userCredential =
        await _auth.signInWithCredential(
      credential,
    );

    debugPrint('STEP 7 SUCCESS: Firebase sign-in successful');

    debugPrint(
      'Firebase UID: ${userCredential.user?.uid}',
    );

    debugPrint(
      'Firebase email: ${userCredential.user?.email}',
    );

    debugPrint('========== GOOGLE SIGN-IN SUCCESS ==========');

    return userCredential;
  }

  // ================================================================
  // GOOGLE SIGN-IN ERROR
  // ================================================================
  on GoogleSignInException catch (e, stackTrace) {
    debugPrint('========== GOOGLE SIGN-IN EXCEPTION ==========');
    debugPrint('Code: ${e.code}');
    debugPrint('Description: ${e.description}');
    debugPrint('Details: ${e.details}');
    debugPrint('StackTrace: $stackTrace');
    debugPrint('================================================');

    rethrow;
  }

  // ================================================================
  // FIREBASE AUTH ERROR
  // ================================================================
  on FirebaseAuthException catch (e, stackTrace) {
    debugPrint('========== FIREBASE AUTH EXCEPTION ==========');
    debugPrint('Code: ${e.code}');
    debugPrint('Message: ${e.message}');
    debugPrint('Email: ${e.email}');
    debugPrint('Credential: ${e.credential}');
    debugPrint('StackTrace: $stackTrace');
    debugPrint('==============================================');

    throw UFirebaseAuthException(e.code).message;
  }

  // ================================================================
  // FIREBASE GENERAL ERROR
  // ================================================================
  on FirebaseException catch (e, stackTrace) {
    debugPrint('========== FIREBASE EXCEPTION ==========');
    debugPrint('Code: ${e.code}');
    debugPrint('Message: ${e.message}');
    debugPrint('StackTrace: $stackTrace');
    debugPrint('========================================');

    throw UFirebaseException(e.code).message;
  }

  // ================================================================
  // FORMAT ERROR
  // ================================================================
  on FormatException catch (e, stackTrace) {
    debugPrint('========== FORMAT EXCEPTION ==========');
    debugPrint('Error: $e');
    debugPrint('StackTrace: $stackTrace');
    debugPrint('======================================');

    throw UFormatException();
  }

  // ================================================================
  // PLATFORM ERROR
  // ================================================================
  on PlatformException catch (e, stackTrace) {
    debugPrint('========== PLATFORM EXCEPTION ==========');
    debugPrint('Code: ${e.code}');
    debugPrint('Message: ${e.message}');
    debugPrint('Details: ${e.details}');
    debugPrint('StackTrace: $stackTrace');
    debugPrint('========================================');

    throw UPlatformException(e.code).message;
  }

  // ================================================================
  // UNKNOWN ERROR
  // ================================================================
  catch (e, stackTrace) {
    debugPrint('========== UNKNOWN GOOGLE ERROR ==========');
    debugPrint('Error: $e');
    debugPrint('Type: ${e.runtimeType}');
    debugPrint('StackTrace: $stackTrace');
    debugPrint('==========================================');

    rethrow;
  }
}

  // delete account
  Future<void> deleteAccount() async {
    try {
      // remove profile picture from cloudinary
      String publicId = UserController.instance.user.value.publicId;
      await UserRepository.instance.removeUserRecord(currentUser!.uid);
      if (publicId.isNotEmpty) {
        UserRepository.instance.deleteProfilePicture(publicId);
      }
      _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  // re-authenticate user
  Future<void> reAuthenticateUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );

      await currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
