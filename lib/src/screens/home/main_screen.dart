import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'account_screen.dart';
import 'history_screen.dart';
import 'package:laundryku/src/utils/colors.dart' as custom_colors;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const HistoryScreen(),
    const AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: const TextStyle(fontFamily: "Poppins"),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 24,
        backgroundColor: Colors.white,
        // selectedIconTheme:
        //     const IconThemeData(color: custom_colors.Colors.primary),
        selectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.w600, fontFamily: "Poppins"),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: custom_colors.Colors.primary,
        onTap: _onItemTapped,
      ),
    );
  }
}
