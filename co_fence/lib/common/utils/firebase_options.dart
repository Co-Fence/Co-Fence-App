// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCgKBCbdaHIeounjBcwQbN57r0yQBNwo7U',
    appId: '1:845082561543:web:71587ddde5ccea2fd6aea2',
    messagingSenderId: '845082561543',
    projectId: 'co-fence',
    authDomain: 'co-fence.firebaseapp.com',
    storageBucket: 'co-fence.appspot.com',
    measurementId: 'G-EH4Q0JBK7C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAcRAHjO0_PXgGnISVlPeLNt3HTSPKDP0w',
    appId: '1:845082561543:android:8975e5e7ca3a74f3d6aea2',
    messagingSenderId: '845082561543',
    projectId: 'co-fence',
    storageBucket: 'co-fence.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAkFFjUiY7Ayojo4D5ERmWjOgmpad3LB_Q',
    appId: '1:845082561543:ios:3e73277bbd7d23e4d6aea2',
    messagingSenderId: '845082561543',
    projectId: 'co-fence',
    storageBucket: 'co-fence.appspot.com',
    androidClientId:
        '845082561543-6snlo3ek2160044dgn3i4qkd6k012pnb.apps.googleusercontent.com',
    iosBundleId: 'com.example.coFence',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAkFFjUiY7Ayojo4D5ERmWjOgmpad3LB_Q',
    appId: '1:845082561543:ios:0c161ad52c14efd7d6aea2',
    messagingSenderId: '845082561543',
    projectId: 'co-fence',
    storageBucket: 'co-fence.appspot.com',
    androidClientId:
        '845082561543-6snlo3ek2160044dgn3i4qkd6k012pnb.apps.googleusercontent.com',
    iosBundleId: 'com.example.coFence.RunnerTests',
  );
}