import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:iconsax/iconsax.dart';

import '../../data/models/expense_model.dart';

class ExpenseProvider with ChangeNotifier {
  late Box<Expense> _expenseBox;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;


  ExpenseProvider() {
    initializeBox();
  }

  Future<void> initializeBox() async {
    _expenseBox = await Hive.openBox<Expense>('expenses');
    _isInitialized = true;
    notifyListeners();
  }

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
      return expenseDate.isAfter(startOfWeek) && expenseDate.isBefore(endOfWeek.add(Duration(days: 1)));
    }).toList();
  }

  // Get expenses for the current month
  List<Expense> get monthlyExpenses {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0);

    return _expenseBox.values.where((expense) {
      final expenseDate = expense.date.toLocal();
      return expenseDate.isAfter(startOfMonth.subtract(Duration(days: 1))) && expenseDate.isBefore(endOfMonth.add(Duration(days: 1)));
    }).toList();
  }

  // Search expenses by name
  List<Expense> searchByName(String name) {
    return _expenseBox.values.where((expense) {
      return expense.name.toLowerCase().contains(name.toLowerCase());
    }).toList();
  }

  // Get expenses by category
  List<Expense> getExpensesByCategory(String category) {
    return _expenseBox.values.where((expense) {
      return expense.category.toLowerCase() == category.toLowerCase();
    }).toList();
  }

  Future<void> addExpense(Expense expense) async {
    try {
      await _expenseBox.put(expense.id, expense);
      notifyListeners();
    } catch (e) {
      // Handle errors (e.g., show a message to the user)
      print("Error adding expense: $e");
    }
  }

  Future<void> deleteExpense(String id) async {
    try {
      await _expenseBox.delete(id);
      notifyListeners();
    } catch (e) {
      // Handle errors (e.g., show a message to the user)
      print("Error deleting expense: $e");
    }
  }

  Future<void> updateExpense(String id, Expense updatedExpense) async {
    try {
      await _expenseBox.put(id, updatedExpense);
      notifyListeners();
    } catch (e) {
      // Handle errors (e.g., show a message to the user)
      print("Error updating expense: $e");
    }
  }

  // Example method to get categories with their data
  List<CategoryData> getExpenseCategoriesWithData() {
    final Map<String, CategoryData> categoryMap = {};

    for (final expense in expenses) {
      if (categoryMap.containsKey(expense.category)) {
        categoryMap[expense.category]!.transactions++;
        categoryMap[expense.category]!.totalValue += expense.amount;
      } else {
        categoryMap[expense.category] = CategoryData(
          icon: _getCategoryIcon(expense.category),
          category: expense.category,
          transactions: 1,
          totalValue: expense.amount,
        );
      }
    }

    return categoryMap.values.toList();
  }

  IconData _getCategoryIcon(String category) {
    // Map your categories to icons here
    switch (category) {
      case 'Food':
        return Icons.food_bank_rounded;
      case 'Wallet and Digital Payment':
        return Iconsax.wallet_2;
    // Add more cases for other categories
      default:
        return Icons.category; // Default icon
    }
  }
}

class CategoryData {
  final IconData icon;
  final String category;
  int transactions;
  double totalValue;

  CategoryData({
    required this.icon,
    required this.category,
    required this.transactions,
    required this.totalValue,
  });
}
