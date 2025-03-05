// // debug_shell_navigator.dart
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:social_app_2/src/routing/scaffold_with_nested_navigation.dart';

// class DebugShellNavigator extends StatefulWidget {
//   final StatefulNavigationShell navigationShell;

//   const DebugShellNavigator({
//     super.key,
//     required this.navigationShell,
//   });

//   @override
//   State<DebugShellNavigator> createState() => _DebugShellNavigatorState();
// }

// class _DebugShellNavigatorState extends State<DebugShellNavigator> {
//   @override
//   void initState() {
//     super.initState();
//     print('=== DebugShellNavigator InitState ===');
//     _printNavigationDetails();
//   }

//   @override
//   void didUpdateWidget(DebugShellNavigator oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     print('=== DebugShellNavigator DidUpdateWidget ===');
//     _printNavigationDetails();
//   }

//   void _printNavigationDetails() {
//     print('''
// === Navigation Shell Details ===
// Current Branch Index: ${widget.navigationShell.currentIndex}
// Shell Route: ${widget.navigationShell.route}
// ''');
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('=== Building DebugShellNavigator ===');
//     return ScaffoldWithNestedNavigation(
//         navigationShell: widget.navigationShell);
//   }
// }
