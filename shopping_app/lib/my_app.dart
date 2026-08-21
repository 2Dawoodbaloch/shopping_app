import 'package:flutter/material.dart';
import 'package:shopping_app/binding/network_binding.dart';
import 'package:shopping_app/routes/app_routes.dart';
import 'package:shopping_app/utils/constants/colors.dart';
import 'package:shopping_app/utils/theme/theme.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: UAppTheme.lightTheme,
      darkTheme: UAppTheme.darkTheme,
      initialBinding:NetworkBinding(),
      getPages: UAppRoutes.screens,
      home: Scaffold(
        backgroundColor: UColors.primary,
        body: Center(child: CircularProgressIndicator(color: UColors.white)),
      ),
    );
  }
}
