import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_app/common/widgets/icons/circular_icon.dart';
import 'package:shopping_app/features/shop/controllers/product/favourite_controller.dart';

class UFavouriteIcon extends StatelessWidget {
  const UFavouriteIcon({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouriteController());
    return Obx(() =>  UCircularIcon(
      icon: controller.isFavourie(productId) ? Iconsax.heart5 : Iconsax.heart,
      color: controller.isFavourie(productId) ? Colors.red : null,
      onPressed:() => controller.toggleFavouriteProduct(productId),
    ));
  }
}
