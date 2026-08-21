import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:shopping_app/features/shop/controllers/category/banner/banner_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerDotNavigation extends StatelessWidget {
  const BannerDotNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final bannerController = Get.put(BannerController());
    return Obx(
      () => SmoothPageIndicator(
        count: bannerController.banners.length,
        effect: ExpandingDotsEffect(dotHeight: 6.0),
        controller: PageController(initialPage: bannerController.currentIndex.value),
      ),
    );
  }
}
