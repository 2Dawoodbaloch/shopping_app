import 'package:flutter/material.dart';
import 'package:shopping_app/common/widgets/images/rounded_image.dart';
import 'package:shopping_app/common/widgets/texts/brand_title_with_verify_icon.dart';
import 'package:shopping_app/common/widgets/texts/product_title_text.dart';
import 'package:shopping_app/features/shop/models/cart_item_model.dart';
import 'package:shopping_app/utils/constants/colors.dart';
import 'package:shopping_app/utils/constants/images.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:shopping_app/utils/helpers/helper_functions.dart';

class UCartItem extends StatelessWidget {
  const UCartItem({super.key, required this.cartItem});

  final CartItemModel cartItem;
  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        // PRODUCT IMAGE
        URoundedImage(
          imageUrl: cartItem.image ?? '',
          isNetworkImage: true,
          height: 60,
          width: 60,
          padding: EdgeInsets.all(USizes.sm),
          backgroundColor: dark ? UColors.darkGrey : UColors.light,
        ),
        SizedBox(width: USizes.spaceBtwItems),

        // brand , name , variation
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // brand
              UBrandTitleWithVerifyIcon(title: cartItem.brandName ?? ''),

              // title
              UProductTitleText(title: cartItem.title, maxLines: 1),

              // variation or attributes
              /// Variation OR Attributes
              RichText(
                text: TextSpan(
                  children: (cartItem.selectedVariation ?? {}).entries
                      .map(
                        (e) => TextSpan(
                          children: [
                            TextSpan(
                              text: '${e.key} ',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            TextSpan(
                              text: '${e.value} ',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ), // TextSpan, TextSpan, RichText
            ],
          ),
        ),
      ],
    );
  }
}
