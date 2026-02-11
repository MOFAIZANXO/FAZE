import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../contracts/widget_contracts.dart';
import '../theme/app_theme.dart';
import 'app_bottom_nav.dart';

/// App Shell with Bottom Navigation
/// 
/// Wraps all main screens with persistent bottom nav bar
class AppShell extends StatelessWidget {
  final Widget child;
  final int currentIndex;

  const AppShell({
    super.key,
    required this.child,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: child,
      bottomNavigationBar: AppBottomNav(
        currentIndex: currentIndex,
        onTap: (index) => _onTap(context, index),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    // Standardize navigation logic
    final tabs = AppTabs.all;
    if (index >= 0 && index < tabs.length) {
      final route = tabs[index].route;
      context.go(route);
    }
  }
}