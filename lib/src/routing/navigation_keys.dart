import 'package:flutter/material.dart';

/// Centralized management of navigation keys
class NavigationKeys {
  // Private constructor to prevent instantiation
  NavigationKeys._();

  // Root navigator key
  static final root = GlobalKey<NavigatorState>(debugLabel: 'root');

  // Feature-specific navigator keys
  static final news = GlobalKey<NavigatorState>(debugLabel: 'news');
  static final events = GlobalKey<NavigatorState>(debugLabel: 'events');
  static final photos = GlobalKey<NavigatorState>(debugLabel: 'photos');
  static final insta = GlobalKey<NavigatorState>(debugLabel: 'insta');
  static final directory = GlobalKey<NavigatorState>(debugLabel: 'directory');
  static final committee = GlobalKey<NavigatorState>(debugLabel: 'committee');
  static final members = GlobalKey<NavigatorState>(debugLabel: 'members');
  static final jobs = GlobalKey<NavigatorState>(debugLabel: 'jobs');
  static final entries = GlobalKey<NavigatorState>(debugLabel: 'entries');
  static final account = GlobalKey<NavigatorState>(debugLabel: 'account');
}
