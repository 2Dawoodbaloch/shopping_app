import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_app/common/widgets/icons/circular_icon.dart';
import 'package:shopping_app/features/shop/controllers/cart/cart_controller.dart';
import 'package:shopping_app/features/shop/models/product_model.dart';
import 'package:shopping_app/utils/constants/colors.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:shopping_app/utils/helpers/helper_functions.dart';

class UBottomAddToCart extends StatelessWidget {
  const UBottomAddToCart({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    final controller = CartController.instance;
    controller.updateAlreadyAddedProductCount(product); 
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: USizes.defaultSpace,
        vertical: USizes.defaultSpace / 2,
      ),
      decoration: BoxDecoration(
        color: dark ? UColors.darkGrey : UColors.light,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(USizes.cardRadiusLg),
          topRight: Radius.circular(USizes.cardRadiusLg),
        ),
      ),
      child: Obx(
        () => Row(
          children: [
            // Decrement Button
            UCircularIcon(
              icon: Iconsax.minus,
              backgroundColor: UColors.darkGrey,
              width: 40,
              height: 40,
              color: UColors.white,
              onPressed: controller.productQuantityInCart.value < 1
                  ? null
                  : () => controller.productQuantityInCart.value -= 1,
            ),
            SizedBox(width: USizes.spaceBtwItems),

            // COUNTER
           Text(
                controller.productQuantityInCart.value.toString(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
            
            SizedBox(width: USizes.spaceBtwItems),

            // increment button
            UCircularIcon(
              icon: Iconsax.add,
              backgroundColor: UColors.black,
              width: 40,
              height: 40,
              color: UColors.white,
              onPressed: () => controller.productQuantityInCart.value += 1,
            ),
            Spacer(),

            // add to cart button
            ElevatedButton(
              onPressed: controller.productQuantityInCart.value < 1
                  ? null
                  : () => controller.addToCart(product),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(USizes.md),
                backgroundColor: UColors.black,
                side: BorderSide(color: UColors.black),
              ),
              child: Row(
                children: [
                  Icon(Iconsax.shopping_bag),
                  SizedBox(width: USizes.spaceBtwItems / 2),
                  Text('Add To Cart'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
