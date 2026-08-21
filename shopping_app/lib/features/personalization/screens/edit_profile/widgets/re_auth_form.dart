import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_app/common/widgets/button/elevated_button.dart';
import 'package:shopping_app/features/personalization/controllers/user_controller.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:shopping_app/utils/constants/texts.dart';
import 'package:shopping_app/utils/validators/validation.dart';

class ReAuthForm extends StatelessWidget {
  const ReAuthForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Form(
      key: controller.reAuthFormKey,
      child: Column(
        children: [
          /// email
          TextFormField(
            controller: controller.email,
            validator: UValidator.validateEmail,
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
                labelText: UTexts.password,
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

          SizedBox(height: USizes.spaceBtwSections),

          /// sign In
          UElevatedButton(
            onPressed: controller.reAuthenticateUser,
            child: Text("Verify"),
          ),
          SizedBox(height: USizes.spaceBtwItems / 2),
        ],
      ),
    );
  }
}
