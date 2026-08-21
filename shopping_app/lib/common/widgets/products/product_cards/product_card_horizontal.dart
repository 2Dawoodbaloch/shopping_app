import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:shopping_app/common/widgets/button/add_to_card_button.dart';
import 'package:shopping_app/common/widgets/custom_shapes/rounded_container.dart';
import 'package:shopping_app/common/widgets/images/rounded_image.dart';
import 'package:shopping_app/common/widgets/products/favourite/favourite_icon.dart';
import 'package:shopping_app/common/widgets/texts/brand_title_with_verify_icon.dart';
import 'package:shopping_app/common/widgets/texts/product_price_text.dart';
import 'package:shopping_app/common/widgets/texts/product_title_text.dart';
import 'package:shopping_app/features/shop/controllers/product/product_controller.dart';
import 'package:shopping_app/features/shop/models/product_model.dart';
import 'package:shopping_app/features/shop/screens/product_details/product_details.dart';
import 'package:shopping_app/utils/constants/colors.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:shopping_app/utils/helpers/helper_functions.dart';

class UProductCardHorizental extends StatelessWidget {
  const UProductCardHorizental({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    String? salePercentage = controller.calculateSalePercentage(
      product.price,
      product.salePrice,
    );
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailsScreen(product: product)),
      child: Container(
        width: 310,
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(USizes.productImageRadius),
          color: dark ? UColors.darkGrey : UColors.grey,
        ),
        child: Row(
          children: [
            // left portion
            URoundedContainer(
              height: 120,
              padding: EdgeInsets.all(USizes.sm),
              backgroundColor: dark ? UColors.dark : UColors.light,
              child: Stack(
                children: [
                  // thumbnail
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: URoundedImage(
                      imageUrl: product.thumbnail,
                      isNetworkImage: true,
                    ),
                  ),

                  // Discount tag
                  if (salePercentage != null)
                    Positioned(
                      top: 12.0,
                      child: URoundedContainer(
                        radius: USizes.sm,
                        backgroundColor: UColors.yellow.withValues(alpha: 0.8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: USizes.sm,
                          vertical: USizes.xs,
                        ),
                        child: Text(
                          '$salePercentage%',
                          style: Theme.of(
                            context,
                          ).textTheme.labelLarge!.apply(color: UColors.black),
                        ),
                      ),
                    ),

                  /// Favourite Button
                  Positioned(
                    right: 0,
                    top: 0,
                    child: UFavouriteIcon(productId: product.id),
                  ),
                ],
              ),
            ),

            // right portion
            /// Right Portion
            SizedBox(
              width: 172.0,

              child: Padding(
                padding: const EdgeInsets.only(left: USizes.sm, top: USizes.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Product Title
                        UProductTitleText(
                          title: product.title,
                          smallSize: true,
                        ),
                        SizedBox(height: USizes.spaceBtwItems / 2),

                        /// Product Brand
                        UBrandTitleWithVerifyIcon(title: product.brand!.name),
                      ],
                    ),
                    Spacer(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// Product Price
                        Flexible(
                          child: UProductPriceText(
                            price: controller.getProductprice(product),
                          ),
                        ),

                        // Add Button
                        ProductAddToCartButton(product: product),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
