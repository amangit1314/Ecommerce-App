import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

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

  static FirebaseOptions web = FirebaseOptions(
    apiKey: dotenv.get('FIREBASE_WEB_API_KEY'),
    appId: dotenv.get('FIREBASE_WEB_APP_ID'),
    messagingSenderId: dotenv.get('FIREBASE_MESSAGING_SENDER_ID'),
    projectId: dotenv.get('FIREBASE_PROJECT_ID'),
    authDomain: dotenv.get('FIREBASE_AUTH_DOMAIN'),
    storageBucket: dotenv.get('FIREBASE_STORAGE_BUCKET'),
  );

  static FirebaseOptions android = FirebaseOptions(
    apiKey: dotenv.get('FIREBASE_ANDROID_API_KEY'),
    appId: dotenv.get('FIREBASE_ANDROID_APP_ID'),
    messagingSenderId: dotenv.get('FIREBASE_MESSAGING_SENDER_ID'),
    projectId: dotenv.get('FIREBASE_PROJECT_ID'),
    storageBucket: dotenv.get('FIREBASE_STORAGE_BUCKET'),
  );

  static FirebaseOptions ios = FirebaseOptions(
    apiKey: dotenv.get('FIREBASE_IOS_API_KEY'),
    appId: dotenv.get('FIREBASE_IOS_APP_ID'),
    messagingSenderId: dotenv.get('FIREBASE_MESSAGING_SENDER_ID'),
    projectId: dotenv.get('FIREBASE_PROJECT_ID'),
    storageBucket: dotenv.get('FIREBASE_STORAGE_BUCKET'),
    androidClientId: dotenv.get('FIREBASE_ANDROID_CLIENT_ID'),
    iosClientId: dotenv.get('FIREBASE_IOS_CLIENT_ID'),
    iosBundleId: dotenv.get('FIREBASE_IOS_BUNDLE_ID'),
  );

  static FirebaseOptions macos = FirebaseOptions(
    apiKey: dotenv.get('FIREBASE_MACOS_API_KEY'),
    appId: dotenv.get('FIREBASE_MACOS_APP_ID'),
    messagingSenderId: dotenv.get('FIREBASE_MESSAGING_SENDER_ID'),
    projectId: dotenv.get('FIREBASE_PROJECT_ID'),
    storageBucket: dotenv.get('FIREBASE_STORAGE_BUCKET'),
    androidClientId: dotenv.get('FIREBASE_ANDROID_CLIENT_ID'),
    iosClientId: dotenv.get('FIREBASE_IOS_CLIENT_ID'),
    iosBundleId: dotenv.get('FIREBASE_IOS_BUNDLE_ID'),
  );
}
