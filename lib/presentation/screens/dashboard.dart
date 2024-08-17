import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/charts.dart';

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

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: height / 12,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Stack(
              children: [
                Positioned(
                    top: 20,
                    left: 20,
                    child: Text("Your Week in Review",style: GoogleFonts.lato(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),)
                ),


              ],
            ),
          ),
        ],
      ),
    );
  }
}
