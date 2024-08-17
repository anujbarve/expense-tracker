import 'package:finance/presentation/screens/dashboard.dart';
import 'package:finance/presentation/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import 'add_expense_screen.dart';
import 'expense_list_screen.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    Dashboard(), // Home Screen
    ExpenseListScreen(), // Search Screen (replace with actual screen)
    SettingsScreen(),        // Settings Screen (replace with actual screen)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Icon(Iconsax.money),
        centerTitle: true,
      ),
      body: _screens[_selectedIndex],  // Display the selected screen
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddExpenseScreen())
          );
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: [
          NavigationDestination(icon: Icon(Iconsax.home), label: "Home"),
          NavigationDestination(icon: Icon(Iconsax.menu_board), label: "List"),
          NavigationDestination(icon: Icon(Iconsax.setting), label: "Settings"),
        ],
      ),
    );
  }
}
