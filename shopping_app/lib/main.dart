import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopping_app/data/repositories/authentication_repository.dart';
import 'package:shopping_app/firebase_options.dart';
import 'package:shopping_app/my_app.dart';

Future<void> main() async {
  /// widget flutter binding
  final widgetBinding = WidgetsFlutterBinding.ensureInitialized();

  // flutter native splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetBinding);

  // Get storage initialization
  await GetStorage.init();

  // firebase initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    Get.put(AuthenticationRepository());
  });

  // portrait up the device
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}
