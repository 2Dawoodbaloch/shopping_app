import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:dio/dio.dart' as dio;
import 'package:shopping_app/utils/constants/apis.dart';
import 'package:shopping_app/utils/constants/keys.dart';

class CloudinaryServices extends GetxController {
  static CloudinaryServices get  instance => Get.find();

// dio variable
final _dio = dio.Dio();


  /// [UploadImage] - Function to upload user profile picture
  Future<dio.Response> uploadImage(File image,String folderName) async {
    try {
      String api = UAppUrls.uploadApi(UKeys.cloudName);

      // Added await for MultipartFile.fromFile and fixed the FormData type typo
      dio.FormData formData = dio.FormData.fromMap({
        'upload_preset': UKeys.uploadPreset,
        'folder': folderName,
        'file': await dio.MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
      });

      dio.Response response = await _dio.post(api, data: formData);

      return response;
    } catch (e) {
      throw 'Failed to upload profile picture. Please try again';
    }
  }

  /// [DeleteImage] - Function to delete profile picture
  Future<dio.Response> deleteImage(String publicId) async {
    try {
      String api = UAppUrls.deleteApi(UKeys.cloudName);

      int timestamp = (DateTime.now().millisecondsSinceEpoch / 1000).round();

      String signatureBase =
          'public_id=$publicId&timestamp=$timestamp${UKeys.apiSecret}';
      String signature = sha1.convert(utf8.encode(signatureBase)).toString();

      final formData = dio.FormData.fromMap({
        'public_id': publicId,
        'api_key': UKeys.apiKey,
        'timestamp': timestamp,
        'signature': signature,
      });
      dio.Response response = await _dio.post(api, data: formData);

      return response;
    } catch (e) {
      throw 'something went wrong please try again';
    }
  }
}