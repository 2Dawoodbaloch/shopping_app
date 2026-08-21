import 'package:flutter/material.dart';
import 'package:shopping_app/common/widgets/brands/brand_showcase.dart';
import 'package:shopping_app/common/widgets/shimmer/boxes_shimmer.dart';
import 'package:shopping_app/common/widgets/shimmer/list_tile_shimmer.dart';
import 'package:shopping_app/features/shop/controllers/brand/brand_controller.dart';
import 'package:shopping_app/features/shop/models/category_mode.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:shopping_app/utils/helpers/cloud_helper_functions.dart';

class CategoryBrand extends StatelessWidget {
  const CategoryBrand({super.key, required this.category});

  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
      future: controller.getBrandForCategory(category.id),
      builder: (context, snapshot) {
        const loadeer = Column(
          children: [
            UListTileShimmer(),
            SizedBox(height: USizes.spaceBtwItems),
            UBoxesShimmer(),
            SizedBox(height: USizes.spaceBtwItems),
          ],
        );

        // Handle loader ,Error
        final widget = UCloudHelperFunctions.checkMultiRecordState(
          snapshot: snapshot,
          loader: loadeer,
        );
        if (widget != null) return widget;

        // Brands found
        final brands = snapshot.data!;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: brands.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final brand = brands[index];
            return FutureBuilder(
              future: controller.getBrandProducts(brand.id, limit: 3),
              builder: (context, snapshot) {
                // Handle loader ,Error
                final widget = UCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot,
                  loader: loadeer,
                );
                if (widget != null) return widget;

                // Brands found
                final products = snapshot.data!;
                return UBrandShowCase(
                  brand: brand,
                  images: products.map((product) => product.thumbnail).toList()
                );
              },
            );
          },
        );
      },
    );
  }
}
