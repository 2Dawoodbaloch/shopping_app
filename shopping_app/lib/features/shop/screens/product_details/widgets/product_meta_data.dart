import 'package:flutter/material.dart';
import 'package:shopping_app/common/widgets/custom_shapes/rounded_container.dart';
import 'package:shopping_app/common/widgets/images/circular_images.dart';
import 'package:shopping_app/common/widgets/texts/brand_title_with_verify_icon.dart';
import 'package:shopping_app/common/widgets/texts/product_price_text.dart';
import 'package:shopping_app/common/widgets/texts/product_title_text.dart';
import 'package:shopping_app/features/shop/controllers/product/product_controller.dart';
import 'package:shopping_app/features/shop/models/product_model.dart';
import 'package:shopping_app/utils/constants/colors.dart';
import 'package:shopping_app/utils/constants/enums.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:shopping_app/utils/constants/texts.dart';

class UProductMetaData extends StatelessWidget {
  const UProductMetaData({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    String? salesPercentage = controller.calculateSalePercentage(
      product.price,
      product.salePrice,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // sale tag, sale pric e, actual price and share buttons
        Row(
          children: [
            if (salesPercentage != null) ...[
              URoundedContainer(
                radius: USizes.sm,
                backgroundColor: UColors.yellow.withValues(alpha: 0.8),
                padding: const EdgeInsets.symmetric(
                  horizontal: USizes.sm,
                  vertical: USizes.xs,
                ),
                child: Text(
                  '$salesPercentage%',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.apply(color: UColors.black),
                ),
              ),
              SizedBox(width: USizes.spaceBtwItems),
            ],

            // actual price
            if (product.productType == ProductType.single.toString() &&
                product.salePrice > 0) ...[
              Text(
                '${UTexts.currency}${product.price.toStringAsFixed(0)}',
                style: Theme.of(context).textTheme.titleSmall!.apply(
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              SizedBox(width: USizes.spaceBtwItems),
            ],

            // actual price
            UProductPriceText(price: controller.getProductprice(product), isLarge: true),
            Spacer(),

            // share icon button
            IconButton(onPressed: () {}, icon: Icon(Icons.share)),
          ],
        ),
        SizedBox(height: USizes.spaceBtwItems / 1.5),

        // product title
        UProductTitleText(title: product.title),
        SizedBox(height: USizes.spaceBtwItems / 1.5),

        // product status
        Row(
          children: [
            UProductTitleText(title: "Status"),
            SizedBox(width: USizes.spaceBtwItems),
            Text(controller.getProductStockStatus(product.stock), style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        SizedBox(height: USizes.spaceBtwItems / 1.5),

        // product brand image with title
        Row(
          children: [
            UCircularImage(
              padding: 0,
                         isNetworkImage: true,
           
              width: 32,
   
              height: 32,
                 image: product.brand != null ? product.brand!.image : '',
            ),
            SizedBox(width: USizes.spaceBtwItems),
            UBrandTitleWithVerifyIcon(title: product.brand != null ? product.brand!.name : ''
            ),
          ],
        ),
      ],
    );
  }
}
