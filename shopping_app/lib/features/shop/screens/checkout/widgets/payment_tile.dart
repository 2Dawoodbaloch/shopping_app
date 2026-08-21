
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_app/common/widgets/custom_shapes/rounded_container.dart';
import 'package:shopping_app/features/shop/controllers/checkout/checkout_controller.dart';
import 'package:shopping_app/features/shop/models/payment_method_model.dart';
import 'package:shopping_app/utils/constants/colors.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:shopping_app/utils/helpers/helper_functions.dart';

class UPaymentTile extends StatelessWidget {
  const UPaymentTile({super.key, required this.paymentMethod});

  final PaymentMethodModel paymentMethod;
  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;
    return ListTile(
      onTap: () {
        controller.selectedPaymentMethod.value = paymentMethod;
        Get.back();
      },
      contentPadding: EdgeInsets.zero,
      leading: URoundedContainer(
        width: 60,
        height: 40,
        backgroundColor: UHelperFunctions.isDarkMode(context)
            ? UColors.light
            : UColors.white,
        padding: EdgeInsets.all(USizes.sm),
        child: Image(
          image: AssetImage(paymentMethod.image),
          fit: BoxFit.contain,
        ),
      ), // URoundedContainer
      title: Text(paymentMethod.name),
      trailing: Icon(Iconsax.arrow_right_34),
    ); // ListTile
  }
}
