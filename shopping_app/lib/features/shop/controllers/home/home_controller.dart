import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  // variable
  final carouselController = CarouselSliderController();
  RxInt currentIndex = 0.obs;

  // on carousel page changed

  void onPageChanged(int index) {
    currentIndex.value = index;
  }
}
