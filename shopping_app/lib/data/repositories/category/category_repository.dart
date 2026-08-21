import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:shopping_app/data/services/cloudinary_services.dart';
import 'package:shopping_app/features/shop/models/brand_category_model.dart';
import 'package:shopping_app/features/shop/models/category_mode.dart';
import 'package:shopping_app/features/shop/models/product_category_model.dart';
import 'package:shopping_app/utils/constants/keys.dart';
import 'package:shopping_app/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:shopping_app/utils/exceptions/firebase_exceptions.dart';
import 'package:shopping_app/utils/exceptions/format_exceptions.dart';
import 'package:shopping_app/utils/exceptions/platform_exceptions.dart';
import 'package:shopping_app/utils/helpers/helper_functions.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;
  final _cloudinaryServices = Get.put(CloudinaryServices());

  /// [UploadCategory] - Function to upload list of categories
  Future<void> uploadCategories(List<CategoryModel> categories) async {
    try {
      for (final category in categories) {
        File image = await UHelperFunctions.assetToFile(category.image);
        dio.Response response = await _cloudinaryServices.uploadImage(
          image,
          UKeys.categoryFolder,
        );
        if (response.statusCode == 200) {
          category.image = response.data['url'];
        }
        await _db
            .collection(UKeys.categoryCollection)
            .doc(category.id)
            .set(category.toJson());
      }
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  /// [FetchCategories] - Function to fetch list of categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final query = await _db.collection(UKeys.categoryCollection).get();

      if (query.docs.isNotEmpty) {
        List<CategoryModel> categories = query.docs
            .map((document) => CategoryModel.fromsnapshot(document))
            .toList();
        return categories;
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


   /// [Upload] - Function to upload list of brand categories
  Future<void> uploadBrandCategory(List<BrandCategoryModel> brandCategories) async{
    try{
      for(final brandCategory in brandCategories) {
        await _db.collection(UKeys.brandCategoryCollection).doc().set(brandCategory.toJson());
      }
      
    } on FirebaseException catch(e){
      throw UFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw UFormatException();
    } on PlatformException catch(e){
      throw UPlatformException(e.code).message;
    } catch(e){
      throw 'Something went wrong. Please try again';
    }
  }

  /// [Upload] - Function to upload list of brand categories
  Future<void> uploadProductCategory(List<ProductCategoryModel> productCategories) async{
    try{
      for(final productCategory in productCategories) {
        await _db.collection(UKeys.productCategoryCollection).doc().set(productCategory.toJson());
      }


    } on FirebaseException catch(e){
      throw UFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw UFormatException();
    } on PlatformException catch(e){
      throw UPlatformException(e.code).message;
    } catch(e){
      throw 'Something went wrong. Please try again';
    }
  }


  /// [FetchSubCategories] - Function to fetch list of sub categories
  Future<List<CategoryModel>> getSubCategories(String categoryId) async{
    try{

      final query = await _db.collection(UKeys.categoryCollection).where('parentId', isEqualTo: categoryId).get();

      if(query.docs.isNotEmpty){
        List<CategoryModel> categories = query.docs.map((document) => CategoryModel.fromsnapshot(document)).toList();
        return categories;
      }

      return [];

    }on FirebaseException catch(e){
      throw UFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw UFormatException();
    } on PlatformException catch(e){
      throw UPlatformException(e.code).message;
    } catch(e){
      throw 'Something went wrong. Please try again';
    }
  }

}
