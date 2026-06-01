import 'package:flutter/material.dart';
import 'package:shopping_app/common/widgets/appbar/appbar.dart';
import 'package:shopping_app/common/widgets/products/cart/cart_counter_icon.dart';
import 'package:shopping_app/common/widgets/textfields/search_bar.dart';
import 'package:shopping_app/common/widgets/custom_shapes/primary_header_container.dart';
import 'package:shopping_app/utils/constants/colors.dart';
import 'package:shopping_app/utils/constants/sizes.dart';

class UStorePrimaryHeader extends StatelessWidget {
  const UStorePrimaryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            // totall height + 20
            SizedBox(height: USizes.storePrimaryHeaderHeight + 10),

            // primary header container
            UPrimaryHeaderContainer(
              height: USizes.storePrimaryHeaderHeight,
              child: UAppBar(
                title: Text(
                  'Store',
                  style: Theme.of(
                    context,
                  ).textTheme.headlineMedium!.apply(color: UColors.white),
                ),
                actions: [UCartCounterIcon()],
              ),
            ),

            // searchbar
            USearchBar(),
          ],
        ),
      ],
    );
  }
}
