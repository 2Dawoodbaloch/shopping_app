import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_app/common/widgets/custom_shapes/rounded_container.dart';
import 'package:shopping_app/features/personalization/controllers/adress_controller.dart';
import 'package:shopping_app/features/personalization/models/address_model.dart';
import 'package:shopping_app/utils/constants/colors.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:shopping_app/utils/helpers/helper_functions.dart';

class USingleAddress extends StatelessWidget {
  const USingleAddress({super.key, required this.address, required this.onTap});
  final AddressModel address;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    final controller = AdressController.instance;

    return Obx(() {
      String selectedAddressId = controller.selectedAddress.value.id;
      bool isSelected = selectedAddressId == address.id;
      return InkWell(
        onTap: onTap,
        child: URoundedContainer(
          width: double.infinity,
          showBorder: true,
          backgroundColor: isSelected
              ? UColors.primary.withValues(alpha: 0.5)
              : Colors.transparent,
          borderColor: isSelected
              ? Colors.transparent
              : dark
              ? UColors.darkGrey
              : UColors.grey,
          padding: EdgeInsets.all(USizes.md),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: USizes.spaceBtwItems / 2),
                  // phone number
                  Text(
                    address.phoneNumber,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: USizes.spaceBtwItems / 2),
                  // address
                  Text(address.toString()),
                ],
              ),
              if (isSelected)
                Positioned(
                  top: 0,
                  bottom: 0,
                  right: 6,
                  child: Icon(Iconsax.tick_circle5),
                ),
            ],
          ),
        ),
      );
    });
  }
}
