import 'package:flutter/material.dart';
import 'package:shopping_app/common/widgets/shimmer/shimmer_effect.dart';
import 'package:shopping_app/utils/constants/sizes.dart';

class UCategoryShimmer extends StatelessWidget {
  const UCategoryShimmer({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 82,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(
          width: USizes.spaceBtwItems,
        ),
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Circular avatar placeholder (category icon)
              const UShimmerEffect(
                width: 55,
                height: 55,
                radius: 55, // large radius = fully circular for a 55x55 box
              ),
              const SizedBox(height: USizes.spaceBtwItems / 2),

              // Text line placeholder (category label)
              const UShimmerEffect(width: 55, height: 8),
            ],
          );
        },
      ),
    );
  }
}