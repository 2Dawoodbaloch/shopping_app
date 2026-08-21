import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/features/personalization/controllers/change_name_controller.dart';
import 'package:shopping_app/features/personalization/screens/edit_profile/change_name/widgets/change_name_form.dart';
import 'package:shopping_app/features/personalization/screens/edit_profile/change_name/widgets/change_name_header.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:shopping_app/utils/constants/texts.dart';

class ChangeNameScreen extends StatefulWidget {
  const ChangeNameScreen({super.key});

  @override
  State<ChangeNameScreen> createState() => _ChangeNameScreenState();
}

class _ChangeNameScreenState extends State<ChangeNameScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put(ChangeNameController());
    return Scaffold(
      appBar: AppBar(title: Text(UTexts.updateName)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(USizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UChangeNameHeader(),
              SizedBox(height: USizes.spaceBtwSections),

              // Form
              UChangeNameForm(),
              SizedBox(height: USizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
