import 'package:finance/screens/add_expense_screen.dart';
import 'package:finance/screens/expense_list_screen.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExpenseListScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddExpenseScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
