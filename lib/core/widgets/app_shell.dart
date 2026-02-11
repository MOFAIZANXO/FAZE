import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../contracts/widget_contracts.dart';

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
      body: child,
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade800,
            width: 0.5,
          ),
        ),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey.shade900,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey.shade600,
        currentIndex: currentIndex,
        onTap: (index) => _onTap(context, index),
        items: AppTabs.all.map((tab) {
          return BottomNavigationBarItem(
            icon: Icon(tab.icon),
            activeIcon: Icon(tab.activeIcon),
            label: tab.label,
          );
        }).toList(),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    final route = AppTabs.all[index].route;
    context.go(route);
  }
}