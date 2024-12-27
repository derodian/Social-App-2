import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

class CryptoUtilities {
  // Generate a cryptographically secure random nonce,
  // to be included in a credential request.
  static String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  // Return the sha256 hash of the [input] in hex notation.
  // crypto package is required to convert to sha256
  static String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
