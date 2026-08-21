import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/common/widgets/layouts/grid_layout.dart';
import 'package:shopping_app/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:shopping_app/common/widgets/textfields/search_bar.dart';
import 'package:shopping_app/common/widgets/texts/section_heading.dart';
import 'package:shopping_app/features/shop/controllers/home/home_controller.dart';
import 'package:shopping_app/features/shop/controllers/product/product_controller.dart';
import 'package:shopping_app/features/shop/models/product_model.dart';
import 'package:shopping_app/features/shop/screens/all_products_screen/all_products_screen.dart';
import 'package:shopping_app/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:shopping_app/features/shop/screens/home/widgets/home_categories.dart';
import 'package:shopping_app/common/widgets/custom_shapes/primary_header_container.dart';
import 'package:shopping_app/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:shopping_app/notification_service.dart';
import 'package:shopping_app/utils/constants/sizes.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    NotificationService notificationService = NotificationService();
    notificationService.requestNotificationPermission();
    notificationService.getFcmToken();
    // local notification
    notificationService.initLocalNotification();
    // there a listner that listen recieve notification in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      notificationService.showNotification(message);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    final productController = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// upper part
            Stack(
              children: [
                // totall height + 20
                SizedBox(height: USizes.homePrimaryHeaderHeight + 10),

                // primary header container
                UPrimaryHeaderContainer(
                  height: USizes.homePrimaryHeaderHeight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // appbar
                      UHomeAppBar(),
                      SizedBox(height: USizes.spaceBtwSections),

                      // home catgores
                      UHomeCategories(),
                    ],
                  ),
                ),

                // searchbar
                USearchBar(),
              ],
            ),

            /// lower part
            /// Banners
            Padding(
              padding: const EdgeInsets.all(USizes.defaultSpace),
              child: Column(
                children: [
                  UPromoSlider(),
                  const SizedBox(height: USizes.spaceBtwSections),

                  /// section heading
                  USectionHeading(
                    title: 'Popular Products',
                    onPressed: () => Get.to(() => AllProductsScreen(
                      title: "Popular Products",
                      futureMethod: productController.getAllFeaturedProduct(),
                    )),
                  ),
                  const SizedBox(height: USizes.spaceBtwSections),

                  // Grid view of  product card
                  Obx(() {
                    if (productController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (productController.featuredProducts.isEmpty) {
                      return Center(child: Text('Products Not Found!'));
                    }

                    return UGridLayout(
                      itemCount: productController.featuredProducts.length,
                      itemBuilder: (context, index) {
                        ProductModel product = productController.featuredProducts[index];
                        return UProductCardVertical(product: product);
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
