import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_app/common/widgets/layouts/grid_layout.dart';
import 'package:shopping_app/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:shopping_app/features/shop/controllers/product/all_product_controller.dart';
import 'package:shopping_app/features/shop/models/product_model.dart';
import 'package:shopping_app/utils/constants/colors.dart';
import 'package:shopping_app/utils/constants/sizes.dart';

class USortableProducts extends StatelessWidget {
  const USortableProducts({super.key,required this.product});

final List<ProductModel> product;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    controller.assignProducts(product);
    return Column(
      children: [
        // filter field
        DropdownButtonFormField(
          dropdownColor: UColors.white,
          initialValue: controller.selectedSortOption.value,
          decoration: InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          onChanged: (value) => controller.sortProducts(value!),
          items: ['Name', 'Lower Price', 'Higher', 'Sale', 'Newest'].map((
            filter,
          ) {
            return DropdownMenuItem(value: filter, child: Text(filter));
          }).toList(),
        ),
        SizedBox(height: USizes.spaceBtwSections),

        // products
      Obx(() =>   UGridLayout(
          itemCount: controller.products.length,
          itemBuilder: (context, index) => UProductCardVertical(product:controller.products[index] ,),
        ))
      ],
    ); 
  }
}
