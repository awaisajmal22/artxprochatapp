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
    apiKey: 'AIzaSyC0XCAhPQAkHd7tAzsF-psbYx0_O0wxWIc',
    appId: '1:530497869334:web:e9e06fa366e86288a70737',
    messagingSenderId: '530497869334',
    projectId: 'artxporchat',
    authDomain: 'artxporchat.firebaseapp.com',
    storageBucket: 'artxporchat.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBK1jlQoF46YRs-Wmn0vB9xJZqGH8MCqwA',
    appId: '1:530497869334:android:2a6d2b19f614142ca70737',
    messagingSenderId: '530497869334',
    projectId: 'artxporchat',
    storageBucket: 'artxporchat.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC69XxPQI5Jj-1jgXntcBq-NX0E3HtYED0',
    appId: '1:530497869334:ios:f5eeaa9bbec4db0ca70737',
    messagingSenderId: '530497869334',
    projectId: 'artxporchat',
    storageBucket: 'artxporchat.appspot.com',
    iosBundleId: 'com.example.artxprochatapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC69XxPQI5Jj-1jgXntcBq-NX0E3HtYED0',
    appId: '1:530497869334:ios:f5eeaa9bbec4db0ca70737',
    messagingSenderId: '530497869334',
    projectId: 'artxporchat',
    storageBucket: 'artxporchat.appspot.com',
    iosBundleId: 'com.example.artxprochatapp',
  );
}
