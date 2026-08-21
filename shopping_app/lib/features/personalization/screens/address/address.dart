import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_app/common/style/padding.dart';
import 'package:shopping_app/common/widgets/appbar/appbar.dart';
import 'package:shopping_app/common/widgets/shimmer/addresses_shimmer.dart';
import 'package:shopping_app/features/personalization/controllers/adress_controller.dart';
import 'package:shopping_app/features/personalization/models/address_model.dart';
import 'package:shopping_app/features/personalization/screens/address/add_new_address.dart';
import 'package:shopping_app/features/personalization/screens/address/widgets/single_address.dart';
import 'package:shopping_app/utils/constants/colors.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:shopping_app/utils/helpers/cloud_helper_functions.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdressController());
    return Scaffold(
      //appbar
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          'Address',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),

      // body
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Obx(
            () => FutureBuilder(
              key: Key(controller.refreshData.value.toString()),
              future: controller.getAllAddresses(),
              builder: (context, snapshot) {
                const loader = UAddressesShimmer();
                // Handle, Error, Empty, Loading
                final widget = UCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot,
                  loader: loader,
                );
                if (widget != null) return widget;

                // Data Found
                List<AddressModel> addresses = snapshot.data!;

                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      SizedBox(height: USizes.spaceBtwItems),
                  itemCount: addresses.length,
                  itemBuilder: (context, index) {
                    final address = addresses[index];
                    return USingleAddress(
                      address: address,
                      onTap: () => controller.selectAddress(address),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),

      // floating action button
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddNewAddressScreen()),
        backgroundColor: UColors.primary,
        child: Icon(Iconsax.add, color: Colors.white),
      ),
    );
  }
}
