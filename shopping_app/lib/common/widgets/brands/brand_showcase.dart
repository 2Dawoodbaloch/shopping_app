import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shopping_app/common/widgets/brands/brand_card.dart';
import 'package:shopping_app/common/widgets/custom_shapes/rounded_container.dart';
import 'package:shopping_app/common/widgets/shimmer/shimmer_effect.dart';
import 'package:shopping_app/features/shop/models/brand_model.dart';
import 'package:shopping_app/features/shop/screens/brands/brand_products.dart';
import 'package:shopping_app/utils/constants/colors.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:shopping_app/utils/helpers/helper_functions.dart';

class UBrandShowCase extends StatelessWidget {
  const UBrandShowCase({super.key, required this.images,required this.brand});
  final List<String> images;
  final BrandModel brand;
  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    return InkWell(
      onTap: () => Get.to(() => BrandProductsScreen(title: brand.name, brand: brand)),
      child: URoundedContainer(
        showBorder: true,
        borderColor: UColors.darkGrey,
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.all(USizes.md),
        margin: EdgeInsets.only(bottom: USizes.spaceBtwItems),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // brand with product count
            UBrandCard(showBorder: false,brand: brand),
      
            Row(
              children: images
                  .map((image) => buildBrandImage(dark, image))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBrandImage(bool dark, String image) {
    return Expanded(
      child: URoundedContainer(
        height: 100,
        margin: const EdgeInsets.only(right: USizes.sm),
        padding: const EdgeInsets.all(USizes.md),
        backgroundColor: dark ? UColors.darkGrey : UColors.light,
        child: CachedNetworkImage(imageUrl: image,fit: BoxFit.contain,progressIndicatorBuilder: (context, url, progress) => UShimmerEffect(width: 100, height: 100) ,errorWidget: (context, url, error) => Icon(Icons.error),)
      ),
    );
  }
}
