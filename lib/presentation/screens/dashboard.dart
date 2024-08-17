import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Spend Pattern",
                style: GoogleFonts.lato(
                    fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // First Expense Card
              _buildExpenseCard(
                height,
                icon: Icons.food_bank_rounded,
                category: "Food",
                transactions: "01",
                totalValue: "₹9,192.85",
              ),
              const SizedBox(height: 20),
              // Second Expense Card
              _buildExpenseCard(
                height,
                icon: Iconsax.wallet_2,
                category: "Wallet and Digital Payment",
                transactions: "05",
                totalValue: "₹9,159.00",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpenseCard(
      double height, {
        required IconData icon,
        required String category,
        required String transactions,
        required String totalValue,
      }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF292B4D),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 50, color: Colors.white),
              const SizedBox(width: 10),
              Container(
                width: MediaQuery.of(context).size.width-140,
                child: Text(
                  category,
                  style: GoogleFonts.lato(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "transactions",
                    style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70),
                  ),
                  Text(
                    transactions,
                    style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "total value",
                    style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70),
                  ),
                  Text(
                    totalValue,
                    style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
