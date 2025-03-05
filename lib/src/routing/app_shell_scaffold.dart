import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppShellScaffold extends StatelessWidget {
  /// Creates a scaffold with persistent navigation for the app.
  const AppShellScaffold({
    super.key,
    required this.navigationShell,
  });

  /// The navigation shell and its state.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    // Get the current screen size to adapt to different layouts
    final screenSize = MediaQuery.of(context).size;
    final isLargeScreen = screenSize.width > 600;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: isLargeScreen
          ? null // Don't show bottom nav on large screens
          : _buildBottomNavBar(context),
      // For large screens, we could use a NavigationRail or Drawer instead
      drawer: isLargeScreen ? _buildNavigationDrawer(context) : null,
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return NavigationBar(
      selectedIndex: navigationShell.currentIndex,
      onDestinationSelected: (index) => _onTabSelected(index),
      destinations: const [
        // Use distinct icons for each tab
        NavigationDestination(
          icon: Icon(Icons.newspaper_outlined),
          selectedIcon: Icon(Icons.newspaper),
          label: 'News',
        ),
        NavigationDestination(
          icon: Icon(Icons.event_outlined),
          selectedIcon: Icon(Icons.event),
          label: 'Events',
        ),
      ],
    );
  }

  Widget _buildNavigationDrawer(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: navigationShell.currentIndex,
      onDestinationSelected: (index) {
        // Close the drawer before navigating
        Navigator.pop(context);
        _onTabSelected(index);
      },
      children: const [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 28, 16, 16),
          child: Text('My App'),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.newspaper_outlined),
          selectedIcon: Icon(Icons.newspaper),
          label: Text('News'),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.event_outlined),
          selectedIcon: Icon(Icons.event),
          label: Text('Events'),
        ),
      ],
    );
  }

  void _onTabSelected(int index) {
    // This enables navigating back to the initial location when tapping the same tab again
    navigationShell.goBranch(
      index,
      // Set initialLocation to true to reset to first route in the branch
      // when tapping on the same tab for a second time
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
