import 'package:flutter/material.dart';
import 'package:shopping_app/common/widgets/products/cart/cart_item.dart';
import 'package:shopping_app/common/widgets/products/cart/product_quantity_with_add_remove.dart';
import 'package:shopping_app/common/widgets/texts/product_price_text.dart';
import 'package:shopping_app/utils/constants/sizes.dart';

class UCartItems extends StatelessWidget {
  const UCartItems({super.key, this.showAddRemoveButton = true});

  final bool showAddRemoveButton;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) =>
          SizedBox(height: USizes.spaceBtwSections),
      itemCount: 2,
      itemBuilder: (context, index) {
        return Column(
          children: [
            // cart item
            UCartItem(),
            if (showAddRemoveButton) SizedBox(height: USizes.spaceBtwItems),

            // price,counter button
            if (showAddRemoveButton)
              Row(
                children: [
                  // EXTRA SPACE
                  SizedBox(width: 70),

                  // quanitity button
                  UProductQuantityWithAddRemove(),
                  Spacer(),

                  // PRODUCT PRICE
                  UProductPriceText(price: '323'),

                  //
                ],
              ),
          ],
        );
      },
    );
  }
}
