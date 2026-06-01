import 'package:flutter/material.dart';
import 'package:shopping_app/common/style/padding.dart';
import 'package:shopping_app/common/widgets/appbar/appbar.dart';
import 'package:shopping_app/common/widgets/brands/brand_card.dart';
import 'package:shopping_app/common/widgets/products/sortable_products.dart';
import 'package:shopping_app/features/shop/screens/all_products_screen/all_products_screen.dart';
import 'package:shopping_app/utils/constants/sizes.dart';

class BrandProductsScreen extends StatelessWidget {
  const BrandProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text('Bata', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              // brand
              UBrandCard(),
              SizedBox(height: USizes.spaceBtwSections),

              // brand products
              USortableProducts(),
            ],
          ),
        ),
      ),
    );
  }
}
