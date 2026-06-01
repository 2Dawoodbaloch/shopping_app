import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_app/common/widgets/button/elevated_button.dart';
import 'package:shopping_app/features/authentication/controllers/login/login_controller.dart';
import 'package:shopping_app/features/authentication/screens/forget_password/forget_password.dart';
import 'package:shopping_app/features/authentication/screens/signup/signup.dart';
import 'package:shopping_app/navigation_menu.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:shopping_app/utils/constants/texts.dart';
import 'package:shopping_app/utils/validators/validation.dart';

class ULoginForm extends StatelessWidget {
  const ULoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = LoginController.instance;
    return Form(
      key: controller.loginFormKey,
      child: Column(
        children: [
          /// email
          TextFormField(
            controller: controller.email,
            validator: (value) => UValidator.validateEmail(value),
            decoration: InputDecoration(
              prefixIcon: Icon(Iconsax.direct_right),
              labelText: UTexts.email,
            ),
          ),
          SizedBox(height: USizes.spaceBtwInputFields),

          /// password
          Obx(
            () => TextFormField(
              controller: controller.password,
              validator: (value) =>
                  UValidator.validateEmptyText('Password', value),
              obscureText: controller.isPasswordVisible.value,
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.lock),

                suffixIcon: IconButton(
                  icon: Icon(
                    controller.isPasswordVisible.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                  ),
                  onPressed: () {
                    controller.isPasswordVisible.toggle();
                  },
                ),
              ),
            ),
          ),

          SizedBox(height: USizes.spaceBtwInputFields / 2),

          /// remember me
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Checkbox(
                  value: controller.rememberMe.value,
                  onChanged: (value) {
                    controller.rememberMe.toggle();
                  },
                ),
              ),
              Text(UTexts.rememberMe),

              /// forgotten password
              TextButton(
                onPressed: () {
                  Get.to(() => ForgetPassword());
                },
                child: Text(UTexts.forgetPassword),
              ),
            ],
          ),
          SizedBox(height: USizes.spaceBtwSections),

          /// sign In
          UElevatedButton(
            onPressed: controller.loginWithEMailAndPassword,
            child: Text(UTexts.signIn),
          ),
          SizedBox(height: USizes.spaceBtwItems / 2),

          /// Create Account
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                Get.to(SignUpScreen());
              },
              child: Text(UTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
