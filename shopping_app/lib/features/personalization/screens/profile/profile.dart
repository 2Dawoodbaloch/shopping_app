import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_app/common/widgets/texts/section_heading.dart';
import 'package:shopping_app/data/repositories/authentication_repository.dart';
import 'package:shopping_app/features/personalization/screens/address/address.dart';
import 'package:shopping_app/features/personalization/screens/profile/widgets/profile_primary_header.dart';
import 'package:shopping_app/features/personalization/screens/profile/widgets/setting_menu_tile.dart';
import 'package:shopping_app/features/personalization/screens/profile/widgets/user_profile_tile.dart';
import 'package:shopping_app/features/shop/screens/order/order.dart';
import 'package:shopping_app/utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            UProfilePrimaryHeader(),
            // user profile details
            Padding(
              padding: EdgeInsets.all(USizes.defaultSpace),
              child: Column(
                children: [
                  // user profile details
                  UserProfileTile(),
                  SizedBox(height: USizes.spaceBtwItems),

                  // account setting heading
                  USectionHeading(
                    title: 'Account Setting',
                    showActionButton: false,
                  ),

                  // setting menu
                  SettingMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Address',
                    subTitle: 'Set shopping delivery address',
                    onTap: () => Get.to(() => AddressScreen()),
                  ),
                  SettingMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart',
                    subTitle: 'add remove products and move to checkout',
                    onTap: () {},
                  ),
                  SettingMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subTitle: 'In-progress and completed orders',
                    onTap: () => Get.to(() => OrderScreen()),
                  ),
                  SizedBox(height: USizes.spaceBtwSections),

                  // LOGOUT
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: AuthenticationRepository.instance.logout,
                      child: Text('Logout'),
                    ),
                  ),
                  SizedBox(height: USizes.spaceBtwSections),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
