import 'package:flutter/material.dart';
import 'package:shopping_app/common/style/padding.dart';
import 'package:shopping_app/common/widgets/appbar/appbar.dart';
import 'package:shopping_app/common/widgets/brands/brand_card.dart';
import 'package:shopping_app/common/widgets/products/sortable_products.dart';
import 'package:shopping_app/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:shopping_app/features/shop/controllers/brand/brand_controller.dart';
import 'package:shopping_app/features/shop/models/brand_model.dart';
import 'package:shopping_app/features/shop/models/product_model.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:shopping_app/utils/helpers/cloud_helper_functions.dart';

class BrandProductsScreen extends StatelessWidget {
  const BrandProductsScreen({super.key,required this.title,required this.brand});

final String title;
final BrandModel brand;
  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(title, style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              // brand
              UBrandCard(brand: brand,),
              SizedBox(height: USizes.spaceBtwSections),

              // brand products
             FutureBuilder(future: controller.getBrandProducts(brand.id),
              builder: (context,snapshot){

                /// Handle Loading, Errors And Empty Status
                const loader = UVerticalProductShimmer();
                Widget? widget = UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,loader: loader);
                if (widget != null) return widget;

                /// Data Found
                List<ProductModel> products = snapshot.data!;
                return  USortableProducts(product: products);
              })
            ],
          ),
        ),
      ),
    );
  }
}
