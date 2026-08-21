import 'package:flutter/material.dart';
import 'package:shopping_app/features/shop/controllers/cart/cart_controller.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:shopping_app/utils/constants/texts.dart';
import 'package:shopping_app/utils/helpers/device_helpers.dart';
import 'package:shopping_app/utils/helpers/pricing_calculator.dart';

class UBillingAmountSection extends StatelessWidget {
  const UBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    return Column(
      children: [
        // subtotall
        Row(
          children: [
            Expanded(
              child: Text(
                'Subtotal',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Text('${UTexts.currency}subTotal', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        SizedBox(height: USizes.spaceBtwItems / 2),

        // shipping fee
        Row(
          children: [
            Expanded(
              child: Text(
                'Shipping Fee',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Text('${UTexts.currency}${UPricingCalculator.calculateShippingCost(subTotal, 'Pakistan')}', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        SizedBox(height: USizes.spaceBtwItems / 2),

        // Tax fee
        Row(
          children: [
            Expanded(
              child: Text(
                'Tax Fee',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Text('${UTexts.currency}${UPricingCalculator.calculateTax(subTotal, 'Paksitan')}', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        SizedBox(height: USizes.spaceBtwSections / 2),

        // order totall
        Row(
          children: [
            Expanded(
              child: Text(
                'Order Totall',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Text('${UTexts.currency}${UPricingCalculator.calculateTotalPrice(subTotal, 'Pakistan')}', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ],
    );
  }
}
