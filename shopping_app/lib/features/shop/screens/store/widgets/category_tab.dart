import 'package:flutter/material.dart';
import 'package:shopping_app/common/widgets/brands/brand_showcase.dart';
import 'package:shopping_app/common/widgets/layouts/grid_layout.dart';
import 'package:shopping_app/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:shopping_app/common/widgets/texts/section_heading.dart';
import 'package:shopping_app/utils/constants/images.dart';
import 'package:shopping_app/utils/constants/sizes.dart';

class UCategoryTab extends StatelessWidget {
  const UCategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: USizes.defaultSpace),
          child: Column(
            children: [
              UBrandShowCase(
                images: [
                  UImages.productImage47,
                  UImages.productImage17,
                  UImages.productImage10,
                ],
              ),
              UBrandShowCase(
                images: [
                  UImages.productImage47,
                  UImages.productImage17,
                  UImages.productImage10,
                ],
              ),
              SizedBox(height: USizes.spaceBtwItems),
              USectionHeading(title: 'You might like', onPressed: () {}),
              UGridLayout(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return UProductCardVertical();
                },
              ),

              SizedBox(height: USizes.spaceBtwSections),
            ],
          ),
        ),
      ],
    );
  }
}
