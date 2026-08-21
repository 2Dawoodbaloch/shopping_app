import 'package:get/get.dart';
import 'package:shopping_app/features/personalization/controllers/adress_controller.dart';
import 'package:shopping_app/features/shop/controllers/checkout/checkout_controller.dart';
import 'package:shopping_app/features/shop/controllers/product/variation_controller.dart';
import 'package:shopping_app/utils/helpers/network_manager.dart';

class NetworkBinding with Bindings{
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
    Get.put(CheckoutController());
    Get.put(AdressController());
  }
}