import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../models/expense_model.dart';

class ExpenseProvider with ChangeNotifier {
  final Box<Expense> _expenseBox = Hive.box<Expense>('expenses');

  List<Expense> get expenses {
    return _expenseBox.values.toList();
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