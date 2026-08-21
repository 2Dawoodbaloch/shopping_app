import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/common/widgets/appbar/appbar.dart';
import 'package:shopping_app/common/widgets/images/rounded_image.dart';
import 'package:shopping_app/common/widgets/products/favourite/favourite_icon.dart';
import 'package:shopping_app/features/shop/controllers/product/image_controller.dart';
import 'package:shopping_app/features/shop/models/product_model.dart';
import 'package:shopping_app/utils/constants/colors.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:shopping_app/utils/helpers/helper_functions.dart';

class UProductThmbnaiAndSlider extends StatelessWidget {
  const UProductThmbnaiAndSlider({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    final controller = Get.put(ImageController());
    List<String> image = controller.getAllProductImages(product);

    return Container(
      color: dark ? UColors.darkGrey : UColors.light,
      child: Stack(
        children: [
          // image thumbnail
          SizedBox(
            height: 400,
            child: Padding(
              padding: EdgeInsets.all(USizes.productImageRadius * 2),
              child: Center(
                child: Obx(() {
                  final image = controller.selectedProductImage.value;
                  return GestureDetector(
                    onTap: () {
                       controller.showEnlargeImage(image);
             
                    },
                    child: CachedNetworkImage(
                      imageUrl: controller.selectedProductImage.value,
                      progressIndicatorBuilder: (context, url, progress) =>
                          CircularProgressIndicator(
                            color: UColors.primary,
                            value: progress.progress,
                          ),
                    ),
                  );
                }),
              ),
            ),
          ),

          // image slider
          Positioned(
            left: USizes.defaultSpace,
            right: 0,
            bottom: 30,
            child: SizedBox(
              height: 80,
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    SizedBox(width: USizes.spaceBtwItems),
                shrinkWrap: true,
                itemCount: image.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Obx((){
                  bool isSelectedImage = controller.selectedProductImage.value == image[index];
                  return URoundedImage(
                  width: 60,
                  onTap: () => controller.selectedProductImage.value = image[index],
                  isNetworkImage: true,
                  backgroundColor: dark ? UColors.dark : UColors.white,
                  padding: EdgeInsets.all(USizes.sm),
                  border: Border.all(color: isSelectedImage ? UColors.primary : Colors.transparent),
                  imageUrl: image[index],
                );
                })
              ),
            ),
          ),

          // appbar
          UAppBar(
            showBackArrow: true,
            actions: [UFavouriteIcon(productId: product.id)],
          ),
        ],
      ),
    );
  }
}
