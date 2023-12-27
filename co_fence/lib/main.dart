import 'package:co_fence/common/const/theme.dart';
import 'package:co_fence/firebase_options.dart';
import 'package:co_fence/route/router.dart';
import 'package:co_fence/secret/secret.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

void main() async {
  const MaterialTheme materialTheme = MaterialTheme(TextTheme());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  KakaoSdk.init(nativeAppKey: NATIVE_APP_KEY);
  runApp(
    ProviderScope(
      child: MaterialApp.router(
        theme: materialTheme.light(),
        darkTheme: materialTheme.dark(),
        routerConfig: router,
      ),
    ),
  );
}
