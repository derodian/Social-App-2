import 'package:flutter/material.dart';

// A utility to track GlobalKeys and detect duplicates
class KeyTracker {
  static final Set<String> _keys = {};

  static void registerKey(GlobalKey key) {
    final keyString = key.toString();
    if (_keys.contains(keyString)) {
      debugPrint('⚠️ DUPLICATE KEY DETECTED: $keyString');
    } else {
      _keys.add(keyString);
      debugPrint('✅ Registered key: $keyString');
    }
  }
}
