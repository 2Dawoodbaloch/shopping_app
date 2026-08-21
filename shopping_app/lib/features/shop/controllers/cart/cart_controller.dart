import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopping_app/data/repositories/authentication_repository.dart';
import 'package:shopping_app/features/shop/controllers/product/variation_controller.dart';
import 'package:shopping_app/features/shop/models/cart_item_model.dart';
import 'package:shopping_app/features/shop/models/product_model.dart';
import 'package:shopping_app/features/shop/models/product_variation_model.dart';
import 'package:shopping_app/utils/constants/enums.dart';
import 'package:shopping_app/utils/constants/keys.dart';
import 'package:shopping_app/utils/popups/snackbar_helpers.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();
  final variationController = VariationController.instance;

  /// Variables
  final _storage = GetStorage(
    AuthenticationRepository.instance.currentUser!.uid,
  );
  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  // @override
  // void onInit() {
  //   loadCartItems();
  //   super.onInit();
  // }

  CartController() {
    loadCartItems();
  }



  /// Direct Checkout single product
  Future<void> checkout(ProductModel product) async {
    // clear the cart
    cartItems.clear();

    // set quantity to 1 by default
    productQuantityInCart.value = 1;

    // Check Variation of product if it is variable product
    if (product.productType == ProductType.variable.toString() &&
        variationController.selectedVariation.value.id.isEmpty) {
      USnackBarHelpers.customToast(message: 'Select Variation');
      return;
    }
    // Out Of Stock Status
    if (product.productType == ProductType.variable.toString()) {
      if (variationController.selectedVariation.value.stock < 1) {
        USnackBarHelpers.warningSnackBar(
          title: 'Out Of Stock',
          message: 'This variation is out of stock',
        );
        return;
      }
    } else {
      if (product.stock < 1) {
        USnackBarHelpers.warningSnackBar(
          title: 'Out Of Stock',
          message: 'This product is out of stock',
        );
      }
    }
  }

 
  // load all cart items from local storage
  void loadCartItems() {
    List<dynamic>? storedCartItems = _storage.read(UKeys.cartItemsKey);
    if (storedCartItems != null) {
      cartItems.assignAll(
        storedCartItems.map(
          (item) => CartItemModel.fromJson(item as Map<String, dynamic>),
        ),
      );
      updateCartTotals();
    }
  }

  /// Add Items in the cart
  void addToCart(ProductModel product) {
    // Check quantity of the product
    if (productQuantityInCart < 1) {
      USnackBarHelpers.customToast(message: 'Select Quantity');
      return;
    }

    if (product.productType == ProductType.variable.toString() &&
        variationController.selectedVariation.value.id.isEmpty) {
      USnackBarHelpers.customToast(message: 'Select Variation');
      return;
    }

    // Out Of Stock Status
    if (product.productType == ProductType.variable.toString()) {
      if (variationController.selectedVariation.value.stock < 1) {
        USnackBarHelpers.warningSnackBar(
          title: 'Out Of Stock',
          message: 'This variation is out of stock',
        );
        return;
      }
    } else {
      if (product.stock < 1) {
        USnackBarHelpers.warningSnackBar(
          title: 'Out Of Stock',
          message: 'This product is out of stock',
        );
      }
    }

    // Convert the ProductModel to CartItemModel with given quantity
    CartItemModel selectedCartItem = convertToCartItem(
      product,
      productQuantityInCart.value,
    );

    // check if already added in the cart
    int index = cartItems.indexWhere(
      (cartItem) =>
          cartItem.productId == selectedCartItem.productId &&
          selectedCartItem.variationId == cartItem.variationId,
    );
    if (index >= 0) {
      // This quantity is already added or updated/removed from the cart
      cartItems[index].quantity = selectedCartItem.quantity;
    } else {
      cartItems.add(selectedCartItem);
    }
    // Update Cart
    updateCart();

    // Show message
    USnackBarHelpers.customToast(
      message: 'Your product has been added to the Cart',
    );
  }

  // Add One item to cart
  void addOneToCart(CartItemModel item) {
    int index = cartItems.indexWhere(
      (cartItem) =>
          item.productId == cartItem.productId &&
          item.variationId == cartItem.variationId,
    );

    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(item);
    }
    updateCart();
  }

  /// Remove one item from the cart
  void removeOneFromCart(CartItemModel item) {
    int index = cartItems.indexWhere(
      (cartItem) =>
          item.productId == cartItem.productId &&
          item.variationId == cartItem.variationId,
    );
    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        cartItems[index].quantity == 1
            ? removeFromCartDialog(index)
            : cartItems.removeAt(index);
      }
    }
    updateCart();
  }

  /// show dialog to remove the item from the cart
  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: 'Remove Product',
      middleText: 'Are you sure you want to remove this product?',
      onConfirm: () {
        cartItems.removeAt(index);
        updateCart();
        USnackBarHelpers.customToast(message: 'Product removed from the cart');
        Get.back();
      },
      onCancel: () {},
    );
  }

  /// get item quantity of same specific products
  int getProductQuantityInCart(String productId) {
    final itemQuantity = cartItems
        .where((cartItem) => cartItem.productId == productId)
        .fold(
          0,
          (previousValue, cartItem) => previousValue + cartItem.quantity,
        );

    return itemQuantity;
  }

  /// get variations quantity of specific products
  int getVariationQuantityInCart(String productId, String variationId) {
    CartItemModel cartItemModel = cartItems.firstWhere(
      (item) => item.productId == productId && item.variationId == variationId,
      orElse: () => CartItemModel.empty(),
    );
    return cartItemModel.quantity;
  }

  /// Update Cart
  void updateCart() {
    saveCartItems();
    updateCartTotals();
    cartItems.refresh();
  }

  /// Save cart items into local storage
  void saveCartItems() {
    List<Map<String, dynamic>> cartItemsList = cartItems
        .map((item) => item.toJson())
        .toList();
    _storage.write(UKeys.cartItemsKey, cartItemsList);
  }

  /// Update the total price & no Of Items of the cart
  void updateCartTotals() {
    double calculateTotalPrice = 0.0;
    int calculateNoOfItems = 0;

    for (final item in cartItems) {
      calculateTotalPrice += (item.price) * item.quantity.toDouble();
      calculateNoOfItems += item.quantity;
    }
    totalCartPrice.value = calculateTotalPrice;
    noOfCartItems.value = calculateNoOfItems;
  }

  // Convert the ProductModel to CartItemModel with given quantity
  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    if (product.productType == ProductType.single.toString()) {
      // Reset Variation in case of single product type
      variationController.resetSelectedAttributes();
    }
    ProductVariationModel variation =
        variationController.selectedVariation.value;
    bool isVariation = variation.id.isNotEmpty;
    String image = isVariation ? variation.image : product.thumbnail;
    double price = isVariation
        ? variation.salePrice > 0.0
              ? variation.salePrice
              : variation.price
        : product.salePrice > 0.0
        ? product.salePrice
        : product.price;

    return CartItemModel(
      productId: product.id,
      quantity: quantity,
      title: product.title,
      brandName: product.brand != null ? product.brand!.name : '',
      image: image,
      price: price,
      selectedVariation: isVariation ? variation.attributeValues : null,
      variationId: variation.id,
    );
  }

  /// Initialize already added items count in the cart
  void updateAlreadyAddedProductCount(ProductModel product) {
    if (product.productType == ProductType.single.toString()) {
      productQuantityInCart.value = getProductQuantityInCart(product.id);
    } else {
      String variationId = variationController.selectedVariation.value.id;
      if (variationId.isNotEmpty) {
        productQuantityInCart.value = getVariationQuantityInCart(
          product.id,
          variationId,
        );
      } else {
        productQuantityInCart.value = 0;
      }
    }
  }

  void clearCart() {
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }
}
