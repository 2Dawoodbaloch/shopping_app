import 'package:flutter/material.dart';
import 'package:shopping_app/common/widgets/appbar/tabbar.dart';
import 'package:shopping_app/common/widgets/brands/brand_card.dart';
import 'package:shopping_app/common/widgets/shimmer/brands_shimmer.dart';
import 'package:shopping_app/common/widgets/texts/section_heading.dart';
import 'package:shopping_app/features/shop/controllers/brand/brand_controller.dart';
import 'package:shopping_app/features/shop/controllers/category/category_controller.dart';
import 'package:shopping_app/features/shop/models/brand_model.dart';
import 'package:shopping_app/features/shop/screens/brands/all_brand.dart';
import 'package:shopping_app/features/shop/screens/brands/brand_products.dart';
import 'package:shopping_app/features/shop/screens/store/widgets/category_tab.dart';
import 'package:shopping_app/features/shop/screens/store/widgets/store_primary_header.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:get/get.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    final brandController = Get.put(BrandController());
    return DefaultTabController(
      length: controller.featuredCategories.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 340,
                pinned: true,
                floating: false,
                flexibleSpace: SingleChildScrollView(
                  child: Column(
                    children: [
                      // primary header
                      UStorePrimaryHeader(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: USizes.defaultSpace,
                        ),
                        child: Column(
                          children: [
                            /// primary heading
                            USectionHeading(
                              title: 'Brands',
                              onPressed: () => Get.to(() => BrandScreen()),
                            ),

                            // BRAND CARD
                            SizedBox(
                              height: USizes.brandCardHeight,
                              child: Obx(() {
                                /// [Loading] - State
                                if (brandController.isLoading.value) {
                                  return UBrandsShimmer();
                                }

                                /// [Empty] - State
                                if (brandController.featuredBrands.isEmpty) {
                                  return Text('Brands Not Found!');
                                }
                                return ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      SizedBox(width: USizes.spaceBtwItems),
                                  shrinkWrap: true,
                                  itemCount:
                                      brandController.featuredBrands.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    BrandModel brand =
                                        brandController.featuredBrands[index];
                                    return SizedBox(
                                      width: USizes.brandCardWidth,
                                      child: UBrandCard(brand: brand, onTap: () => Get.to(() => BrandProductsScreen(title: brand.name,brand: brand,)),),
                                    );
                                  },
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                bottom: UTabBar(
                  tabs: controller.featuredCategories
                      .map((category) => Tab(child: Text(category.name)))
                      .toList(),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: controller.featuredCategories
                .map((category) => UCategoryTab(category: category,))
                .toList(),
          ),
        ),
      ),
    );
  }
}
