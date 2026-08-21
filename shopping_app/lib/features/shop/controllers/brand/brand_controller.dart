import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shopping_app/data/repositories/brand/brand_repository.dart';
import 'package:shopping_app/data/repositories/product/product_repository.dart';
import 'package:shopping_app/features/shop/models/brand_model.dart';
import 'package:shopping_app/features/shop/models/product_model.dart';
import 'package:shopping_app/utils/popups/snackbar_helpers.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  /// Variables
  final _repository = Get.put(BrandRepository());
  RxList<BrandModel> allBrands = <BrandModel>[].obs;
  RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getBrands();
    super.onInit();
  }

  // get all brand
  Future<void> getBrands() async {
    try {
      // start loading
      isLoading.value = true;

      List<BrandModel> allBrands = await _repository.fetchBrands();

      this.allBrands.assignAll(allBrands);

      featuredBrands.assignAll(
        allBrands.where((brand) => brand.isFeatured ?? false).toList(),
      );
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Get Brand Specific Products
  Future<List<ProductModel>> getBrandProducts(String brandId,{int limit = -1}) async {
    try {
      List<ProductModel> products = await ProductRepository.instance
          .getProductsForBrand(brandId: brandId,limit: limit);
      return products;
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: "Failed", message: e.toString());
      return [];
    }
  }



// get brand for specfic category
Future<List<BrandModel>> getBrandForCategory(String categoryId) async {
  try {

final brands = await _repository.fetchBrandsForCategory(categoryId);
return brands;
  } catch (e) {
    USnackBarHelpers.errorSnackBar(title: "Failed",message: e.toString());
    return [];
  }
}

}
