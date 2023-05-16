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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAwvEc17n2HFCE5Q--96QumSkbgLPRgckw',
    appId: '1:548837383668:web:0c33e7e7635c7c2e0feda1',
    messagingSenderId: '548837383668',
    projectId: 'movieassignment-1ca98',
    authDomain: 'movieassignment-1ca98.firebaseapp.com',
    storageBucket: 'movieassignment-1ca98.appspot.com',
    measurementId: 'G-M1MESLFYXJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyArSKDw-0kO4YerePjzuvyPDkOhOClrgWI',
    appId: '1:548837383668:android:061de2ed35b263eb0feda1',
    messagingSenderId: '548837383668',
    projectId: 'movieassignment-1ca98',
    storageBucket: 'movieassignment-1ca98.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAUH8qj5fIa68srt1V4Is0HVCj7SRW_ysA',
    appId: '1:548837383668:ios:132ed0313ab5ca090feda1',
    messagingSenderId: '548837383668',
    projectId: 'movieassignment-1ca98',
    storageBucket: 'movieassignment-1ca98.appspot.com',
    iosClientId: '548837383668-1f7hf288mhoceq5g443456pd9mv2s71r.apps.googleusercontent.com',
    iosBundleId: 'com.example.myApp',
  );
}