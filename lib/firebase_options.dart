// Configuración de Firebase para el proyecto viveroa-17da7
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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions no está configurado para esta plataforma.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDKz0IxEZJRBXvWbVBVvYFuUpFea4OjL0k',
    appId: '1:820760089750:web:5b93e64f8e142d720a5eb7',
    messagingSenderId: '820760089750',
    projectId: 'viveroa-17da7',
    authDomain: 'viveroa-17da7.firebaseapp.com',
    databaseURL: 'https://viveroa-17da7-default-rtdb.firebaseio.com',
    storageBucket: 'viveroa-17da7.firebasestorage.app',
    measurementId: 'G-M3RK441L20',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDsWMsHMUJ0DpYRPJ4VzFnWbV6VbnQpcWw',
    appId: '1:820760089750:android:eda34b9400fc83f40a5eb7',
    messagingSenderId: '820760089750',
    projectId: 'viveroa-17da7',
    databaseURL: 'https://viveroa-17da7-default-rtdb.firebaseio.com',
    storageBucket: 'viveroa-17da7.firebasestorage.app',
  );
}
