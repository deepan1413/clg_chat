import 'dart:io';

import 'package:clg_chat/features/storage/domain/storage_repo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

class FirebaseStorageRepo implements StorageRepo {
  final FirebaseStorage storage = FirebaseStorage.instance;
  @override
  Future<String?> uploadProfileImageMobile(String path, String fileName) async {
    return _uploadFile(path, fileName, "profile_images");
  }

  @override
  Future<String?> uploadProfileImageWeb(Uint8List path, String fileName) {
    return _uploadFileBytes(path, fileName, "profile_images");
  }

  Future<String?> _uploadFile(
    String path,
    String fileName,
    String folder,
  ) async {
    try {
      final file = File(path);
      final storageRef = storage.ref().child('$folder/$fileName');
      final uploadTask = await storageRef.putFile(file);
      final downloadURL = await uploadTask.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      return null;
    }
  }

  Future<String?> _uploadFileBytes(
    Uint8List path,
    String fileName,
    String folder,
  ) async {
    try {
      final storageRef = storage.ref().child('$folder/$fileName');
      final uploadTask = await storageRef.putData(path);
      final downloadURL = await uploadTask.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      return null;
    }
  }
}
