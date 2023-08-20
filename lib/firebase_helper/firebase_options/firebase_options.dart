import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (Platform.isIOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        appId: '',
        apiKey: '',
        projectId: '',
        messagingSenderId: '',
        iosBundleId: '',
      );
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:839074653946:web:720db957994cdc4c918b43',
        apiKey: 'AIzaSyCNcAYS81cEdxXWEV9FX1T7XPdllaXUcSw',
        projectId: 'sasta-mart-5b83c',
        messagingSenderId: '839074653946',
      );
    }
  }}