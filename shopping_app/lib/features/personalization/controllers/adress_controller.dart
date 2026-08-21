import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/common/widgets/button/elevated_button.dart';
import 'package:shopping_app/common/widgets/loaders/circular_loader.dart';
import 'package:shopping_app/common/widgets/texts/section_heading.dart';
import 'package:shopping_app/data/repositories/address/address_repository.dart';
import 'package:shopping_app/features/personalization/models/address_model.dart'
    show AddressModel;
import 'package:shopping_app/features/personalization/screens/address/add_new_address.dart';
import 'package:shopping_app/features/personalization/screens/address/widgets/single_address.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:shopping_app/utils/helpers/cloud_helper_functions.dart';
import 'package:shopping_app/utils/helpers/network_manager.dart';
import 'package:shopping_app/utils/popups/full_screen_loader.dart';
import 'package:shopping_app/utils/popups/snackbar_helpers.dart';

class AdressController extends GetxController {
  static AdressController get instance => Get.find();

  /// Variables
  final _repository = Get.put(AddressRepository());
  Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  RxBool refreshData = false.obs;

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();

  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  /// function to save new address
  Future<void> addNewAddress() async {
    try {
      // start loading
      UFullScreenLoader.openLoadingDialog('Storing Address ... ');

      // check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!addressFormKey.currentState!.validate()) {
        UFullScreenLoader.stopLoading();
        return;
      }

      // Create Address Model
      AddressModel address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        postalCode: postalCode.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        country: country.text.trim(),
        dateTime: DateTime.now(),
      );

      // Save Address
      String addressId = await _repository.addAddress(address);

      // update address id
      address.id = addressId;

      // update selected addrees
      selectAddress(address);
      // stop loading
      UFullScreenLoader.stopLoading();

      // show success message
      USnackBarHelpers.successSnackBar(
        title: 'Congratulations',
        message: 'Your address has been save success',
      );

      // refresh data toggle
      refreshData.toggle();
      // resetform field
      resetFormFields();
      // go back
      Navigator.pop(Get.context!);
      Navigator.pop(Get.context!);
      Get.back();
    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(
        title: "Failed",
        message: 'something went wrong...',
      );
    }
  }



/// Function to show Bottom Sheet to select address
/// Function to show Bottom Sheet to select address
Future<void> selectNewAddressBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (context) => Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(USizes.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                USectionHeading(title: 'Select Address', showActionButton: false),
                SizedBox(height: USizes.spaceBtwItems),
                FutureBuilder(
                  future: getAllAddresses(),
                  builder: (context, snapshot) {
                    /// Handle Error, Loading, Empty States
                    final widget = UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                    if (widget != null) return widget;
        
                    return ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => SizedBox(height: USizes.spaceBtwItems),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) => USingleAddress(
                        address: snapshot.data![index],
                        onTap: () {
                          selectAddress(snapshot.data![index]);
                          Get.back();
                        },
                      ), // USingleAddress
                    ); // ListView.separated
                  },
                ), // FutureBuilder
                SizedBox(height: USizes.spaceBtwSections,)
              ],
            ), // Column
          ), // Container
        ),

        Positioned(
          bottom: USizes.defaultSpace,
          left: USizes.defaultSpace * 2,
          right: USizes.defaultSpace * 2,
          child: UElevatedButton(onPressed: () => Get.to(() => AddNewAddressScreen()), child: Text("Add New Address")))
      ],
    ),
  ); // showModalBottomSheet
}

  /// function to get all address
  Future<List<AddressModel>> getAllAddresses() async {
    try {
      List<AddressModel> addresses = await _repository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere(
        (address) => address.selectedAddress,
        orElse: () => AddressModel.empty(),
      );
      return addresses;
    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(
        title: "Failed",
        message: 'something went wrong...',
      );
      return [];
    }
  }

  // function to reset field
  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();

    addressFormKey.currentState!.reset();
  }

  /// Function to select address
  Future<void> selectAddress(AddressModel newSelectedAddsess) async {
    try {
      // start loading
      Get.defaultDialog(
        title: '',
        onWillPop: () async => false,
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: UCircularLoader(),
      );

      // un-select the already selected
      if (selectedAddress.value.id.isNotEmpty) {
        await _repository.updateSelectedField(selectedAddress.value.id, false);
      }

      // assign selected address
      newSelectedAddsess.selectedAddress = true;
      selectedAddress.value = newSelectedAddsess;

      // set the selected address ture in the firebase
      await _repository.updateSelectedField(selectedAddress.value.id, true);

      // go back
      Get.back();
    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(
        title: "Failed",
        message: 'something went wrong...',
      );
    }
  }
}
