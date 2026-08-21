import 'dart:convert';

import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopping_app/data/repositories/authentication_repository.dart';
import 'package:shopping_app/data/repositories/product/product_repository.dart';
import 'package:shopping_app/features/shop/models/product_model.dart';
import 'package:shopping_app/utils/popups/snackbar_helpers.dart';

class FavouriteController extends GetxController {
static FavouriteController instance = Get.find();

/// variables
RxMap<String,bool> favourites = <String,bool>{}.obs;
final _storage = GetStorage(AuthenticationRepository.instance.currentUser!.uid);

@override
void onInit(){
  initFavourite();
    super.onInit();
}


Future<void> initFavourite() async {
 String? encodedFavourites = _storage.read('favourites');
 if (encodedFavourites == null) return;

 Map<String,dynamic> storageFavourites = jsonDecode(encodedFavourites) as Map<String,dynamic>;
 favourites.assignAll(storageFavourites.map((key,value) => MapEntry(key, value as bool)));

}

// Function to add or remove product from favourite   
void toggleFavouriteProduct(String productId){
  if (favourites.containsKey(productId)){
    favourites.remove(productId) ;
    saveFavouritesToStorage();
    USnackBarHelpers.customToast(message: "Product has been removed from the Wishlist");
  } else {
    favourites[productId] = true;
    saveFavouritesToStorage();
    USnackBarHelpers.customToast(message: "Product has been added to the Wishlist");
  }
}

/// Functions to store favourite item in local storage
void saveFavouritesToStorage(){
  String encodeFavourites = jsonEncode(favourites);
  _storage.write('favourites', encodeFavourites);
}

/// check product isavaialble or not
bool isFavourie(String productId) {
  return favourites[productId] ?? false;
}

// Function to get all favourite products only
Future<List<ProductModel>> getFavouriteProducts() async {
  final productIds = favourites.keys.toList();
  return await ProductRepository.instance.getFavouriteProducts(productIds);
}

}