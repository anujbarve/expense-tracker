import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart'; // Import this for date formatting

import '../../data/models/expense_model.dart';

class ExpenseProvider with ChangeNotifier {
  final Box<Expense> _expenseBox = Hive.box<Expense>('expenses');

  List<Expense> get expenses {
    return _expenseBox.values.toList();
  }

  // Get expenses sorted by amount
  List<Expense> get sortedByAmount {
    final sortedList = _expenseBox.values.toList();
    sortedList.sort((a, b) => a.amount.compareTo(b.amount));
    return sortedList;
  }

  // Get expenses for the current week
  List<Expense> get weeklyExpenses {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(Duration(days: 6));

    return _expenseBox.values.where((expense) {
      final expenseDate = expense.date.toLocal();
      return expenseDate.isAfter(startOfWeek) && expenseDate.isBefore(endOfWeek);
    }).toList();
  }

  // Get expenses for the current month
  List<Expense> get monthlyExpenses {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0);

    return _expenseBox.values.where((expense) {
      final expenseDate = expense.date.toLocal();
      return expenseDate.isAfter(startOfMonth) && expenseDate.isBefore(endOfMonth);
    }).toList();
  }

  // Search expenses by name
  List<Expense> searchByName(String name) {
    return _expenseBox.values.where((expense) {
      return expense.name.toLowerCase().contains(name.toLowerCase());
    }).toList();
  }

  void addExpense(Expense expense) {
    _expenseBox.put(expense.id, expense);
    notifyListeners();
  }

  void deleteExpense(String id) {
    _expenseBox.delete(id);
    notifyListeners();
  }

  void updateExpense(String id, Expense updatedExpense) {
    _expenseBox.put(id, updatedExpense);
    notifyListeners();
  }
}
