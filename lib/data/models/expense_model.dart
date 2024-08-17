import 'package:hive/hive.dart';

part 'expense_model.g.dart';

@HiveType(typeId: 0)
class Expense {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;


  @HiveField(2)
  final String description;

  @HiveField(3)
  final double amount;

  @HiveField(4)
  final DateTime date;

  @HiveField(5)
  final String category;

  Expense({
    required this.id,
    required this.name,
    required this.description,
    required this.amount,
    required this.date,
    required this.category,
  });
}