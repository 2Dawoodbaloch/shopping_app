import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/common/widgets/login_signup/success_screen.dart';
import 'package:shopping_app/data/repositories/authentication_repository.dart';
import 'package:shopping_app/data/repositories/order/order_repository.dart';
import 'package:shopping_app/features/personalization/controllers/adress_controller.dart';
import 'package:shopping_app/features/shop/controllers/cart/cart_controller.dart';
import 'package:shopping_app/features/shop/controllers/checkout/checkout_controller.dart';
import 'package:shopping_app/features/shop/models/order_model.dart';
import 'package:shopping_app/navigation_menu.dart';
import 'package:shopping_app/utils/constants/enums.dart';
import 'package:shopping_app/utils/constants/images.dart';
import 'package:shopping_app/utils/popups/full_screen_loader.dart';
import 'package:shopping_app/utils/popups/snackbar_helpers.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  // Variables
  final cartController = CartController.instance;
  final checkoutController = CheckoutController.instance;
  final addressController = AdressController.instance;
  final _repository = Get.put(OrderRepository());

  Future<void> processOrder(double totalAmount) async {
    try {
      // start loading
      UFullScreenLoader.openLoadingDialog('Processing your order ... ');

      // check user existence
      String usedId = AuthenticationRepository.instance.currentUser!.uid;
      if (usedId.isEmpty) return;

      // Create Order Model

      OrderModel order = OrderModel(
        id: UniqueKey().toString(),
        status: OrderStatus.pending,
        items: cartController.cartItems.toList(),
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        userId: usedId,
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        deliveryDate: DateTime.now(),
      ); // OrderModel

      // save order
      await _repository.saveOrder(order);

      // update cart
      cartController.clearCart();

      // show success screen
      Get.to(
        () => SuccessScreen(
          title: 'Payment Success!',
          subTitle: 'Your item will be shipped soon!',
          image: UImages.successfulPaymentIcon,
          onTap: () => Get.offAll(() => NavigationMenu()),
        ),
      ); // SuccessScreen
    } catch (e) {
      USnackBarHelpers.errorSnackBar(
        title: 'Order Failed',
        message: e.toString(),
      );
    }
  }

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final orders = await _repository.fetchUserOrders();
      return orders;
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Failed', message: e.toString());
      return [];
    }
  }
}
