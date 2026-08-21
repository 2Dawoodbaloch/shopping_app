import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_utils/src/extensions/num_extensions.dart';
import 'package:shopping_app/data/repositories/product/product_repository.dart';
import 'package:shopping_app/features/shop/models/product_model.dart';
import 'package:shopping_app/utils/constants/enums.dart';
import 'package:shopping_app/utils/constants/texts.dart';
import 'package:shopping_app/utils/popups/snackbar_helpers.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  /// Variables
  final _repository = Get.put(ProductRepository());
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getFeaturedProduct();
    super.onInit();
  }

  /// Function to get all products
  Future<List<ProductModel>> getAllProducts() async {
    try {
      List<ProductModel> products = await _repository.fetchAllProducts();
      return products;
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Error', message: e.toString());
      return [];
    }
  }

  // function to get only 4 featured functions
  Future<void> getFeaturedProduct() async {
    try {
      isLoading.value = true;
      List<ProductModel> featuredProducts = await _repository
          .fetchFeaturedProducts();

      //assign featured functions
      this.featuredProducts.assignAll(featuredProducts);
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // get all featured products
  // function to get only 4 featured functions
  Future<List<ProductModel>> getAllFeaturedProduct() async {
    try {
      List<ProductModel> featuredProducts = await _repository
          .fetchAllProducts();
      return featuredProducts;
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
      return [];
    }
  }

  //Calculate sale Percentage
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0.0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;

    return percentage.toStringAsFixed(1);
  }

  String getProductprice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    // if not variation exist, return the single price or sale price
    if (product.productType == ProductType.single.toString()) {
      return product.salePrice > 0
          ? product.salePrice.toString()
          : product.price.toString();
    } else {
      // calculate the smallest and largest price among variation
      for (final variation in product.productVariations!) {
        double variationPrice = variation.salePrice > 0
            ? variation.salePrice
            : variation.price;

        if (variationPrice > largestPrice) {
          largestPrice = variationPrice;
        }
        if (variationPrice < smallestPrice) {
          smallestPrice = variationPrice;
        }
      }

      if (smallestPrice.isEqual(largestPrice)) {
        return largestPrice.toStringAsFixed(0);
      } else {
        return '${largestPrice.toStringAsFixed(0)} - ${UTexts.currency}${smallestPrice.toStringAsFixed(0)}';
      }
    }
  }

  // Get Product Stock Status
  String getProductStockStatus(int stock) {
    return stock > 0 ? 'In Stock' : 'Out of Stock';
  }
}
