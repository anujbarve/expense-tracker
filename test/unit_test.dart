import 'package:finance/models/expense_model.dart';
import 'package:finance/provider/expense_provider.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:finance/main.dart';

void main() {
  test('Should add an expense to the provider', () {
    final expenseProvider = ExpenseProvider();
    final expense = Expense(id: '1', description: 'Test', amount: 100, date: DateTime.now());

    expenseProvider.addExpense(expense);

    expect(expenseProvider.expenses.length, 1);
    expect(expenseProvider.expenses.first.description, 'Test');
  });
}
