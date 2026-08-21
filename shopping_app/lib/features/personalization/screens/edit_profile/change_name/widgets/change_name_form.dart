import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_app/common/widgets/button/elevated_button.dart';
import 'package:shopping_app/features/personalization/controllers/change_name_controller.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:shopping_app/utils/constants/texts.dart';
import 'package:shopping_app/utils/validators/validation.dart';

class UChangeNameForm extends StatelessWidget {
  const UChangeNameForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ChangeNameController.instance;
    return Form(
      key: controller.updateUserFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: controller.firstName,
            validator: (value) =>
                UValidator.validateEmptyText('First Name', value),
            decoration: InputDecoration(
              labelText: UTexts.firstName,
              prefixIcon: Icon(Iconsax.user),
            ),
          ),
          SizedBox(height: USizes.spaceBtwInputFields),
          TextFormField(
            controller: controller.lastName,
            validator: (value) =>
                UValidator.validateEmptyText('Last Name', value),
            decoration: InputDecoration(
              labelText: UTexts.lastName,
              prefixIcon: Icon(Iconsax.user),
            ),
          ),
          SizedBox(height: USizes.spaceBtwInputFields),

          //create user account
          UElevatedButton(
            onPressed: () {
              controller.updateUserName();
            },
            child: Text(UTexts.save),
          ),
        ],
      ),
    );
  }
}
