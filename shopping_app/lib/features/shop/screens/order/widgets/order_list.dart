import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_app/common/widgets/custom_shapes/rounded_container.dart';
import 'package:shopping_app/common/widgets/loaders/animation_loader.dart';
import 'package:shopping_app/features/shop/controllers/order/order_controller.dart';
import 'package:shopping_app/features/shop/models/order_model.dart';
import 'package:shopping_app/utils/constants/colors.dart';
import 'package:shopping_app/utils/constants/sizes.dart';
import 'package:shopping_app/utils/helpers/cloud_helper_functions.dart';
import 'package:shopping_app/utils/helpers/helper_functions.dart';

class UOrderListItems extends StatelessWidget {
  const UOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    final controller = Get.put(OrderController());
    return FutureBuilder(
      future: controller.fetchUserOrders(),
      builder: (context, snapshot) {
        /// Handle Error, Loading and Empty State
        final nothingFound = UAnimationLoader(
          text: 'No order yet!',
          showActionButton: true,
        );
        final widget = UCloudHelperFunctions.checkMultiRecordState(
          snapshot: snapshot,
          nothingFound: nothingFound,
        );

        if (widget != null) return widget;

        List<OrderModel> orders = snapshot.data!;
        return ListView.separated(
          separatorBuilder: (context, index) =>
              SizedBox(height: USizes.spaceBtwItems),
          itemCount: orders.length,
          itemBuilder: (context, index) {
              OrderModel  order = orders[index];
            return URoundedContainer(
              showBorder: true,
              backgroundColor: dark ? UColors.dark : UColors.light,
              padding: EdgeInsets.all(USizes.md),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //row 1
                  Row(
                    children: [
                      // ship icon
                      Icon(Iconsax.ship),
                      SizedBox(width: USizes.spaceBtwItems / 2),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // title
                            Text(
                              order.orderStatusText,
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .apply(
                                    color: UColors.primary,
                                    fontWeightDelta: 1,
                                  ),
                            ),

                            // date
                            Text(
                              order.formattedOrderDate,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      ),

                      IconButton(
                        onPressed: () {},
                        icon: Icon(Iconsax.arrow_right_34, size: USizes.iconSm),
                      ),
                    ],
                  ),

                  SizedBox(height: USizes.spaceBtwItems),
                  // 2 - row
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            // tag icon
                            Icon(Iconsax.tag),
                            SizedBox(width: USizes.spaceBtwItems / 2),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // order
                                  Text(
                                    'Orders',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelMedium,
                                  ),

                                  // order value
                                  Text(
                                    order.id,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Row(
                          children: [
                            Icon(Iconsax.calendar),
                            SizedBox(width: USizes.spaceBtwItems / 2),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // shipping  title
                                  Text(
                                    'Shopping Date',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelMedium,
                                  ),

                                  // shipping date
                                  Text(
                                    order.formattedDeliveryDate,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
