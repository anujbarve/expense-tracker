import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/expense_provider.dart';

class ExpenseListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    final expenses = expenseProvider.expenses;

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Expenses'),
      ),
      body: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) {
          final expense = expenses[index];
          return ListTile(
            title: Text(expense.description),
            subtitle: Text('${expense.amount.toString()} - ${expense.date.toLocal()}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                expenseProvider.deleteExpense(expense.id);
              },
            ),
          );
        },
      ),
    );
  }
}