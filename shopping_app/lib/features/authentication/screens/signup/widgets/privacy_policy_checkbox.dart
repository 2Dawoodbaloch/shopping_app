// import 'package:flutter/material.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:shopping_app/features/authentication/controllers/singup/signup_controller.dart';
// import 'package:shopping_app/utils/constants/colors.dart';
// import 'package:shopping_app/utils/constants/texts.dart';
// import 'package:shopping_app/utils/helpers/helper_functions.dart';

// class UPrivacyPolicyCheckBox extends StatelessWidget {
//   const UPrivacyPolicyCheckBox({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final dark = UHelperFunctions.isDarkMode(context);
//     final controller = SignupController.Instance;
//     return Row(
//       children: [
//         Obx(
//           () => Checkbox(
//             value: controller.privacyPolicy.value,
//             onChanged: (value) => controller.privacyPolicy.value =
//                 !controller.privacyPolicy.value,
//           ),
//         ),
//         RichText(
//           text: TextSpan(
//             style: Theme.of(context).textTheme.bodyMedium,
//             children: [
//               TextSpan(text: '${UTexts.iAgreeTo}'),
//               TextSpan(
//                 text: ' ${UTexts.privacyPolicy} ',
//                 style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                   color: dark ? UColors.white : UColors.primary,
//                   decoration: TextDecoration.underline,
//                   decorationColor: dark ? UColors.white : UColors.primary,
//                 ),
//               ),
//               TextSpan(text: '${UTexts.and} '),
//               TextSpan(
//                 text: '${UTexts.termsOfUse}',
//                 style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                   color: dark ? UColors.white : UColors.primary,
//                   decoration: TextDecoration.underline,
//                   decorationColor: dark ? UColors.white : UColors.primary,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
