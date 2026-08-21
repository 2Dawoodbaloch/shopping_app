import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_app/common/style/padding.dart';
import 'package:shopping_app/common/widgets/appbar/appbar.dart';
import 'package:shopping_app/common/widgets/button/elevated_button.dart';
import 'package:shopping_app/common/widgets/icons/circular_icon.dart';
import 'package:shopping_app/features/shop/controllers/cart/cart_controller.dart';
import 'package:shopping_app/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:shopping_app/features/shop/screens/checkout/checkout.dart';
import 'package:shopping_app/utils/constants/sizes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Scaffold(
      // appbar
      appBar: UAppBar(
        showBackArrow: true,
        title: Text('Cart', style: Theme.of(context).textTheme.headlineMedium),
        actions: [UCircularIcon(icon: Iconsax.box_remove,onPressed: () => controller.clearCart(),),],
      ),

      // body
      body: Obx(() {
        // final emptyWidget = UAnimationLoader(
        //   text: 'Cart is empty',
        //   animation: UImages.cartEmptyAnimation,
        //   showActionButton: true,
        //   actionText: "Let's fill it",
        //   onActionPressed: Get.back,
        // ); // UAnimationLoader

        if (controller.cartItems.isEmpty) {
          return Center(child: Text("Cart is Empty"),);
        }
        return SingleChildScrollView(
          child: Padding(padding: UPadding.screenPadding, child: UCartItems()),
        );
      }),

      // Bottom navigation
      bottomNavigationBar: Obx(() {
        if (controller.cartItems.isEmpty) return SizedBox();
        return Padding(
          padding: const EdgeInsets.all(USizes.defaultSpace),
          child: UElevatedButton(
            onPressed: () => Get.to(() => CheckoutScreen()),
            child: Text('Checout \$${controller.totalCartPrice.value}'),
          ),
        );
      }),
    );
  }
}
