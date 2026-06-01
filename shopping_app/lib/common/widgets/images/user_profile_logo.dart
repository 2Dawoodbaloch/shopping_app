import 'package:flutter/material.dart';
import 'package:shopping_app/common/widgets/images/circular_images.dart';
import 'package:shopping_app/utils/constants/images.dart';

class UserProfileLogo extends StatelessWidget {
  const UserProfileLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return UCircularImage(
      image: UImages.profileLogo,
      height: 120.0,
      width: 120,
      borderWidth: 5,
      padding: 0,
    );
  }
}
