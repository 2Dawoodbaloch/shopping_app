import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_app/common/widgets/icons/circular_icon.dart';
import 'package:shopping_app/utils/constants/colors.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:shopping_app/utils/helpers/helper_functions.dart';

class UProductQuantityWithAddRemove extends StatelessWidget {
  const UProductQuantityWithAddRemove({super.key,required this.quanitity,this.add,this.remove});

final int quanitity;
final VoidCallback? add,remove;
  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        // decrement button
        UCircularIcon(
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: USizes.iconSm,
          color: dark ? UColors.white : UColors.black,
          backgroundColor: dark ? UColors.darkGrey : UColors.light,
          onPressed: remove,
        ),
        SizedBox(width: USizes.spaceBtwItems),
        // counter text
        Text(quanitity.toString(), style: Theme.of(context).textTheme.titleSmall),
        SizedBox(width: USizes.spaceBtwItems),

        // icrement text
        UCircularIcon(
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: USizes.iconSm,
          color: UColors.white,
          backgroundColor: UColors.primary,
          onPressed: add,
        ),
      ],
    );
  }
}
