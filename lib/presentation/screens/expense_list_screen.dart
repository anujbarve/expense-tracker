import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/expense_model.dart';
import '../../domain/provider/expense_provider.dart';
import '../widgets/expense_tile.dart';

class ExpenseListScreen extends StatefulWidget {
  @override
  _ExpenseListScreenState createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  String _searchQuery = '';
  String _sortOption = 'Amount'; // Default sort option

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);

    List<Expense> expenses = expenseProvider.expenses;

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      expenses = expenseProvider.searchByName(_searchQuery);
    }

    // Apply sorting
    switch (_sortOption) {
      case 'Amount':
        expenses = expenseProvider.sortedByAmount;
        break;
      case 'Week':
        expenses = expenseProvider.weeklyExpenses;
        break;
      case 'Month':
        expenses = expenseProvider.monthlyExpenses;
        break;
      default:
        expenses = expenseProvider.expenses;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense List'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: DropdownButton<String>(
                    value: _sortOption,
                    items: [
                      DropdownMenuItem(
                        value: 'Amount',
                        child: Text('Sort by Amount'),
                      ),
                      DropdownMenuItem(
                        value: 'Week',
                        child: Text('Sort by Week'),
                      ),
                      DropdownMenuItem(
                        value: 'Month',
                        child: Text('Sort by Month'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _sortOption = value ?? 'Amount';
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (ctx, index) {
                final expense = expenses[index];
                return ExpenseTile(
                  description: expense.description,
                  amount: expense.amount,
                  date: expense.date,
                  category: expense.category,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
