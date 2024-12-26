import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCVPhKEWxPcD_56RfnXIdllS2BMNj-qfNk",
            authDomain: "math-solver-8zjhps.firebaseapp.com",
            projectId: "math-solver-8zjhps",
            storageBucket: "math-solver-8zjhps.appspot.com",
            messagingSenderId: "482534313333",
            appId: "1:482534313333:web:4d4bc0ef3e705eeef1d73c"));
  } else {
    await Firebase.initializeApp();
  }
}
