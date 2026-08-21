import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shopping_app/data/repositories/category/category_repository.dart';
import 'package:shopping_app/data/repositories/product/product_repository.dart';
import 'package:shopping_app/features/shop/models/category_mode.dart';
import 'package:shopping_app/features/shop/models/product_model.dart';
import 'package:shopping_app/utils/popups/snackbar_helpers.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  /// Variables
  final _repository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;
  RxBool isCategoriesLoading = false.obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  // function to fetch all categories
  Future<void> fetchCategories() async {
    try {
      // start loading
      isCategoriesLoading.value = true;

      // fetch categories
      List<CategoryModel> categories = await _repository.getAllCategories();
      allCategories.assignAll(categories);

      // getting featured categoreis
      featuredCategories.assignAll(
        categories.where(
          (category) => category.isFeatured && category.parentId.isEmpty,
        ),
      );
    } catch (e) {

      USnackBarHelpers.errorSnackBar(title: "Failed", message: e.toString());
    } finally {
      isCategoriesLoading.value = false;
    }
  }


  /// Get Category Products
  Future<List<ProductModel>> getCategoryProduct({required String categoryId,int limit = 4}) async {

    try {

      final products = ProductRepository.instance.getProductsForCategory(categoryId: categoryId,limit: limit);
      return products;

    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: "Failed",message: e.toString());
      return [];
    }
  }

/// Fet sub Categories of all selected category
Future<List<CategoryModel>> getSubCategories(String categoryId) async {

  try {

final subCategories = await _repository.getSubCategories(categoryId);
return subCategories;
  }  catch (e){
    USnackBarHelpers.errorSnackBar(title: "Failed",message: e.toString());
    return [];
  }
}

}
