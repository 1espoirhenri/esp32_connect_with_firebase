// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
        return windows;
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
    apiKey: 'your_api_key',
    appId: 'your_app_id',
    messagingSenderId: 'your-meassageing-sender-id',
    projectId: 'your-project-id',
    authDomain: 'your-auth-domain',
    databaseURL: 'your-databaseURL',
    storageBucket: 'your_storage_bucket',
    measurementId: 'your-meanserment-id',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'your_api_key',
    appId: 'your_app_id',
    messagingSenderId: 'your-meassageing-sender-id',
    projectId: 'your-project-id',
    authDomain: 'your-auth-domain',
    databaseURL: 'your-databaseURL',
    storageBucket: 'your_storage_bucket',
    measurementId: 'your-meanserment-id',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'your_api_key',
    appId: 'your_app_id',
    messagingSenderId: 'your-meassageing-sender-id',
    projectId: 'your-project-id',
    authDomain: 'your-auth-domain',
    databaseURL: 'your-databaseURL',
    storageBucket: 'your_storage_bucket',
    measurementId: 'your-meanserment-id',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'your_api_key',
    appId: 'your_app_id',
    messagingSenderId: 'your-meassageing-sender-id',
    projectId: 'your-project-id',
    authDomain: 'your-auth-domain',
    databaseURL: 'your-databaseURL',
    storageBucket: 'your_storage_bucket',
    measurementId: 'your-meanserment-id',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'your_api_key',
    appId: 'your_app_id',
    messagingSenderId: 'your-meassageing-sender-id',
    projectId: 'your-project-id',
    authDomain: 'your-auth-domain',
    databaseURL: 'your-databaseURL',
    storageBucket: 'your_storage_bucket',
    measurementId: 'your-meanserment-id',
  );

}
