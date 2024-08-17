import 'package:finance/presentation/screens/edit_expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../data/models/expense_model.dart';
import '../../domain/provider/expense_provider.dart';
import '../widgets/expense_tile.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseListScreen extends StatefulWidget {
  @override
  _ExpenseListScreenState createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  String _sortOption = 'Amount'; // Default sort option

  @override
  Widget build(BuildContext context) {



    return Consumer<ExpenseProvider>(
      builder: (BuildContext context, ExpenseProvider provider, Widget? child) {

        List<Expense> expenses = provider.expenses;

        // Apply sorting
        switch (_sortOption) {
          case 'Amount':
            expenses = provider.sortedByAmount;
            break;
          case 'Week':
            expenses = provider.weeklyExpenses;
            break;
          case 'Month':
            expenses = provider.monthlyExpenses;
            break;
          default:
            expenses = provider.expenses;
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
                        items: const [
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
                    return Slidable(
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (c){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditExpenseScreen(expenseId: expense.id)));
                            },
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                            icon: Iconsax.edit,
                            label: 'Edit',
                          ),
                        ],
                      ),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (c){
                              provider.deleteExpense(expense.id);
                            },
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                            icon: Iconsax.trash,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child:  ExpenseTile(
                        name: expense.name,
                        description: expense.description,
                        amount: expense.amount,
                        date: expense.date,
                        category: expense.category,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
