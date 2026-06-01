import 'package:flutter/material.dart';
import 'package:shopping_app/common/widgets/custom_shapes/primary_header_container.dart';
import 'package:shopping_app/common/widgets/images/user_profile_logo.dart';
import 'package:shopping_app/utils/constants/sizes.dart';

class UProfilePrimaryHeader extends StatelessWidget {
  const UProfilePrimaryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// totall height
        SizedBox(height: USizes.profilePrimaryHeaderHeight + 60),

        // primary header
        UPrimaryHeaderContainer(
          height: USizes.profilePrimaryHeaderHeight,
          child: Container(),
        ),

        // User Profiles
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Center(child: UserProfileLogo()),
        ),
      ],
    );
  }
}
