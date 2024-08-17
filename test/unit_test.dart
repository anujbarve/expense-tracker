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

  setUpAll(() async {
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(path.join(tempDir.path, 'hive_test'));

    Hive.registerAdapter(ExpenseAdapter());
    expenseBox = await Hive.openBox<Expense>('expenses');
  });

  tearDownAll(() async {
    await expenseBox.clear();  // Clear the box after tests
    await expenseBox.close();  // Close the box
    if (tempDir.existsSync()) {
      await tempDir.delete(recursive: true);
    }
    await Hive.close();
  });

  test('Should add an expense to the provider', () async {
    final expenseProvider = ExpenseProvider();
    final expense = Expense(id: '1', name: "Name",description: 'Test', amount: 100, date: DateTime.now(), category: '');

    expenseProvider.addExpense(expense);

    expect(expenseBox.length, 1);
    expect(expenseBox.get('1')?.description, 'Test');
    expect(expenseProvider.expenses.length, 1);
    expect(expenseProvider.expenses.first.description, 'Test');
  });
}
