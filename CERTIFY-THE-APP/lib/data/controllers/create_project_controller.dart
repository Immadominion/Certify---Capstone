import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:certify/core/constants/enum.dart';
import 'package:certify/data/controllers/base_controller.dart';
import 'package:certify/data/local/secure_storage_service.dart';
import 'package:certify/data/services/create_certify_project.dart';
import 'package:certify/data/services/error_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

final createProjectController = ChangeNotifierProvider<CreateProjectController>(
    (ref) => CreateProjectController());

class CreateProjectController extends BaseChangeNotifier {
  String _imagePath = '';
  String get imagePath => _imagePath;
  File imageFile = File('');
  Uint8List imageBytes = Uint8List(0);
  String base64String = '';
  final ImagePicker picker = ImagePicker();
  late XFile? pickedFile;
  late final Uint8List? image;
  late String jsonString;
  CreateProject createProject = CreateProject();
  final SecureStorageService secureStorageService =
      SecureStorageService(secureStorage: const FlutterSecureStorage());

  set imagePath(String path) {
    _imagePath = path;
    notifyListeners();
  }

  Future<bool> pickImage() async {
    pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Get the file path from the picked image
      imagePath = pickedFile!.path;
      debugPrint('Image Path: $imagePath');
      return true;
    } else {
      debugPrint('No image selected.');
      return false;
    }
  }

  Future<bool> toCreateProject(
    String name,
    String symbol,
    String description,
  ) async {
    loadingState = LoadingState.loading;
    try {
      final fileName = imageFile.path.split('/').last;
      debugPrint('FileName: $fileName');
      debugPrint('FilePath : $imagePath');
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          imagePath,
        ),
        'name': name,
        'symbol': symbol,
        'description': description,
      });

      final response = await createProject.createProject(formData: formData);

      log(response.toString());
      if (response.statusCode == 200) {
        // model = ProfileModel.fromJson(response.data);
        loadingState = LoadingState.idle;
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      loadingState = LoadingState.error;
      ErrorService.handleErrors(e);
      return false;
    } catch (e) {
      loadingState = LoadingState.error;
      ErrorService.handleErrors(e);
      return false;
    }
  }

  Future<bool> toCreateSingleProduct(
    String name,
    String serialNo,
    String description,
  ) async {
    loadingState = LoadingState.loading;
    try {
      File? finalImageFile;

      // Only compress if not running on iOS simulator
      if (!Platform.isIOS ||
          !Platform.environment.containsKey('SIMULATOR_DEVICE_NAME')) {
        final fileName = pickedFile?.name ?? 'image.jpg';
        debugPrint('Original FileName: $fileName');

        // Create compressed file path
        final dir = await path_provider.getTemporaryDirectory();
        final targetPath = '${dir.path}/compressed_$fileName';

        try {
          // Compress the image
          final compressedFile = await FlutterImageCompress.compressAndGetFile(
            imagePath,
            targetPath,
            minWidth: 1024,
            minHeight: 1024,
            quality: 85,
          );

          if (compressedFile != null) {
            finalImageFile = File(compressedFile.path);
            debugPrint('Compression successful');
            debugPrint('Original file size: ${File(imagePath).lengthSync()}');
            debugPrint('Compressed file size: ${finalImageFile.lengthSync()}');
          } else {
            debugPrint('Compression failed, using original file');
            finalImageFile = File(imagePath);
          }
        } catch (e) {
          debugPrint('Compression error: $e, using original file');
          finalImageFile = File(imagePath);
        }
      } else {
        // On iOS simulator, use original file
        finalImageFile = File(imagePath);
      }

      FormData formData = FormData.fromMap({
        'name': name,
        'description': serialNo,
        'sn': description,
        'image': await MultipartFile.fromFile(
          finalImageFile.path,
        ),
      });

      final response =
          await createProject.createSingleProduct(formData: formData);

      log(response.toString());
      if (response.statusCode == 201) {
        // Only delete if it's a compressed file
        jsonString = response.toString();
        if (finalImageFile?.path != imagePath) {
          try {
            await finalImageFile?.delete();
          } catch (e) {
            debugPrint('Error deleting compressed file: $e');
          }
        }
        loadingState = LoadingState.idle;
        return true;
      } else {
        // Only delete if it's a compressed file
        if (finalImageFile?.path != imagePath) {
          try {
            await finalImageFile?.delete();
          } catch (e) {
            debugPrint('Error deleting compressed file: $e');
          }
        }
        return false;
      }
    } on DioException catch (e) {
      loadingState = LoadingState.error;
      ErrorService.handleErrors(e);
      return false;
    } catch (e) {
      loadingState = LoadingState.error;
      ErrorService.handleErrors(e);
      return false;
    }
  }
}
