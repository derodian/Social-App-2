import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_keys.g.dart';

// class RouterKeys {
//   RouterKeys() {
//     print(
//         '=== Creating new RouterKeys instance: ${identityHashCode(this)} ===');
//   }

//   // Create keys with debug labels and logging
//   final root = GlobalKey<NavigatorState>()
//     ..also((key) => print('Created root key: $key'));

//   final news = GlobalKey<NavigatorState>(debugLabel: 'news')
//     ..also((key) => print('Created news key: $key'));

//   final photos = GlobalKey<NavigatorState>(debugLabel: 'photos')
//     ..also((key) => print('Created photos key: $key'));

//   final insta = GlobalKey<NavigatorState>(debugLabel: 'insta')
//     ..also((key) => print('Created insta key: $key'));

//   final events = GlobalKey<NavigatorState>(debugLabel: 'events')
//     ..also((key) => print('Created events key: $key'));

//   final directory = GlobalKey<NavigatorState>(debugLabel: 'directory')
//     ..also((key) => print('Created directory key: $key'));

//   final committee = GlobalKey<NavigatorState>(debugLabel: 'committee')
//     ..also((key) => print('Created committee key: $key'));

//   final members = GlobalKey<NavigatorState>(debugLabel: 'members')
//     ..also((key) => print('Created members key: $key'));

//   final entries = GlobalKey<NavigatorState>(debugLabel: 'entries')
//     ..also((key) => print('Created entries key: $key'));

//   final account = GlobalKey<NavigatorState>(debugLabel: 'account')
//     ..also((key) => print('Created account key: $key'));

//   @override
//   String toString() {
//     return 'RouterKeys(hashCode: ${identityHashCode(this)})';
//   }
// }

// @Riverpod(keepAlive: true)
// class AppRouterKeys extends _$AppRouterKeys {
//   @override
//   RouterKeys build() {
//     print('=== Building RouterKeys Provider ===');
//     final keys = RouterKeys();
//     ref.onDispose(() {
//       print('=== Disposing RouterKeys Provider ===');
//     });
//     return keys;
//   }
// }

// // Extension method for logging
// extension ObjectLogging<T> on T {
//   T also(void Function(T) block) {
//     block(this);
//     return this;
//   }
// }
// router_keys.dart

@Riverpod(keepAlive: true)
RouterKeys routerKeys(Ref ref) {
  print('\n=== Creating RouterKeys Provider ===');
  final keys = RouterKeys.instance;
  print('Provider returning RouterKeys instance: ${identityHashCode(keys)}\n');
  return keys;
}

class RouterKeys {
  // Private constructor
  RouterKeys._() {
    print('''
=== Initializing RouterKeys Singleton ===
Instance Hash: ${identityHashCode(this)}
Creation Time: ${DateTime.now()}
''');
  }

  // Single instance
  static final RouterKeys instance = RouterKeys._();

  // Static keys with debug logging
  final root = GlobalKey<NavigatorState>()
    ..also((key) => print('Created ROOT key: $key [${identityHashCode(key)}]'));

  final news = GlobalKey<NavigatorState>(debugLabel: 'news')
    ..also((key) => print('Created NEWS key: $key [${identityHashCode(key)}]'));

  final photos = GlobalKey<NavigatorState>(debugLabel: 'photos')
    ..also(
        (key) => print('Created PHOTOS key: $key [${identityHashCode(key)}]'));

  final insta = GlobalKey<NavigatorState>(debugLabel: 'insta')
    ..also(
        (key) => print('Created INSTA key: $key [${identityHashCode(key)}]'));

  final events = GlobalKey<NavigatorState>(debugLabel: 'events')
    ..also(
        (key) => print('Created EVENTS key: $key [${identityHashCode(key)}]'));

  final directory = GlobalKey<NavigatorState>(debugLabel: 'directory')
    ..also((key) =>
        print('Created DIRECTORY key: $key [${identityHashCode(key)}]'));

  final committee = GlobalKey<NavigatorState>(debugLabel: 'committee')
    ..also((key) =>
        print('Created COMMITTEE key: $key [${identityHashCode(key)}]'));

  final members = GlobalKey<NavigatorState>(debugLabel: 'members')
    ..also(
        (key) => print('Created MEMBERS key: $key [${identityHashCode(key)}]'));

  final entries = GlobalKey<NavigatorState>(debugLabel: 'entries')
    ..also(
        (key) => print('Created ENTRIES key: $key [${identityHashCode(key)}]'));

  final account = GlobalKey<NavigatorState>(debugLabel: 'account')
    ..also(
        (key) => print('Created ACCOUNT key: $key [${identityHashCode(key)}]'));

  void printKeyDetails() {
    print('''
=== RouterKeys Details ===
Instance Hash: ${identityHashCode(this)}
Root Key: $root [${identityHashCode(root)}]
News Key: $news [${identityHashCode(news)}]
Events Key: $events [${identityHashCode(events)}]
Committee Key: $committee [${identityHashCode(committee)}]
''');
  }
}

// Extension method for logging
extension ObjectLogging<T> on T {
  T also(void Function(T) block) {
    block(this);
    return this;
  }
}
