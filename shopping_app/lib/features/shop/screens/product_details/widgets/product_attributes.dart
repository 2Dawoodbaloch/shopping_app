import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/common/widgets/chips/choice_chip.dart';
import 'package:shopping_app/common/widgets/custom_shapes/rounded_container.dart';
import 'package:shopping_app/common/widgets/texts/product_price_text.dart';
import 'package:shopping_app/common/widgets/texts/product_title_text.dart';
import 'package:shopping_app/common/widgets/texts/section_heading.dart';
import 'package:shopping_app/features/shop/controllers/product/variation_controller.dart';
import 'package:shopping_app/features/shop/models/product_model.dart';
import 'package:shopping_app/utils/constants/colors.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:shopping_app/utils/constants/texts.dart';
import 'package:shopping_app/utils/helpers/helper_functions.dart';

class UProductAttributes extends StatelessWidget {
  const UProductAttributes({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    final controller = Get.put(VariationController());
    return Obx(() => 
 Column(
        children: [
          // selected attributes pricing and descriptions
          if(controller.selectedVariation.value.id.isNotEmpty)
          URoundedContainer(
            padding: EdgeInsets.all(USizes.md),
            backgroundColor: dark ? UColors.darkGrey : UColors.grey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title , price & stock
                Row(
                  children: [
                    // text - variation and heading
                    USectionHeading(title: 'Variation', showActionButton: false),
                    SizedBox(width: USizes.spaceBtwItems),
      
                    Column(
                      children: [
                        // price, sale price, actual price
                        Row(
                          children: [
                            // text - price
                            UProductTitleText(title: 'Price', smallSize: true),
      
                            // actual Price
                            if(controller.selectedVariation.value.salePrice > 0)
                            Text(
                              '${UTexts.currency}${controller.selectedVariation.value.price.toStringAsFixed(0)}',
                              style: Theme.of(context).textTheme.titleSmall!
                                  .apply(decoration: TextDecoration.lineThrough),
                            ),
                            SizedBox(width: USizes.spaceBtwItems),
      
                            // sale price
                            UProductPriceText(price: controller.getVariationPrice()),
                          ],
                        ),
      
                        // stock status
                        Row(
                          children: [
                            UProductTitleText(title: 'Stock : ', smallSize: true),
                            Text(
                              controller.variationStockStatus.value,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
      
                // attributes description
                UProductTitleText(
                  title: controller.selectedVariation.value.description ?? '',
                  smallSize: true,
                  maxLines: 4,
                ),
              ],
            ),
          ),
          SizedBox(height: USizes.spaceBtwItems),
      
          // attributes - colors
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!.map((attribute) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  USectionHeading(title: attribute.name ?? '', showActionButton: false),
                  SizedBox(height: USizes.spaceBtwItems / 2),
                Obx(() =>   Wrap(
                    spacing: USizes.sm,
                    children: attribute.values!.map((attributeValues){
                      bool isSelected = controller.selectedAttributes[attribute.name] == attributeValues;
                      bool available = controller.getAttributesAvailabilityInVariation(product.productVariations!, attribute.name!).contains(attributeValues);
                      return   UChoiceChip(
                        text: attributeValues,
                        selected: isSelected,
                        onSelected: available ? (selected) {
                          controller.onAttributeSelected(product, attribute.name, attributeValues);
                        } : null,
                      );
                    }).toList()
                  ),)
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
