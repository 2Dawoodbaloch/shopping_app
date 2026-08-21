import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/common/widgets/image_text/vertical_image_text.dart';
import 'package:shopping_app/common/widgets/shimmer/category_shimmer.dart';
import 'package:shopping_app/features/shop/controllers/category/category_controller.dart';
import 'package:shopping_app/features/shop/models/category_mode.dart';
import 'package:shopping_app/features/shop/screens/sub_category/sub_category.dart';
import 'package:shopping_app/utils/constants/colors.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:shopping_app/utils/constants/texts.dart';

class UHomeCategories extends StatelessWidget {
  const UHomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Padding(
      padding: const EdgeInsets.only(left: USizes.spaceBtwSections),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            UTexts.popularCategories,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.apply(color: UColors.white),
          ),
          SizedBox(height: USizes.spaceBtwItems),

          Obx(() {
            final categories = controller.featuredCategories;

            /// [LoadingState]
            if (controller.isCategoriesLoading.value) {
              return UCategoryShimmer(itemCount: 6,);
            }

            /// [Empty]
            if (categories.isEmpty) {
              return Text('Categories Not Found');
            }

            return SizedBox(
              height: 80,
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    SizedBox(width: USizes.spaceBtwItems),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  CategoryModel category = categories[index];
                  return UVerticalImagesText(
                    title: category.name,
                    image: category.image,
                    textColor: UColors.white,
                    onTap: () => Get.to(() => SubCategoryScren(category: category,)),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
