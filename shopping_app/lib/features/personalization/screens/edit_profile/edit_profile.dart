import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_app/common/style/padding.dart';
import 'package:shopping_app/common/widgets/appbar/appbar.dart';
import 'package:shopping_app/common/widgets/texts/section_heading.dart';
import 'package:shopping_app/features/personalization/controllers/user_controller.dart';
import 'package:shopping_app/features/personalization/screens/edit_profile/change_name/change_name.dart';
import 'package:shopping_app/features/personalization/screens/edit_profile/widgets/user_profile_with_edit_icon.dart';
import 'package:shopping_app/utils/constants/sizes.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          'Edit Profile',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        padding: UPadding.screenPadding,
        child: Column(
          children: [
            // user profile with edit icon
            UserProfileWithEditIcon(),
            SizedBox(height: USizes.spaceBtwSections),

            //divider
            Divider(),
            SizedBox(height: USizes.spaceBtwItems),

            // Account Setting heading
            USectionHeading(title: "Account Setting", showActionButton: false),
            SizedBox(height: USizes.spaceBtwItems),

            // Account details
            UserDetailRow(
              title: 'Name',
              value: controller.user.value.fullName,
              onTap: () {
                Get.to(ChangeNameScreen());
              },
            ),
            UserDetailRow(
              title: 'Username',
              value: 'Unknown Pro12',
              onTap: () {},
            ),
            SizedBox(height: USizes.spaceBtwItems),

            // Divider
            Divider(),
            SizedBox(height: USizes.spaceBtwItems),

            // Profile section heading
            USectionHeading(title: "Profile Setting", showActionButton: false),
            SizedBox(height: USizes.spaceBtwItems),

            // profile details
            UserDetailRow(title: 'User ID', value: '1234', onTap: () {}),
            UserDetailRow(
              title: 'Email',
              value: controller.user.value.email,
              onTap: () {},
            ),
            UserDetailRow(
              title: 'Phone Number',
              value: '9274983573',
              onTap: () {},
            ),
            UserDetailRow(title: 'Gender', value: 'Male', onTap: () {}),
            SizedBox(height: USizes.spaceBtwItems),

            // Divider
            Divider(),
            SizedBox(height: USizes.spaceBtwItems),

            TextButton(
              onPressed: () {
                controller.deleteAccountWarningPopup();
              },
              child: Text('Close Account', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
}

class UserDetailRow extends StatelessWidget {
  const UserDetailRow({
    super.key,
    required this.title,
    required this.value,
    this.icon = Iconsax.arrow_right_34,
    required this.onTap,
  });

  final String title, value;
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: USizes.spaceBtwItems / 1.5,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(child: Icon(icon, size: USizes.iconSm)),
          ],
        ),
      ),
    );
  }
}
