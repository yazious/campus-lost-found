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
          'DefaultFirebaseOptions have not been configured for linux.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA3rx9RjRh-zF3flrdSHCl476QJCQZEtAM',
    appId: '1:841815708246:web:placeholder',
    messagingSenderId: '841815708246',
    projectId: 'campus-lost-and-found-2bf67',
    authDomain: 'campus-lost-and-found-2bf67.firebaseapp.com',
    storageBucket: 'campus-lost-and-found-2bf67.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA3rx9RjRh-zF3flrdSHCl476QJCQZEtAM',
    appId: '1:841815708246:android:c75b551a0ea6948aaa21f7',
    messagingSenderId: '841815708246',
    projectId: 'campus-lost-and-found-2bf67',
    storageBucket: 'campus-lost-and-found-2bf67.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA3rx9RjRh-zF3flrdSHCl476QJCQZEtAM',
    appId: '1:841815708246:ios:placeholder',
    messagingSenderId: '841815708246',
    projectId: 'campus-lost-and-found-2bf67',
    storageBucket: 'campus-lost-and-found-2bf67.firebasestorage.app',
    iosBundleId: 'com.mycompany.campuslostfound',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA3rx9RjRh-zF3flrdSHCl476QJCQZEtAM',
    appId: '1:841815708246:ios:placeholder',
    messagingSenderId: '841815708246',
    projectId: 'campus-lost-and-found-2bf67',
    storageBucket: 'campus-lost-and-found-2bf67.firebasestorage.app',
    iosBundleId: 'com.mycompany.campuslostfound',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA3rx9RjRh-zF3flrdSHCl476QJCQZEtAM',
    appId: '1:841815708246:web:placeholder',
    messagingSenderId: '841815708246',
    projectId: 'campus-lost-and-found-2bf67',
    authDomain: 'campus-lost-and-found-2bf67.firebaseapp.com',
    storageBucket: 'campus-lost-and-found-2bf67.firebasestorage.app',
  );
}
