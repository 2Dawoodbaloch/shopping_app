import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/common/widgets/button/social_buttons.dart';
import 'package:shopping_app/common/widgets/login_signup/form_divider.dart';
import 'package:shopping_app/features/authentication/controllers/login/login_controller.dart';
import 'package:shopping_app/features/authentication/screens/login/widgets/login_form.dart';
import 'package:shopping_app/features/authentication/screens/login/widgets/login_header.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:shopping_app/utils/constants/texts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  
  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(USizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ULoginHeader(),
              SizedBox(height: USizes.spaceBtwSections),

              // Form
              ULoginForm(),
              SizedBox(height: USizes.spaceBtwSections),

              ///............ Divider ...............
              UFormDivider(title: UTexts.orSignInWith),
              SizedBox(height: USizes.spaceBtwSections),

              /// social buttons
              USocialButtons(),
              
          
            ],
          ),
        ),
      ),
    );
  }
}
