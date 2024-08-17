import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/expense_model.dart';
import '../../domain/provider/expense_provider.dart';

class AddExpenseScreen extends StatefulWidget {
  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDateTime;
  String? _selectedCategory;

  final List<String> _categories = [
    'Food',
    'Transport',
    'Entertainment',
    'Health',
    'Other'
  ]; // Example categories

  void _submitData() {
    if (_amountController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _selectedDateTime == null ||
        _selectedCategory == null) {
      return;
    }

    final enteredName = _nameController.text;
    final enteredDescription = _descriptionController.text;
    final enteredAmount = double.parse(_amountController.text);

    final newExpense = Expense(
      id: Uuid().v4(),
      name: enteredName,
      description: enteredDescription,
      amount: enteredAmount,
      date: _selectedDateTime!,
      category: _selectedCategory!, // Include category
    );

    Provider.of<ExpenseProvider>(context, listen: false).addExpense(newExpense);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDateTime == null
                        ? 'No Date and Time Chosen!'
                        : 'Picked Date and Time: ${_selectedDateTime!.toLocal()}',
                  ),
                ),
                TextButton(
                  onPressed: _presentDatePicker,
                  child: Text(
                    'Choose Date & Time',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              isExpanded: true,
              value: _selectedCategory,
              hint: Text('Choose Category'),
              items: _categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitData,
              child: Text('Add Expense'),
            ),
          ],
        ),
      ),
    );
  }
}
