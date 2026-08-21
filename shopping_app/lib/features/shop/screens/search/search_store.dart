import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_app/common/style/padding.dart';
import 'package:shopping_app/common/widgets/appbar/appbar.dart';
import 'package:shopping_app/common/widgets/layouts/grid_layout.dart';
import 'package:shopping_app/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:shopping_app/features/shop/controllers/product/product_controller.dart';
import 'package:shopping_app/features/shop/screens/search/widget/search_store_brands.dart';
import 'package:shopping_app/features/shop/screens/search/widget/search_store_categories.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:shopping_app/utils/helpers/cloud_helper_functions.dart';

class SearchStoreScreen extends StatelessWidget {
  const SearchStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RxString searchText = ''.obs;
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          'Search',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [

              /// Search Field
              Hero(
                tag: 'search_animation',
                child: Material(
                  color: Colors.transparent,
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.search_normal),
                      hintText: 'Search in store',
                    ),
                    onChanged: (value) => searchText.value = value,
                  ),
                ),
              ),
              SizedBox(height: USizes.spaceBtwSections),

              Obx(() {
                if (searchText.value.isEmpty) {
                  return Column(
                    children: [
                      /// Brands
                      SearchStoreBrands(),

                      SizedBox(height: USizes.spaceBtwSections),

                      /// Categories
                      SearchStoreCategories(),
                    ],
                  );
                }

                return FutureBuilder(
                  future: ProductController.instance.getAllProducts(),
                  builder: (context, snapshot) {
                    /// Handle Loading, Error, Empty
                    final widget = UCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot,
                    );
                    if (widget != null) return widget;

                    /// Data Found - Products Found
                    final products = snapshot.data!;

                    /// Filter Products Based on search Text
                    final filterProducts = products
                        .where(
                          (product) => product.title.toLowerCase().contains(
                            searchText.value.toLowerCase(),
                          ),
                        )
                        .toList();

                    /// filtered Products not Found
                    if (filterProducts.isEmpty) return Text('Products not Found');
                    return UGridLayout(
                      itemCount: filterProducts.length,
                      itemBuilder: (context, index) {
                        final product = filterProducts[index];
                        return UProductCardVertical(product: product);
                      },
                    ); // UGridLayout
                  },
                ); // FutureBuilder
              }),
            ],
          ), // Column
        ), // Padding
      ),
    );
  }
}
