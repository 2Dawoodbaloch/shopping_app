import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:shopping_app/common/style/padding.dart';
import 'package:shopping_app/common/widgets/button/elevated_button.dart';
import 'package:shopping_app/common/widgets/texts/section_heading.dart';
import 'package:shopping_app/features/shop/models/product_model.dart';
import 'package:shopping_app/features/shop/screens/product_details/widgets/bottom_add_to_cart.dart';
import 'package:shopping_app/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:shopping_app/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:shopping_app/features/shop/screens/product_details/widgets/product_thumbnail_and_slider.dart';
import 'package:shopping_app/utils/constants/enums.dart';
import 'package:shopping_app/utils/constants/sizes.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // product image with slider
            UProductThmbnaiAndSlider(product: product),

            // product details
            Padding(
              padding: UPadding.screenPadding,
              child: Column(
                children: [
                  UProductMetaData(product: product),
                  SizedBox(height: USizes.spaceBtwSections),

                  /// Attributes
                  if (product.productType ==
                      ProductType.variable.toString()) ...[
                    UProductAttributes(product: product,),
                    SizedBox(height: USizes.spaceBtwSections),
                  ],
                  // checkout buttonsp
                  UElevatedButton(onPressed: () {}, child: Text('Checkout')),
                  SizedBox(height: USizes.spaceBtwSections),

                  // description
                  USectionHeading(title: 'Decription', showActionButton: false),
                  SizedBox(height: USizes.spaceBtwItems),

                  // description
                  ReadMoreText(
                    product.description ?? '',
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
      bottomNavigationBar: UBottomAddToCart(product: product),
    );
  }
}
