import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/common/widgets/appbar/appbar.dart';
import 'package:shopping_app/common/widgets/products/cart/cart_counter_icon.dart';
import 'package:shopping_app/features/personalization/controllers/user_controller.dart';
import 'package:shopping_app/utils/constants/colors.dart';
import 'package:shopping_app/utils/constants/texts.dart';

class UHomeAppBar extends StatelessWidget {
  const UHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return UAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title
          Text(
            UTexts.homeAppBarTitle,
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.apply(color: UColors.grey),
          ),

          // subtitle
          Obx(() {
            if (controller.profileLoading.value) {
              return const CircularProgressIndicator();
            }

            return Text(
              controller.user.value.fullName,

              style: Theme.of(
                context,
              ).textTheme.headlineSmall!.apply(color: UColors.white),
            );
          }),
        ],
      ),
      actions: [UCartCounterIcon()],
    );
  }
}
