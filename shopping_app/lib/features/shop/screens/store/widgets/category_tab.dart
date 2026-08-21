import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shopping_app/common/widgets/layouts/grid_layout.dart';
import 'package:shopping_app/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:shopping_app/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:shopping_app/common/widgets/texts/section_heading.dart';
import 'package:shopping_app/features/shop/controllers/category/category_controller.dart';
import 'package:shopping_app/features/shop/models/category_mode.dart';
import 'package:shopping_app/features/shop/models/product_model.dart';
import 'package:shopping_app/features/shop/screens/all_products_screen/all_products_screen.dart';
import 'package:shopping_app/features/shop/screens/store/widgets/category_brand.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:shopping_app/utils/helpers/cloud_helper_functions.dart';

class UCategoryTab extends StatelessWidget {
  const UCategoryTab({super.key, required this.category});

  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: USizes.defaultSpace),
          child: Column(
            children: [
              CategoryBrand(category: category),
              SizedBox(height: USizes.spaceBtwItems),
              USectionHeading(
                title: 'You might like',
                onPressed: () => Get.to(
                  () => AllProductsScreen(
                    title: category.name,
                    futureMethod: controller.getCategoryProduct(
                      categoryId: category.id,
                      limit: -1,
                    ),
                  ),
                ),
              ),

              // Grid layout products
              FutureBuilder(
                future: controller.getCategoryProduct(categoryId: category.id),
                builder: (context, snapshot) {
                  const loader = UVerticalProductShimmer();
                  // Handle loader ,Error
                  final widget = UCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot,
                    loader: loader,
                  );
                  if (widget != null) return widget;

                  // Products Found
                  List<ProductModel> products = snapshot.data!;
                  return UGridLayout(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      ProductModel product = products[index];
                      return UProductCardVertical(product: product);
                    },
                  );
                },
              ),

              SizedBox(height: USizes.spaceBtwSections),
            ],
          ),
        ),
      ],
    );
  }
}
