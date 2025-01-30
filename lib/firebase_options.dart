
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
    apiKey: 'AIzaSyCGj0KkWVgx7bvhFKX5wOL4u_iog3sqfbk',
    appId: '318005835742-i849cinq0a032cg6jvjalbtmtfiotl22.apps.googleusercontent.com',
    messagingSenderId: '228381901389',
    projectId: 'asepproj-2c368',
    authDomain: 'asepproj-2c368.firebaseapp.com',
    storageBucket: 'asepproj-2c368.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC0qsPXhlopPsnySveIA9nMELjqKIiFlco',
    appId: '318005835742-eqd92psu1alnjqhec3opvbsjss7l4n64.apps.googleusercontent.com',
    messagingSenderId: '228381901389',
    projectId: 'asepproj-2c368',
    storageBucket: 'asepproj-2c368.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBtu7E0BKQG2s8weRDu2-Y2Mwp0F_zWyp8',
    appId: '1:228381901389:ios:cf37b38cddc80febdb9204',
    messagingSenderId: '228381901389',
    projectId: 'asepproj-2c368',
    storageBucket: 'asepproj-2c368.firebasestorage.app',
    iosBundleId: 'com.example.authenticationprac',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBtu7E0BKQG2s8weRDu2-Y2Mwp0F_zWyp8',
    appId: '1:228381901389:ios:cf37b38cddc80febdb9204',
    messagingSenderId: '228381901389',
    projectId: 'asepproj-2c368',
    storageBucket: 'asepproj-2c368.firebasestorage.app',
    iosBundleId: 'com.example.authenticationprac',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBzHmrWwUS5iIeRnDBLRUX7y5F5-euYdEY',
    appId: '1:228381901389:web:d171c3a6e73ae247db9204',
    messagingSenderId: '228381901389',
    projectId: 'asepproj-2c368',
    authDomain: 'asepproj-2c368.firebaseapp.com',
    storageBucket: 'asepproj-2c368.firebasestorage.app',
  );
}
