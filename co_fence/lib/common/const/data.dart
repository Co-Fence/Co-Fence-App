// ignore_for_file: constant_identifier_names

import 'dart:io';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

// localhost
const emulatorIp = 'http://10.0.2.2:8080/api/v22';
const simulatorIp = 'http://127.0.0.1:8080/api/v22';

final ip = Platform.isIOS ? simulatorIp : emulatorIp;

// 작업현장 id
const WORKPLACE_ID = 'WORKPLACE_ID';

String firebasePrefix({
  required bool isReport,
}) {
  if (isReport) {
    return 'https://firebasestorage.googleapis.com/v0/b/co-fence.appspot.com/o/reportImage%2F';
  }
  return 'https://firebasestorage.googleapis.com/v0/b/co-fence.appspot.com/o/noticeImage%2F';
}

// 파이어베이스 스토리지 이미지 prefix
// const FIREBASE_PREFIX =
//     'https://firebasestorage.googleapis.com/v0/b/co-fence.appspot.com/o/';
