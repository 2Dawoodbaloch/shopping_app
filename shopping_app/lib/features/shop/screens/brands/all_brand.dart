import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:shopping_app/common/style/padding.dart';
import 'package:shopping_app/common/widgets/appbar/appbar.dart';
import 'package:shopping_app/common/widgets/brands/brand_card.dart';
import 'package:shopping_app/common/widgets/layouts/grid_layout.dart';
import 'package:shopping_app/common/widgets/texts/section_heading.dart';
import 'package:shopping_app/features/shop/controllers/brand/brand_controller.dart';
import 'package:shopping_app/features/shop/models/brand_model.dart';
import 'package:shopping_app/features/shop/screens/brands/brand_products.dart';
import 'package:shopping_app/utils/constants/sizes.dart';

class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text('Brand', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              // text - brands
              USectionHeading(title: 'Brands', showActionButton: false),
              SizedBox(height: USizes.spaceBtwItems),

              /// List Of Brands
              Obx(() {
                if (brandController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                /// [Empty] - State
                if (brandController.allBrands.isEmpty) {
                  return Center(child: Text('Brands Not Found!'));
                }

                return UGridLayout(
                  itemCount: brandController.allBrands.length,
                  itemBuilder: (context, index) {
                    BrandModel brand = brandController.allBrands[index];
                    return UBrandCard(
                      onTap: () => Get.to(() => BrandProductsScreen(title: brand.name,brand: brand,)),
                      brand: brand,
                    );
                  },
                  mainAxisExtent: 80,
                ); // UGridLayout
              }), // 0bx
            ],
          ),
        ),
      ),
    );
  }
}
