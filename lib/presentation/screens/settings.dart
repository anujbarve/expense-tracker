import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: 8, // Number of settings options
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two items per row
            childAspectRatio: 1, // Square items
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            return _buildSettingsCard(index);
          },
        ),
      ),
    );
  }

  Widget _buildSettingsCard(int index) {
    // Define the icons and labels based on the index
    final List<IconData> icons = [
      Iconsax.award, // explore rewards
      Iconsax.user_tag, // refer now & earn gems
      Iconsax.wallet, // credit cards
      Iconsax.coin, // coins
      Iconsax.bill, // gems
      Iconsax.moon, // support
      Iconsax.support, // support
      Iconsax.gift, // claimed rewards
    ];

    final List<String> labels = [
      'explore\nrewards',
      'refer now\n& earn gems',
      '2\ncredit cards',
      '5,05,143\ncoins',
      '5\ngems',
      'support',
      'Dark Mode',
      '14\nclaimed rewards',
    ];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF292B4D), // Card color matching the UI
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (index == 0)
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text('3 new',
                      style: GoogleFonts.lato(fontSize: 12, color: Colors.white)),
                ),
              ),
            const Spacer(),
            Icon(icons[index], color: Colors.white, size: 40),
            const SizedBox(height: 10),
            Text(
              labels[index],
              style: GoogleFonts.lato(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
