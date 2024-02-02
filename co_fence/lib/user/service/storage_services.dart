import 'dart:typed_data';

import 'package:co_fence/common/const/data.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageServices {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // 파이어베이스 스토리지에 이미지 업로드
  Future<String> uploadImageToStorage({
    required String childName,
    required String email,
    required Uint8List file,
    required bool isReport,
    required bool isNotice,
  }) async {
    try {
      Reference reference = _storage.ref().child(childName).child(email);
      if (isReport | isNotice) {
        String id = const Uuid().v1();
        reference = reference.child(id);
      }

      UploadTask uploadTask = reference.putData(file);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      final prefix = firebasePrefix(
        isReport: isReport,
        isNotice: isNotice,
      );

      String shortUrl = (isReport | isNotice)
          ? downloadUrl.replaceFirst(prefix, '')
          : downloadUrl;

      // &token=... 제거
      shortUrl = shortUrl.split('&').first;

      return shortUrl;
    } catch (e) {
      print(e);
      return ''; // 업로드 실패 시 빈 문자열 반환 또는 다른 오류 처리 방식 선택
    }
  }
}
