import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/common/widgets/image_text/vertical_image_text.dart';
import 'package:shopping_app/common/widgets/texts/section_heading.dart';
import 'package:shopping_app/features/shop/controllers/brand/brand_controller.dart';
import 'package:shopping_app/features/shop/models/brand_model.dart';
import 'package:shopping_app/features/shop/screens/brands/all_brand.dart';
import 'package:shopping_app/features/shop/screens/brands/brand_products.dart';
import 'package:shopping_app/utils/constants/colors.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:shopping_app/utils/helpers/helper_functions.dart';

class SearchStoreBrands extends StatelessWidget {
  const SearchStoreBrands({super.key});

  @override
  Widget build(BuildContext context) {
    bool dark = UHelperFunctions.isDarkMode(context);
    final controller = Get.put(BrandController());
    return Obx(() {
      /// [State] - Loading
      if (controller.isLoading.value)  return Center(child: CircularProgressIndicator());

      /// [State] - Empty
      if (controller.allBrands.isEmpty) return Text('No Brands Found!');

      /// [State] - Data Found
      List<BrandModel> brands = controller.allBrands.take(10).toList();

      return Column(
        children: [
          USectionHeading(
            title: 'Brands',
            onPressed: () => Get.to(() => BrandScreen()),
          ),
          SizedBox(height: USizes.spaceBtwItems),
          Wrap(
            spacing: USizes.spaceBtwItems,
            runSpacing: USizes.spaceBtwItems,
            children: brands
                .map(
                  (brand) => UVerticalImagesText(
                    title: brand.name,
                    image: brand.image,
                    onTap: () => Get.to(
                      () =>
                          BrandProductsScreen(title: brand.name, brand: brand),
                    ),
                    textColor: dark ? UColors.white : UColors.white,
                  ),
                )
                .toList(),
          ), // Wrap,
        ],
      );
    });
  }
}
