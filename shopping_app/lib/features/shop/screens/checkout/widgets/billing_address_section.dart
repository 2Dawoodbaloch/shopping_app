import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:shopping_app/common/widgets/texts/section_heading.dart';
import 'package:shopping_app/features/personalization/controllers/adress_controller.dart';
import 'package:shopping_app/utils/constants/colors.dart';
import 'package:shopping_app/utils/constants/sizes.dart';

class UBillingAddressSection extends StatelessWidget {
  const UBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdressController());
    controller.getAllAddresses();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TEXt - billing address
        USectionHeading(
          title: 'Billing Address',
          buttonTitle: 'Change',
          onPressed: () => controller.selectNewAddressBottomSheet(context),
        ),


        Obx(() {
          final address = controller.selectedAddress.value;
          if(address.id.isEmpty){
            return Text('select Address');
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(address.name, style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: USizes.spaceBtwItems / 2),

              Row(
                children: [
                  Icon(
                    Icons.phone,
                    size: USizes.iconSm,
                    color: UColors.darkerGrey,
                  ),
                  SizedBox(width: USizes.spaceBtwItems),
                  Text(address.phoneNumber),
                ],
              ),
              SizedBox(height: USizes.spaceBtwItems / 2),

              Row(
                children: [
                  Icon(
                    Icons.location_history,
                    size: USizes.iconSm,
                    color: UColors.darkerGrey,
                  ),
                  SizedBox(width: USizes.spaceBtwItems),
                  Expanded(
                    child: Text(
                     address.toString(),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ],
    );
  }
}
