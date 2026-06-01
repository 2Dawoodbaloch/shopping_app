import 'package:flutter/material.dart';
import 'package:shopping_app/common/widgets/texts/section_heading.dart';
import 'package:shopping_app/utils/constants/colors.dart';
import 'package:shopping_app/utils/constants/sizes.dart';

class UBillingAddressSection extends StatelessWidget {
  const UBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TEXt - billing address
        USectionHeading(
          title: 'Billing Address',
          buttonTitle: 'Change',
          onPressed: () {},
        ),
        Text('Unkown Pro', style: Theme.of(context).textTheme.titleLarge),
        SizedBox(height: USizes.spaceBtwItems / 2),

        Row(
          children: [
            Icon(Icons.phone, size: USizes.iconSm, color: UColors.darkerGrey),
            SizedBox(width: USizes.spaceBtwItems),
            Text('+92 233845704'),
          ],
        ),
        SizedBox(height: USizes.spaceBtwItems / 2),

        Row(
          children: [
            Icon(
              Icons.location_history,
              size: USizes.iconSm,
              color: UColors.darkerGrey,
            ),
            SizedBox(width: USizes.spaceBtwItems),
            Expanded(
              child: Text(
                'House NO.295, Hyderabad, Sindh, Pakistan',
                softWrap: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
