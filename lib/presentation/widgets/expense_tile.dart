import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ExpenseTile extends StatefulWidget {
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
  _ExpenseTileState createState() => _ExpenseTileState();
}

class _ExpenseTileState extends State<ExpenseTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: double.infinity,
        height: _isExpanded ? height / 5 : height / 8,
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.name,
                    style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const Spacer(),
                  Text(
                    widget.amount.toString(),
                    style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (_isExpanded)
                Expanded(
                  child: AnimatedOpacity(
                    opacity: _isExpanded ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      widget.description,
                      style: GoogleFonts.lato(fontSize: 14, color: Colors.black54),
                    ),
                  ),
                ),
              const Spacer(),
              Row(
                children: [
                  Text(widget.category),
                  const Spacer(),
                  Text(
                    DateFormat('yyyy-MM-dd – kk:mm').format(widget.date.toLocal()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
