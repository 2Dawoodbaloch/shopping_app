import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:shopping_app/common/widgets/images/rounded_image.dart';
import 'package:shopping_app/common/widgets/texts/section_heading.dart';
import 'package:shopping_app/features/shop/controllers/category/category_controller.dart';
import 'package:shopping_app/features/shop/models/category_mode.dart';
import 'package:shopping_app/features/shop/screens/all_products_screen/all_products_screen.dart';  
import 'package:shopping_app/utils/constants/sizes.dart';

class SearchStoreCategories extends StatelessWidget {
  const SearchStoreCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Obx(() {
      /// [State] - Loading
      if (controller.isCategoriesLoading.value) return Center(child: CircularProgressIndicator());

      /// [State] - Empty
      if (controller.allCategories.isEmpty) return Text('No Categories Found!');

      /// [State] - Data Found
      List<CategoryModel> categories = controller.allCategories;

      return Column(
        children: [
          USectionHeading(title: 'Categories',showActionButton: false,),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              CategoryModel category = categories[index];
              return ListTile(
                onTap: () => Get.to(
                  () => AllProductsScreen(
                    title: category.name,
                    futureMethod: controller.getCategoryProduct(
                      categoryId: category.id,
                    ),
                  ),
                ),
                contentPadding: EdgeInsets.zero,
                leading: URoundedImage(
                  imageUrl: category.image,
                  borderRadius: 0,
                  width: USizes.iconLg,
                  height: USizes.iconMd,
                  isNetworkImage: true,
                ),
                title: Text(category.name),
              ); // ListTile
            },
          ), // ListView.builder
        ],
      );
    });
  }
}
