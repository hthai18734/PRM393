import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'summary_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  final GlobalKey<HomeScreenState> _homeKey = GlobalKey<HomeScreenState>();
  final GlobalKey<SummaryScreenState> _summaryKey = GlobalKey<SummaryScreenState>();

  void _onDataChanged() {
    _homeKey.currentState?.loadBills();
    _summaryKey.currentState?.loadUnpaidBills();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Trigger refresh for the selected tab
    if (index == 0) {
      _homeKey.currentState?.loadBills();
    } else {
      _summaryKey.currentState?.loadUnpaidBills();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(
            key: _homeKey,
            onDataChanged: _onDataChanged,
          ),
          SummaryScreen(
            key: _summaryKey,
            onDataChanged: _onDataChanged,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: const Color(0xFF673AB7),
        unselectedItemColor: Colors.grey.shade400,
        backgroundColor: Colors.white,
        elevation: 8,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 26),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart_outline, size: 26),
            label: 'Summary',
          ),
        ],
      ),
    );
  }
}
