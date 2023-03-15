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
    apiKey: 'AIzaSyDa7ElD1ItUTAAaCZUoIAKQjjIKdbAlacY',
    appId: '1:832415059129:web:ddf57acbe1fa7521e09f68',
    messagingSenderId: '832415059129',
    projectId: 'omni-notes-34205',
    authDomain: 'omni-notes-34205.firebaseapp.com',
    databaseURL: 'https://omni-notes-34205-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'omni-notes-34205.appspot.com',
    measurementId: 'G-YZLQG9FQ41',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBLp5W2TgKDlgdosQQKSkliF_b8mTzAr9g',
    appId: '1:832415059129:android:4410d70a9585f8a1e09f68',
    messagingSenderId: '832415059129',
    projectId: 'omni-notes-34205',
    databaseURL: 'https://omni-notes-34205-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'omni-notes-34205.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBnpA3TExDQ4aVgXzQEEzlaAPuO_-pp0IQ',
    appId: '1:832415059129:ios:e4dd1e326c1bda99e09f68',
    messagingSenderId: '832415059129',
    projectId: 'omni-notes-34205',
    databaseURL: 'https://omni-notes-34205-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'omni-notes-34205.appspot.com',
    iosClientId: '832415059129-hg4r0ai4mtpa8daq16qsjon333n10l9a.apps.googleusercontent.com',
    iosBundleId: 'com.example.omniNotes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBnpA3TExDQ4aVgXzQEEzlaAPuO_-pp0IQ',
    appId: '1:832415059129:ios:e4dd1e326c1bda99e09f68',
    messagingSenderId: '832415059129',
    projectId: 'omni-notes-34205',
    databaseURL: 'https://omni-notes-34205-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'omni-notes-34205.appspot.com',
    iosClientId: '832415059129-hg4r0ai4mtpa8daq16qsjon333n10l9a.apps.googleusercontent.com',
    iosBundleId: 'com.example.omniNotes',
  );
}