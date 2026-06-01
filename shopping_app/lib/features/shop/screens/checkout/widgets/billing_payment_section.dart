import 'package:flutter/material.dart';
import 'package:shopping_app/common/widgets/custom_shapes/rounded_container.dart';
import 'package:shopping_app/common/widgets/texts/section_heading.dart';
import 'package:shopping_app/utils/constants/colors.dart';
import 'package:shopping_app/utils/constants/images.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:shopping_app/utils/helpers/helper_functions.dart';

class UBillingPaymentSection extends StatelessWidget {
  const UBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        // text - payment method
        USectionHeading(
          title: 'Payment Method',
          buttonTitle: 'Chnage',
          onPressed: () {},
        ),
        SizedBox(height: USizes.spaceBtwSections / 2),

        Row(
          children: [
            URoundedContainer(
              width: 60,
              height: 35,
              backgroundColor: dark ? UColors.light : UColors.white,
              padding: EdgeInsets.all(USizes.sm),
              child: Image(
                image: AssetImage(UImages.masterCard),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(width: USizes.spaceBtwItems),

            // payment name
            Text('Google Pay', style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ],
    );
  }
}
