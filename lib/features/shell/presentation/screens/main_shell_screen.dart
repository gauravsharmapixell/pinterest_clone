import 'package:flutter/material.dart';

import '../../../home/presentation/screens/home_screen.dart';
import '../../../saved/presentation/screens/saved_screen.dart';
import '../../../search/presentation/screens/search_screen.dart';

class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = const [
    HomeScreen(),
    SearchScreen(),
    SavedScreen(),
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _currentIndex,
        children: _tabs,
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          height: 72,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _BottomNavItem(
                icon: _currentIndex == 0
                    ? Icons.home_filled
                    : Icons.home_outlined,
                label: 'Home',
                selected: _currentIndex == 0,
                onTap: () => _onTap(0),
              ),
              _BottomNavItem(
                icon: Icons.search,
                label: 'Search',
                selected: _currentIndex == 1,
                onTap: () => _onTap(1),
              ),
              _BottomNavItem(
                icon: _currentIndex == 2
                    ? Icons.person
                    : Icons.person_outline,
                label: 'Saved',
                selected: _currentIndex == 2,
                onTap: () => _onTap(2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 88,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.black, size: 30),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
