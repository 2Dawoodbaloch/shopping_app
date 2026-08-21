import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/common/widgets/images/circular_images.dart';
import 'package:shopping_app/features/personalization/controllers/user_controller.dart';
import 'package:shopping_app/utils/constants/images.dart';

class UserProfileLogo extends StatelessWidget {
  const UserProfileLogo({super.key});

  @override
  Widget build(BuildContext context) { 
    final controller = UserController.instance;
     return Obx(() {
      final bool isProfilePictureAvailable =
          controller.user.value.profilePicture.isNotEmpty;

      return UCircularImage(
        image: isProfilePictureAvailable
            ? controller.user.value.profilePicture
            : UImages.profileLogo,
        isNetworkImage: true,
        height: 120.0,
        width: 120.0,
        borderWidth: 5,
        padding: 0,
      );
    });
  }
}
