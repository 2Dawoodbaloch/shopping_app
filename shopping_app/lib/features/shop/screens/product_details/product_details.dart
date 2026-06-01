import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:shopping_app/common/style/padding.dart';
import 'package:shopping_app/common/widgets/button/elevated_button.dart';
import 'package:shopping_app/common/widgets/texts/section_heading.dart';
import 'package:shopping_app/features/shop/screens/product_details/widgets/bottom_add_to_cart.dart';
import 'package:shopping_app/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:shopping_app/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:shopping_app/features/shop/screens/product_details/widgets/product_thumbnai_and%20_slider.dart';
import 'package:shopping_app/utils/constants/sizes.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // product image with slider
            UProductThmbnaiAndSlider(),

            // product details
            Padding(
              padding: UPadding.screenPadding,
              child: Column(
                children: [
                  UProductMetaData(),
                  SizedBox(height: USizes.spaceBtwSections),
                  // attribute
                  UProductAttributes(),
                  SizedBox(height: USizes.spaceBtwSections),
                  // checkout buttonsp
                  UElevatedButton(onPressed: () {}, child: Text('Checkout')),
                  SizedBox(height: USizes.spaceBtwSections),

                  // description
                  USectionHeading(title: 'Decription', showActionButton: false),
                  SizedBox(height: USizes.spaceBtwItems),

                  // description
                  ReadMoreText(
                    'This is a product of iPhone 11 with 512 GB,This is a product of iPhone 11 with 512 GB,This is a product of iPhone 11 with 512 GB',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Less',
                    moreStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                    lessStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // botton navigaytion
      bottomNavigationBar: UBottomAddToCart(),
    );
  }
}
