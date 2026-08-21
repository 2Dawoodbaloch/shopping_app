import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_app/common/widgets/icons/circular_icon.dart';
import 'package:shopping_app/common/widgets/images/user_profile_logo.dart';
import 'package:shopping_app/features/personalization/controllers/user_controller.dart';

class UserProfileWithEditIcon extends StatelessWidget {
  const UserProfileWithEditIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Stack(
      children: [
        // user profile logo
        Center(child: UserProfileLogo()),

        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Center(
            child: Center(child: UCircularIcon( icon: Iconsax.edit,onPressed: () => controller.updateUserProfilePicture(),)),
          ),
        ),
      ],
    );
  }
}
