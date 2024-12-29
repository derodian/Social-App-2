import 'package:firebase_core/firebase_core.dart';

class GlobalFirebaseOptions {
  static final GlobalFirebaseOptions _instance =
      GlobalFirebaseOptions._internal();

  factory GlobalFirebaseOptions() {
    return _instance;
  }

  GlobalFirebaseOptions._internal();

  FirebaseOptions? options;

  static GlobalFirebaseOptions get instance => _instance;
}
