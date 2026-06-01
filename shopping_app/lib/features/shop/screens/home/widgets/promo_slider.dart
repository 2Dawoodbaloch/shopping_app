import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/common/widgets/images/rounded_image.dart';
import 'package:shopping_app/features/shop/controllers/home/home_controller.dart';
import 'package:shopping_app/features/shop/screens/home/widgets/banners_dot_navigation.dart';
import 'package:shopping_app/utils/constants/sizes.dart';

class UPromoSlider extends StatelessWidget {
  const UPromoSlider({super.key, required this.banners});

  final List<String> banners;
  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    return Column(
      children: [
        CarouselSlider(
          items: banners
              .map((banner) => URoundedImage(imageUrl: banner))
              .toList(),
          options: CarouselOptions(
            viewportFraction: 1.0,
            onPageChanged: (index, reason) => controller.onPageChanged(index),
          ),
          carouselController: controller.carouselController,
        ),

        SizedBox(height: USizes.spaceBtwItems),
        BannerDotNavigation(),
      ],
    );
  }
}
