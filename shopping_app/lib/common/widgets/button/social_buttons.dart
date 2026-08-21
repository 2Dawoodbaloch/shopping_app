import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/features/authentication/controllers/login/login_controller.dart';
import 'package:shopping_app/utils/constants/images.dart';
import 'package:shopping_app/utils/constants/sizes.dart';

class USocialButtons extends StatelessWidget {
  const USocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildButton(UImages.googleIcon, controller.googleSignIn),
        SizedBox(width: USizes.spaceBtwItems),
        buildButton(UImages.facebookIcon, () {}),
      ],
    );
  }

  Container buildButton(String image, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Image.asset(image, height: USizes.iconMd, width: USizes.iconMd),
      ),
    );
  }
}
