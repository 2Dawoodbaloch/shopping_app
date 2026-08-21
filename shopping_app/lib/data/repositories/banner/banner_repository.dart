import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shopping_app/data/services/cloudinary_services.dart';
import 'package:shopping_app/features/shop/models/banners_model.dart';
import 'package:shopping_app/utils/constants/keys.dart';
import 'package:shopping_app/utils/exceptions/firebase_exceptions.dart';
import 'package:shopping_app/utils/exceptions/format_exceptions.dart';
import 'package:shopping_app/utils/exceptions/platform_exceptions.dart';
import 'package:shopping_app/utils/helpers/helper_functions.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;
  final _cloudinaryServices = Get.put(CloudinaryServices());

  /// [UploadBanners] - Function to upload list of banners
  Future<void> uploadBanners(List<BannerModel> banners) async {
    try {
      for (final banner in banners) {
        // convert assetPath to File
        File image = await UHelperFunctions.assetToFile(banner.imageUrl);

        // upload banner image to cloudinary
        dio.Response response = await _cloudinaryServices.uploadImage(
          image,
          UKeys.bannersFolder,
        );
        if (response.statusCode == 200) {
          banner.imageUrl = response.data['url'];
        }
        await _db.collection(UKeys.bannerCollection).doc().set(banner.toJson());

      }
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

// function to fetch all active banners
  Future<List<BannerModel>> fetchActiveBanners() async {
    try {
      final query = await _db.collection(UKeys.bannerCollection).where('active',isEqualTo: true).get();
      if (query.docs.isNotEmpty) {
        List<BannerModel> banners = query.docs
            .map((document) => BannerModel.fromDocument(document))
            .toList();
        return banners;
      }
      return [];
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
