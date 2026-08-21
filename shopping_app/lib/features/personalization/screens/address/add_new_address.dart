import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_app/common/style/padding.dart';
import 'package:shopping_app/common/widgets/appbar/appbar.dart';
import 'package:shopping_app/common/widgets/button/elevated_button.dart';
import 'package:shopping_app/features/personalization/controllers/adress_controller.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:shopping_app/utils/validators/validation.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdressController());
    return Scaffold(
      // appbar
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          'Add new Adress',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),

      // body
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              children: [
                // NAME
                TextFormField(
                  controller: controller.name,
                  validator: (value) =>
                      UValidator.validateEmptyText("Name", value),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: 'Name',
                  ),
                ),
                SizedBox(height: USizes.spaceBtwInputFields),
                // phone number
                TextFormField(
                  controller: controller.phoneNumber,
                  validator: (value) =>
                      UValidator.validateEmptyText("Phone Number", value),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.mobile),
                    labelText: 'Phone Number',
                  ),
                ),
                SizedBox(height: USizes.spaceBtwInputFields),
                // postal code
                Row(
                  children: [
                    // street
                    Expanded(
                      child: TextFormField(
                        controller: controller.street,
                        validator: (value) =>
                            UValidator.validateEmptyText("Street", value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.building_35),
                          labelText: 'Street',
                        ),
                      ),
                    ),
                    SizedBox(width: USizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        controller: controller.postalCode,
                        validator: (value) =>
                            UValidator.validateEmptyText("Postal Code", value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.code),
                          labelText: 'Postal Code',
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: USizes.spaceBtwInputFields),
                // city
                // state
                Row(
                  children: [
                    // street
                    Expanded(
                      child: TextFormField(
                        controller: controller.city,
                        validator: (value) =>
                            UValidator.validateEmptyText("City", value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.building),
                          labelText: 'City',
                        ),
                      ),
                    ),
                    SizedBox(width: USizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        controller: controller.state,
                        validator: (value) =>
                            UValidator.validateEmptyText("State", value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.activity),
                          labelText: 'State',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: USizes.spaceBtwInputFields),
                // country
                TextFormField(
                  controller: controller.country,
                  validator: (value) =>
                      UValidator.validateEmptyText("Country", value),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.global),
                    labelText: 'Country',
                  ),
                ),
                SizedBox(height: USizes.spaceBtwSections),
                // save button
                UElevatedButton(onPressed: () => controller.addNewAddress(), child: Text('Save')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
