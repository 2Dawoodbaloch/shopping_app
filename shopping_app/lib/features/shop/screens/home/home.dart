import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/common/widgets/layouts/grid_layout.dart';
import 'package:shopping_app/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:shopping_app/common/widgets/textfields/search_bar.dart';
import 'package:shopping_app/common/widgets/texts/section_heading.dart';
import 'package:shopping_app/features/shop/controllers/home/home_controller.dart';
import 'package:shopping_app/features/shop/screens/all_products_screen/all_products_screen.dart';
import 'package:shopping_app/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:shopping_app/features/shop/screens/home/widgets/home_categories.dart';
import 'package:shopping_app/common/widgets/custom_shapes/primary_header_container.dart';
import 'package:shopping_app/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:shopping_app/utils/constants/images.dart';
import 'package:shopping_app/utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// upper part
            Stack(
              children: [
                // totall height + 20
                SizedBox(height: USizes.homePrimaryHeaderHeight + 10),

                // primary header container
                UPrimaryHeaderContainer(
                  height: USizes.homePrimaryHeaderHeight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // appbar
                      UHomeAppBar(),
                      SizedBox(height: USizes.spaceBtwSections),

                      // home catgores
                      UHomeCategories(),
                    ],
                  ),
                ),

                // searchbar
                USearchBar(),
              ],
            ),

            /// lower part
            /// Banners
            Padding(
              padding: const EdgeInsets.all(USizes.defaultSpace),
              child: Column(
                children: [
                  UPromoSlider(
                    banners: [
                      UImages.homeBanner1,
                      UImages.homeBanner2,
                      UImages.homeBanner3,
                      UImages.homeBanner4,
                      UImages.homeBanner5,
                    ],
                  ),
                  const SizedBox(height: USizes.spaceBtwSections),

                  /// section heading
                  USectionHeading(
                    title: 'Popular Products',
                    onPressed: () => Get.to(() => AllProductsScreen()),
                  ),
                  const SizedBox(height: USizes.spaceBtwSections),

                  // Grid view of  product card
                  UGridLayout(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return UProductCardVertical();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
