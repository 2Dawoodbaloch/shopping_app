import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_app/common/widgets/appbar/appbar.dart';
import 'package:shopping_app/common/widgets/icons/circular_icon.dart';
import 'package:shopping_app/common/widgets/layouts/grid_layout.dart';
import 'package:shopping_app/common/widgets/loaders/animation_loader.dart';
import 'package:shopping_app/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:shopping_app/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:shopping_app/features/shop/controllers/product/favourite_controller.dart';
import 'package:shopping_app/features/shop/models/product_model.dart';
import 'package:shopping_app/navigation_menu.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:shopping_app/utils/helpers/cloud_helper_functions.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appbar
      appBar: UAppBar(
        title: Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          UCircularIcon(
            icon: Iconsax.add,
            onPressed: () =>
                NavigationController.instance.selectedIndex.value = 0,
          ),
        ],
      ),

      // body
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(USizes.defaultSpace),
          child: Obx(
            () => FutureBuilder(
              future: FavouriteController.instance.getFavouriteProducts(),
              builder: (context, snapshot) {
                const nothingFound = UAnimationLoader(
                  text: "Wishlist is Empty....",
                );

                // final  nothingFound = UAnimationLoader(text: "Wishlist is Empty....",
                // animation: UImages.cartEmptyAnimation,
                // showActionButton: true,
                // actionText: 'Lets add some ',
                // onActionPressed:() => NavigationController.instance.selectedIndex.value = 0 ,);
                const loader = UVerticalProductShimmer(itemCount: 6);

                /// Handle Empty Data, Loading And Error
                final widget = UCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot,
                  loader: loader,
                  nothingFound: nothingFound,
                );
                if (widget != null) {
                  return widget;
                }

                /// Product Found
                List<ProductModel> products = snapshot.data!;
                return UGridLayout(
                  itemCount: products.length,
                  itemBuilder: (context, index) =>
                      UProductCardVertical(product: products[index]),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
