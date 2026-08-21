import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/common/widgets/texts/section_heading.dart';
import 'package:shopping_app/features/shop/models/payment_method_model.dart';
import 'package:shopping_app/features/shop/screens/checkout/widgets/payment_tile.dart';
import 'package:shopping_app/utils/constants/enums.dart';
import 'package:shopping_app/utils/constants/images.dart';
import 'package:shopping_app/utils/constants/sizes.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  /// variables
  Rx<PaymentMethodModel> selectedPaymentMethod = PaymentMethodModel.empty().obs;

  @override
void onInit() {
selectedPaymentMethod.value = PaymentMethodModel(name: 'Cash on delivery', image: UImages.codIcon,paymentMethod: PaymentMethods.cashOnDelivery);
super.onInit();
}


  Future<void> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(USizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              USectionHeading(
                title: 'Select Payment Method',
                showActionButton: false,
              ),
              SizedBox(height: USizes.spaceBtwSections),
              UPaymentTile(
                paymentMethod: PaymentMethodModel(
                  name: 'Cash on delivery',
                  image: UImages.codIcon,
                  paymentMethod: PaymentMethods.cashOnDelivery
                ),
              ),
              SizedBox(height: USizes.spaceBtwSections),
             
              UPaymentTile(
                paymentMethod: PaymentMethodModel(
                  name: 'Paypal',
                  image: UImages.paypal,
                  paymentMethod: PaymentMethods.paypal
                ),
              ),
              SizedBox(height: USizes.spaceBtwItems / 2),
              UPaymentTile(
                paymentMethod: PaymentMethodModel(
                  name: 'Credit Card',
                  image: UImages.creditCard,
                  paymentMethod: PaymentMethods.creditCard
                ),
              ),
              SizedBox(height: USizes.spaceBtwItems / 2),
              UPaymentTile(
                paymentMethod: PaymentMethodModel(
                  name: 'Master Card',
                  image: UImages.masterCard,
                  paymentMethod: PaymentMethods.masterCard
                ),
              ),
              SizedBox(height: USizes.spaceBtwItems / 2),
            ],
          ), // Column
        ), // Container
      ),
    ); // SingleChildScrollView
  }

  // end
}
