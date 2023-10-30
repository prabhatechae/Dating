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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBuFNUgDdtHZtyYqciGe77ZOhAwTmNDaM4',
    appId: '1:992757822483:android:0d5bd47cf906f0a3533be6',
    messagingSenderId: '992757822483',
    projectId: 'datingapp-f7b21',
    storageBucket: 'datingapp-f7b21.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBQIFtCFwgjD9nqgSG-DRTf2uBnWpILshU',
    appId:
        "1:992757822483:ios:e887e135174f7e28533be6", //'1:992757822483:ios:156eb280da02b770533be6',
    messagingSenderId: '992757822483',
    projectId: 'datingapp-f7b21',
    storageBucket: 'datingapp-f7b21.appspot.com',
    androidClientId:
        '992757822483-89doedg7amjhi4pm36vrersp08lm80cs.apps.googleusercontent.com',
    iosClientId:
        '992757822483-i5sdmdr8l8p55306ad17iadbpkbjrpat.apps.googleusercontent.com',
    iosBundleId: 'com.prabhatech.mingle',
  );
}