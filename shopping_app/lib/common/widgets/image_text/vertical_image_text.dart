import 'package:flutter/material.dart';
import 'package:shopping_app/common/widgets/images/circular_images.dart';
import 'package:shopping_app/utils/constants/sizes.dart';

class UVerticalImagesText extends StatelessWidget {
  const UVerticalImagesText({
    super.key,
    required this.title,
    required this.image,
    required this.textColor,
    this.backgroundColor,
    this.onTap,
  });

  final String title, image;
  final Color textColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          /// circular image
          /// Circular Image
          UCircularImage(
            height: 56,
            width: 56,
            image: image,
            isNetworkImage: true,
          ), // UCircularImage
          SizedBox(height: USizes.spaceBtwItems / 2),
          // title
          SizedBox(
            width: 55,
            child: Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.labelMedium!.apply(color: textColor),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
