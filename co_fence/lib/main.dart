import 'package:co_fence/firebase_options.dart';
import 'package:co_fence/screens/home_screen.dart';
import 'package:co_fence/kakao_login/kakao_login.dart';
import 'package:co_fence/viewModel/main_view_model.dart';
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
  runApp(const ProviderScope(
    child: MaterialApp(
      home: SplashScreen(),
    ),
  ));
}
