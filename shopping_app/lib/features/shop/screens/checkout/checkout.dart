import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/common/style/padding.dart';
import 'package:shopping_app/common/widgets/appbar/appbar.dart';
import 'package:shopping_app/common/widgets/button/elevated_button.dart';
import 'package:shopping_app/common/widgets/custom_shapes/rounded_container.dart';
import 'package:shopping_app/common/widgets/textfields/promo_text_field.dart';
import 'package:shopping_app/features/shop/controllers/cart/cart_controller.dart';
import 'package:shopping_app/features/shop/controllers/order/order_controller.dart';
import 'package:shopping_app/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:shopping_app/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:shopping_app/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:shopping_app/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:shopping_app/utils/constants/texts.dart';
import 'package:shopping_app/utils/helpers/pricing_calculator.dart';
import 'package:shopping_app/utils/popups/snackbar_helpers.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    double subTotal = controller.totalCartPrice.value;
    double totalPrice = UPricingCalculator.calculateTotalPrice(
      subTotal,
      'Pakistan',
    );
    final orderController = Get.put(OrderController());
    return Scaffold(
      // appbar
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),

      // body
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              //items
              UCartItems(showAddRemoveButton: false),
              SizedBox(height: USizes.spaceBtwSections),

              // promo code - textfield
              UPromoCodeField(),
              SizedBox(height: USizes.spaceBtwSections),

              URoundedContainer(
                showBorder: true,
                padding: EdgeInsets.all(USizes.md),
                backgroundColor: Colors.transparent,
                child: Column(
                  children: [
                    //amount
                    UBillingAmountSection(),
                    SizedBox(height: USizes.spaceBtwItems),

                    // payment section
                    UBillingPaymentSection(),
                    SizedBox(height: USizes.spaceBtwItems),

                    UBillingAddressSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // bottom navigation
bottomNavigationBar: Padding(
  padding: const EdgeInsets.all(USizes.defaultSpace),
  child: UElevatedButton(
    onPressed: subTotal > 0
        ? () => orderController.processOrder(totalPrice)
        : () => USnackBarHelpers.errorSnackBar(
            title: 'Empty Cart',
            message: 'Add items in the cart',
          ),
    child: Text('Checkout ${UTexts.currency}$totalPrice'),
  ),
),
    );
  }
}
