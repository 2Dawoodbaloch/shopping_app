import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shopping_app/common/style/padding.dart';
import 'package:shopping_app/common/widgets/button/elevated_button.dart';
import 'package:shopping_app/features/authentication/screens/login/login.dart';
import 'package:shopping_app/utils/constants/images.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:shopping_app/utils/constants/texts.dart';
import 'package:shopping_app/utils/helpers/device_helpers.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.offAll(() => LoginScreen()),
            icon: Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              // images
              Image.asset(
                UImages.mailSentImage,
                height: UDeviceHelper.getScreenHeight(context) * 0.6,
              ),
              SizedBox(height: USizes.spaceBtwItems),

              ///title
              Text(
                UTexts.resetPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: USizes.spaceBtwItems),

              ///email
              Text(
                'unknownpro@gmail.com',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: USizes.spaceBtwItems),

              ///subtitle
              Text(
                UTexts.resetPasswordSubTitle,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: USizes.spaceBtwItems),

              ///done
              UElevatedButton(onPressed: () {}, child: Text(UTexts.done)),
              SizedBox(height: USizes.spaceBtwItems),

              ///resend email
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  child: Text(UTexts.resendEmail),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
