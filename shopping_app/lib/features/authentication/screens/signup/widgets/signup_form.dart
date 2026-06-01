import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_app/common/widgets/button/elevated_button.dart';
import 'package:shopping_app/features/authentication/controllers/singup/signup_controller.dart';
import 'package:shopping_app/features/authentication/screens/signup/verify_email.dart';
import 'package:shopping_app/features/authentication/screens/signup/widgets/privacy_policy_checkbox.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:shopping_app/utils/constants/texts.dart';
import 'package:shopping_app/utils/validators/validation.dart';

class USignupForm extends StatelessWidget {
  const USignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.Instance;
    return Form(
      key: controller.signUpFormKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      UValidator.validateEmptyText('First Name', value),
                  decoration: InputDecoration(
                    labelText: UTexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              SizedBox(width: USizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      UValidator.validateEmptyText('Last Name', value),
                  decoration: InputDecoration(
                    labelText: UTexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: USizes.spaceBtwInputFields),

          //email
          TextFormField(
            controller: controller.email,
            validator: (value) => UValidator.validateEmail(value),
            decoration: InputDecoration(
              labelText: UTexts.email,
              prefixIcon: Icon(Iconsax.direct_right),
            ),
          ),
          SizedBox(height: USizes.spaceBtwInputFields),
          //phone Number
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => UValidator.validatePhoneNumber(value),
            decoration: InputDecoration(
              labelText: UTexts.phoneNumber,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          SizedBox(height: USizes.spaceBtwInputFields),
          //password
          Obx(
            () => TextFormField(
              obscureText: controller.isPasswordVisible.value,
              controller: controller.password,
              validator: (value) => UValidator.validatePassword(value),
              decoration: InputDecoration(
                labelText: UTexts.password,
                prefixIcon: Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () => controller.isPasswordVisible.value =
                      !controller.isPasswordVisible.value,
                  icon: Icon(
                    controller.isPasswordVisible.value
                        ? Iconsax.eye
                        : Iconsax.eye_slash,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: USizes.spaceBtwInputFields / 2),
          // privacy policy checkbox
          // UPrivacyPolicyCheckBox(),
          SizedBox(height: USizes.spaceBtwItems),

          //create user account
          UElevatedButton(
            onPressed: () {
              controller.registerUser();
              // Get.to(() => VerifyEmailScreen());
            },
            child: Text(UTexts.createAccount),
          ),
        ],
      ),
    );
  }
}
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:shopping_app/common/widgets/button/elevated_button.dart';
// import 'package:shopping_app/features/authentication/screens/signup/widgets/privacy_policy_checkbox.dart';
// import 'package:shopping_app/utils/constants/sizes.dart';
// import 'package:shopping_app/utils/constants/texts.dart';

// class SimpleSignupForm extends StatefulWidget {
//   const SimpleSignupForm({super.key});

//   @override
//   State<SimpleSignupForm> createState() => _SimpleSignupFormState();
// }

// class _SimpleSignupFormState extends State<SimpleSignupForm> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _firstNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   final _phoneController = TextEditingController();
//   bool _isLoading = false;
//   bool _obscurePassword = true;

//   Future<void> _register() async {
//     // Basic validation (non‑empty)
//     if (_emailController.text.trim().isEmpty ||
//         _passwordController.text.isEmpty ||
//         _firstNameController.text.trim().isEmpty ||
//         _lastNameController.text.trim().isEmpty) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
//       return;
//     }

//     setState(() => _isLoading = true);

//     try {
//       UserCredential userCredential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(
//             email: _emailController.text.trim(),
//             password: _passwordController.text,
//           );
//       // Optionally update display name
//       await userCredential.user?.updateDisplayName(
//         '${_firstNameController.text.trim()} ${_lastNameController.text.trim()}',
//       );
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Account created! Check email verification.'),
//           ),
//         );
//         // Navigate to login or home
//         Navigator.of(context).pushReplacementNamed('/login');
//       }
//     } on FirebaseAuthException catch (e) {
//       String message = 'Registration failed';
//       if (e.code == 'email-already-in-use') {
//         message = 'Email already in use';
//       } else if (e.code == 'weak-password') {
//         message = 'Password too weak (min 6 characters)';
//       } else if (e.code == 'invalid-email') {
//         message = 'Invalid email address';
//       }
//       if (mounted) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text(message)));
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text('Error: $e')));
//       }
//     } finally {
//       if (mounted) setState(() => _isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: TextFormField(
//                   controller: _firstNameController,
//                   decoration: const InputDecoration(
//                     labelText: UTexts.firstName,
//                     prefixIcon: Icon(Iconsax.user),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: USizes.spaceBtwInputFields),
//               Expanded(
//                 child: TextFormField(
//                   controller: _lastNameController,
//                   decoration: const InputDecoration(
//                     labelText: UTexts.lastName,
//                     prefixIcon: Icon(Iconsax.user),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: USizes.spaceBtwInputFields),
//           TextFormField(
//             controller: _emailController,
//             decoration: const InputDecoration(
//               labelText: UTexts.email,
//               prefixIcon: Icon(Iconsax.direct_right),
//             ),
//           ),
//           const SizedBox(height: USizes.spaceBtwInputFields),
//           TextFormField(
//             controller: _phoneController,
//             decoration: const InputDecoration(
//               labelText: UTexts.phoneNumber,
//               prefixIcon: Icon(Iconsax.call),
//             ),
//           ),
//           const SizedBox(height: USizes.spaceBtwInputFields),
//           TextFormField(
//             controller: _passwordController,
//             obscureText: _obscurePassword,
//             decoration: InputDecoration(
//               labelText: UTexts.password,
//               prefixIcon: const Icon(Iconsax.password_check),
//               suffixIcon: IconButton(
//                 onPressed: () =>
//                     setState(() => _obscurePassword = !_obscurePassword),
//                 icon: Icon(_obscurePassword ? Iconsax.eye : Iconsax.eye_slash),
//               ),
//             ),
//           ),
//           const SizedBox(height: USizes.spaceBtwInputFields / 2),
//           const UPrivacyPolicyCheckBox(),
//           const SizedBox(height: USizes.spaceBtwItems),
//           UElevatedButton(
//             onPressed: _register,
//             child: const Text(UTexts.createAccount),
//           ),
//         ],
//       ),
//     );
//   }
// }
