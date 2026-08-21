import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:shopping_app/data/repositories/product/product_repository.dart';
import 'package:shopping_app/features/shop/models/product_model.dart';
import 'package:shopping_app/utils/popups/snackbar_helpers.dart';

class AllProductController extends GetxController {
  static AllProductController get instance => Get.find();

  final _repository = ProductRepository.instance;
  final RxString selectedSortOption = 'Name'.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;

  Future<List<ProductModel>> fetchProductQuery(Query? query) async {
    try {
      if (query == null) return [];

      List<ProductModel> products = await _repository.fetchProductsByQuery(
        query,
      );
      return products;
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: "failed", message: e.toString());
      return [];
    }
  }

  void sortProducts(String sortOption) {
    selectedSortOption.value == sortOption;

    switch (sortOption) {
      case "Name":
        products.sort((a, b) => a.title.compareTo(b.title));
        break;
      case "Lower Price":
        products.sort((a, b) => a.price.compareTo(b.price));
        break;
      case "Higher Price":
        products.sort((a, b) => b.price.compareTo(a.price));
        break;
      case "Newest":
        products.sort((a, b) => b.date!.compareTo(a.date!));
        break;
      case "Sale":
        products.sort((a, b) {
          if (b.salePrice > 0) {
            return b.salePrice.compareTo(a.salePrice);
          } else if (a.salePrice > 0) {
            return -1;
          } else {
            return 1;
          }
        });
      default:
    }
  }


  /// Function to assign products

  void assignProducts(List<ProductModel> products) {
    this.products.assignAll(products);
    sortProducts('Name');
  }
}
