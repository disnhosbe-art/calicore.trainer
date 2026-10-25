
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
    apiKey: 'AIzaSyBE3kCUlmNRYYFzdqB-ydF_Q3XfgBO1wAg',
    appId: '1:380299812621:web:665b079e98213344b79a44',
    messagingSenderId: '380299812621',
    projectId: 'calicore-dc7e3',
    authDomain: 'calicore-dc7e3.firebaseapp.com',
    storageBucket: 'calicore-dc7e3.firebasestorage.app',
    measurementId: 'G-PRFT41B2V9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyASJXsaUXa_Z3kO1jcU4GdmwAGbJv4cjpY',
    appId: '1:380299812621:android:99f9e42fad3f1c9bb79a44',
    messagingSenderId: '380299812621',
    projectId: 'calicore-dc7e3',
    storageBucket: 'calicore-dc7e3.firebasestorage.app',
  );
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCkAOVSEItGRI467isWcPgRsO5P6yXTXL8',
    appId: '1:380299812621:ios:7b74784f90ca3c5db79a44',
    messagingSenderId: '380299812621',
    projectId: 'calicore-dc7e3',
    storageBucket: 'calicore-dc7e3.firebasestorage.app',
    iosClientId: '380299812621-klcjncipgq1vrpur35jea2maltv8da4j.apps.googleusercontent.com',
    iosBundleId: 'com.example.calicore',
  );
  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCkAOVSEItGRI467isWcPgRsO5P6yXTXL8',
    appId: '1:380299812621:ios:7b74784f90ca3c5db79a44',
    messagingSenderId: '380299812621',
    projectId: 'calicore-dc7e3',
    storageBucket: 'calicore-dc7e3.firebasestorage.app',
    iosClientId: '380299812621-klcjncipgq1vrpur35jea2maltv8da4j.apps.googleusercontent.com',
    iosBundleId: 'com.example.calicore',
  );
}
