import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/common/style/padding.dart';
import 'package:shopping_app/common/widgets/appbar/appbar.dart';
import 'package:shopping_app/common/widgets/products/sortable_products.dart';
import 'package:shopping_app/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:shopping_app/features/shop/controllers/product/all_product_controller.dart';
import 'package:shopping_app/features/shop/models/product_model.dart';
import 'package:shopping_app/utils/helpers/cloud_helper_functions.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key,this.query,this.futureMethod,required this.title});

final Future<List<ProductModel>>?  futureMethod;
final Query? query;
final String title;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          'Popular Products',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: UPadding.screenPadding,
        child: FutureBuilder(future: futureMethod ?? controller.fetchProductQuery(query), builder: (context,snapshot){
          const loader  = UVerticalProductShimmer();
          final widget = UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,loader: loader);
          if (widget != null) return widget;

          final product = snapshot.data!;
          return USortableProducts(product: product);
        },
      )
      ),
    );
  }
}
