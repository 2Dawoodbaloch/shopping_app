import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_app/features/personalization/controllers/user_controller.dart';
import 'package:shopping_app/features/personalization/screens/edit_profile/edit_profile.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Obx(() => Text(controller.user.value.fullName)),
      subtitle:Obx(() =>  Text(
        controller.user.value.email,
        style: Theme.of(context).textTheme.bodyMedium,
      ),),
      trailing: IconButton(
        onPressed: () => Get.to(() => EditProfileScreen()),
        icon: Icon(Iconsax.edit),
      ),
    );
  }
}
