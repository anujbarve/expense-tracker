import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String description;
  final double amount;
  final DateTime date;
  final String category;

  const ExpenseTile({
    required this.name,
    required this.description,
    required this.amount,
    required this.date,
    required this.category,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF292B4D),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date and Month Column
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('dd').format(date),
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    DateFormat('MMM').format(date),
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Expense Details Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Amount
                Text(
                  '₹ ${amount.toStringAsFixed(2)}',
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                // Description
                Text(
                  description,
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
