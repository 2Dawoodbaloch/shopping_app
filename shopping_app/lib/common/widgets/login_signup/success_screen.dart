import 'package:flutter/material.dart';
import 'package:shopping_app/common/style/padding.dart';
import 'package:shopping_app/common/widgets/button/elevated_button.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:shopping_app/utils/constants/texts.dart';
import 'package:shopping_app/utils/helpers/device_helpers.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    required this.title,
    required this.subTitle,
    required this.image,
    required this.onTap,
  });
  final String title, subTitle, image;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              // images
              Image.asset(
                image,
                height: UDeviceHelper.getScreenHeight(context) * 0.6,
              ),
              SizedBox(height: USizes.spaceBtwItems),

              ///title
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: USizes.spaceBtwItems),

              ///email
              // Text(
              //   'unknownpro@gmail.com',
              //   style: Theme.of(context).textTheme.bodyMedium,
              // ),
              // SizedBox(height: USizes.spaceBtwItems),

              ///subtitle
              Text(
                subTitle,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: USizes.spaceBtwItems),

              ///continue
              UElevatedButton(onPressed: onTap, child: Text(UTexts.uContinue)),
              SizedBox(height: USizes.spaceBtwItems),
            ],
          ),
        ),
      ),
    );
  }
}
