import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shopping_app/common/style/padding.dart';
import 'package:shopping_app/common/widgets/appbar/appbar.dart';
import 'package:shopping_app/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:shopping_app/common/widgets/shimmer/horizontal_product_shimmer.dart';
import 'package:shopping_app/common/widgets/texts/section_heading.dart';
import 'package:shopping_app/features/shop/controllers/category/category_controller.dart';
import 'package:shopping_app/features/shop/models/category_mode.dart';
import 'package:shopping_app/features/shop/models/product_model.dart';
import 'package:shopping_app/features/shop/screens/all_products_screen/all_products_screen.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:shopping_app/utils/helpers/cloud_helper_functions.dart';

class SubCategoryScren extends StatelessWidget {
  const SubCategoryScren({super.key, required this.category});

  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          category.name,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: FutureBuilder(
            future: controller.getSubCategories(category.id),
            builder: (context, snapshot) {
              // Handle,Loader,Empty
              const loader = UHorizontalProductShimmer();
              final widget = UCloudHelperFunctions.checkMultiRecordState(
                snapshot: snapshot,loader: loader
              );
              if (widget != null) return widget;
          
              // Data Found
              List<CategoryModel> subcategories = snapshot.data!;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: subcategories.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
          
                  CategoryModel subCategory = subcategories[index];
          
                  /// Fetch Products for Sub Category
                return  FutureBuilder(
                    future: controller.getCategoryProduct(
                      categoryId: subCategory.id,
                    ),
                    builder: (context, snapshot) {
                      // Handle,Loader,Empty
          
                      final widget =
                          UCloudHelperFunctions.checkMultiRecordState(
                            snapshot: snapshot,loader: loader 
                          );
                      if (widget != null) return widget;
          
                      /// Data Found - Products Found
                      List<ProductModel> products = snapshot.data!;
                      return Column(
                        children: [
                          // subcategory
                          USectionHeading(
                            title: subCategory.name,
                            onPressed: () => Get.to(() => AllProductsScreen(title: subCategory.name,futureMethod: controller.getCategoryProduct(categoryId: subCategory.id,limit: -1),)),
                          ),
                          SizedBox(height: USizes.spaceBtwItems / 2),
          
                          // Horizental Product Card
                          SizedBox(
                            height: 120,
                            child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: USizes.spaceBtwItems / 2),
          
                              itemCount: products.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                ProductModel product = products[index];
                                return UProductCardHorizental(product: product,);
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
