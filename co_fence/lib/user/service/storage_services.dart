import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class StorageServices {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // 파이어베이스 스토리지에 이미지 업로드
  Future<String> uploadImageToStorage(
    String childName,
    String email,
    Uint8List file,
  ) async {
    try {
      Reference reference = _storage.ref().child(childName).child(email);

      UploadTask uploadTask = reference.putData(file);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print(e);
      return ''; // 업로드 실패 시 빈 문자열 반환 또는 다른 오류 처리 방식 선택
    }
  }
}
