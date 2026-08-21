import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shopping_app/common/widgets/products/cart/cart_item.dart';
import 'package:shopping_app/common/widgets/products/cart/product_quantity_with_add_remove.dart';
import 'package:shopping_app/common/widgets/texts/product_price_text.dart';
import 'package:shopping_app/features/shop/controllers/cart/cart_controller.dart';
import 'package:shopping_app/utils/constants/sizes.dart';

class UCartItems extends StatelessWidget {
  const UCartItems({super.key, this.showAddRemoveButton = true});

  final bool showAddRemoveButton;
  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) =>
            SizedBox(height: USizes.spaceBtwSections),
        itemCount: controller.cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = controller.cartItems[index];

          return Column(
            children: [
              // cart item
              UCartItem(cartItem: cartItem),
              if (showAddRemoveButton) SizedBox(height: USizes.spaceBtwItems),

              // price,counter button
              if (showAddRemoveButton)
                Row(
                  children: [
                    // EXTRA SPACE
                    SizedBox(width: 70),

                    // quanitity button
                    UProductQuantityWithAddRemove(
                      quanitity: cartItem.quantity,
                      add: () => controller.addOneToCart(cartItem),
                      remove: () => controller.removeOneFromCart(cartItem),
                    ),
                    Spacer(),

                    // PRODUCT PRICE
                    UProductPriceText(
                      price: (cartItem.price * cartItem.quantity)
                          .toStringAsFixed(2),
                    ),

                    //
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}
