import 'package:finance/data/models/expense_model.dart';
import 'package:finance/domain/provider/expense_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();  // Initialize Flutter services

  late Directory tempDir;
  late Box<Expense> expenseBox;
  late ExpenseProvider expenseProvider;

  setUpAll(() async {
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(path.join(tempDir.path, 'hive_test'));

    Hive.registerAdapter(ExpenseAdapter());
    expenseBox = await Hive.openBox<Expense>('expenses');
    expenseProvider = ExpenseProvider();
  });

  tearDownAll(() async {
    await expenseBox.clear();  // Clear the box after tests
    await expenseBox.close();  // Close the box
    if (tempDir.existsSync()) {
      await tempDir.delete(recursive: true);
    }
    await Hive.close();
  });

  test('Should initialize the provider with an empty expense box', () async {
    expect(expenseProvider.expenses, isEmpty);
  });

  test('Should add an expense to the provider', () async {
    final expense = Expense(id: '1', name: "Name", description: 'Test', amount: 100, date: DateTime.now(), category: '');

    await expenseProvider.addExpense(expense);

    expect(expenseBox.length, 1);
    expect(expenseBox.get('1')?.description, 'Test');
    expect(expenseProvider.expenses.length, 1);
    expect(expenseProvider.expenses.first.description, 'Test');
  });

  test('Should handle sorting by amount', () async {
    final expense1 = Expense(id: '1', name: "Name1", description: 'Test1', amount: 100, date: DateTime.now(), category: '');
    final expense2 = Expense(id: '2', name: "Name2", description: 'Test2', amount: 200, date: DateTime.now(), category: '');

    await expenseProvider.addExpense(expense1);
    await expenseProvider.addExpense(expense2);

    final sortedExpenses = expenseProvider.sortedByAmount;

    print('Sorted Expenses: $sortedExpenses');  // Debug print
    expect(sortedExpenses.first.amount, 100);
    expect(sortedExpenses.last.amount, 200);
  });

  test('Should handle sorting by week', () async {
    final now = DateTime.now();
    final expense1 = Expense(id: '1', name: "Name1", description: 'Test1', amount: 100, date: now.subtract(Duration(days: now.weekday - 1)), category: '');  // Date in current week
    final expense2 = Expense(id: '2', name: "Name2", description: 'Test2', amount: 200, date: now.subtract(Duration(days: now.weekday + 6)), category: '');  // Date outside current week

    await expenseProvider.addExpense(expense1);
    await expenseProvider.addExpense(expense2);

    final weeklyExpenses = expenseProvider.weeklyExpenses;

    print('Weekly Expenses: $weeklyExpenses');  // Debug print
    expect(weeklyExpenses.length, 1);  // Only the expense within the current week should be present
    expect(weeklyExpenses.first.id, '1');  // The expense within the current week should be the one with ID '1'
  });

  test('Should handle sorting by month', () async {
    final now = DateTime.now();
    final expense1 = Expense(id: '1', name: "Name1", description: 'Test1', amount: 100, date: now.subtract(Duration(days: 5)), category: '');
    final expense2 = Expense(id: '2', name: "Name2", description: 'Test2', amount: 200, date: now.subtract(Duration(days: 35)), category: '');

    await expenseProvider.addExpense(expense1);
    await expenseProvider.addExpense(expense2);

    // Test sorting by month
    final monthlyExpenses = expenseProvider.monthlyExpenses;

    expect(monthlyExpenses.length, 1);  // Only the expense within the current month should be present
    expect(monthlyExpenses.first.id, '1');  // The expense within the current month should be the one with ID '1'
  });
}
