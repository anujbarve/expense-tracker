import 'package:finance/domain/provider/settings_provider.dart';
import 'package:finance/presentation/screens/add_expense_category.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings',
            style: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [


            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddCategoryScreen()));
              },
              child: _buildSettingsOption(
                context,
                Icons.category,
                'Expense Categories',
                'Customize or add expense categories',
                    () {

                },
              ),
            ),
            _buildSettingsOption(
              context,
              Icons.notifications,
              'Budget Alerts',
              'Set alerts when nearing your budget limits',
              () {},
            ),
            _buildSettingsOption(
              context,
              Icons.dark_mode,
              'Dark Mode',
              'Toggle between light and dark modes',
              () {
                final settingsProvider =
                    Provider.of<SettingsProvider>(context, listen: false);
                final currentDarkMode = settingsProvider.darkMode;
                settingsProvider.setDarkMode(!currentDarkMode);
              },
              isSwitch: true,
            ),
            _buildSettingsOption(
              context,
              Icons.privacy_tip,
              'Privacy Policy',
              'Read our privacy policy',
              () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsOption(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback callback, {
    bool isSwitch = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFF292B4D),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white, size: 28),
            Spacer(),
            Text(
              title,
              style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              subtitle,
              style: GoogleFonts.lato(fontSize: 12, color: Colors.white70),
            ),
            if (isSwitch)
              Switch(
                value: Provider.of<SettingsProvider>(context).darkMode,
                onChanged: (value) {
                  final settingsProvider =
                      Provider.of<SettingsProvider>(context, listen: false);
                  settingsProvider.setDarkMode(value);
                },
              ),
          ],
        ),
      ),
    );
  }
}
