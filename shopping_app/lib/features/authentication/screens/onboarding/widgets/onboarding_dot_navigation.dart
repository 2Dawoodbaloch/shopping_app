import 'package:flutter/cupertino.dart';
import 'package:shopping_app/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:shopping_app/utils/helpers/device_helpers.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;
    return Positioned(
      bottom: UDeviceHelper.getBottomNavigationBarHeight() * 4,
      left: UDeviceHelper.getScreenWidth(context) / 2.5,
      right: UDeviceHelper.getScreenWidth(context) / 2.5,
      child: SmoothPageIndicator(
        controller: controller.pageController,
        onDotClicked: (index) => controller.dotNavigationClick,
        count: 3,
        effect: ExpandingDotsEffect(dotHeight: 6.0),
      ),
    );
  }
}
