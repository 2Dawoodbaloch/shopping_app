import 'package:flutter/material.dart';
import 'package:shopping_app/common/widgets/chips/choice_chip.dart';
import 'package:shopping_app/common/widgets/custom_shapes/rounded_container.dart';
import 'package:shopping_app/common/widgets/texts/product_price_text.dart';
import 'package:shopping_app/common/widgets/texts/product_title_text.dart';
import 'package:shopping_app/common/widgets/texts/section_heading.dart';
import 'package:shopping_app/utils/constants/colors.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:shopping_app/utils/helpers/helper_functions.dart';

class UProductAttributes extends StatelessWidget {
  const UProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        // selected attributes pricing and descriptions
        URoundedContainer(
          padding: EdgeInsets.all(USizes.md),
          backgroundColor: dark ? UColors.darkGrey : UColors.grey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // title , price & stock
              Row(
                children: [
                  // text - variation and heading
                  USectionHeading(title: 'Variation', showActionButton: false),
                  SizedBox(width: USizes.spaceBtwItems),

                  Column(
                    children: [
                      // price, sale price, actual price
                      Row(
                        children: [
                          // text - price
                          UProductTitleText(title: 'Price', smallSize: true),

                          // actual Price
                          Text(
                            '250',
                            style: Theme.of(context).textTheme.titleSmall!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                          SizedBox(width: USizes.spaceBtwItems),

                          // sale price
                          UProductPriceText(price: '200'),
                        ],
                      ),

                      // stock status
                      Row(
                        children: [
                          UProductTitleText(title: 'Stock : ', smallSize: true),
                          Text(
                            'In Stock',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              // attributes description
              UProductTitleText(
                title: 'This is a product of iPhone 11 with 512 GB',
                smallSize: true,
                maxLines: 4,
              ),
            ],
          ),
        ),
        SizedBox(height: USizes.spaceBtwItems),

        // attributes - colors
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            USectionHeading(title: 'Colors', showActionButton: false),
            SizedBox(height: USizes.spaceBtwItems / 2),
            Wrap(
              spacing: USizes.sm,
              children: [
                UChoiceChip(
                  text: "Red",
                  selected: true,
                  onSelected: (value) {},
                ),
                UChoiceChip(
                  text: "Blue",
                  selected: false,
                  onSelected: (value) {},
                ),
                UChoiceChip(
                  text: "Yellow",
                  selected: false,
                  onSelected: (value) {},
                ),
              ],
            ),
          ],
        ),

        // attributes - sizes
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            USectionHeading(title: 'Sizes', showActionButton: false),
            SizedBox(height: USizes.spaceBtwItems / 2),
            Wrap(
              spacing: USizes.sm,
              children: [
                UChoiceChip(
                  text: "Small",
                  selected: true,
                  onSelected: (value) {},
                ),
                UChoiceChip(
                  text: "Medium",
                  selected: false,
                  onSelected: (value) {},
                ),
                UChoiceChip(
                  text: "Large",
                  selected: false,
                  onSelected: (value) {},
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
