import 'package:co_fence/firebase_options.dart';
import 'package:co_fence/router/router.dart';
import 'package:co_fence/secret/secret.dart';
import 'package:co_fence/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  KakaoSdk.init(nativeAppKey: NATIVE_APP_KEY);
  runApp(ProviderScope(
    child: MaterialApp.router(
      routerConfig: router,
    ),
  ));
}
