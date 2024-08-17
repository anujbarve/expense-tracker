import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ExpenseTile extends StatefulWidget {
  final String description;
  final double amount;
  final DateTime date;
  final String category;

  const ExpenseTile({
    required this.description,
    required this.amount,
    required this.date,
    required this.category,
    super.key,
  });

  @override
  _ExpenseTileState createState() => _ExpenseTileState();
}

class _ExpenseTileState extends State<ExpenseTile>{


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),

      width: double.infinity,
      height: height / 8 ,
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(widget.description,style: GoogleFonts.lato(fontWeight: FontWeight.bold,fontSize: 18),),
                Spacer(),
                Text(widget.amount.toString(),style: GoogleFonts.lato(fontWeight: FontWeight.bold,fontSize: 18),),
              ],
            )
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
              height: height / 20,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
              ),
              child: Row(
                children: [
                  Text(widget.category),
                  Spacer(),
                  Text(
                    DateFormat('yyyy-MM-dd – kk:mm').format(widget.date.toLocal()),
                  ),
                ],
              )
            ),
          )
        ],
      )
    );
  }
}
