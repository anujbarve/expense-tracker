import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/expense_model.dart';
import '../../domain/provider/expense_provider.dart';
import '../../domain/provider/settings_provider.dart';

class EditExpenseScreen extends StatefulWidget {
  final String expenseId;

  EditExpenseScreen({required this.expenseId});

  @override
  _EditExpenseScreenState createState() => _EditExpenseScreenState();
}

class _EditExpenseScreenState extends State<EditExpenseScreen> {
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
  ];

  @override
  void initState() {
    super.initState();

    final expense = Provider.of<ExpenseProvider>(context, listen: false)
        .expenses
        .firstWhere((expense) => expense.id == widget.expenseId);

    _nameController.text = expense.name;
    _descriptionController.text = expense.description;
    _amountController.text = expense.amount.toString();
    _selectedDateTime = expense.date;
    _selectedCategory = expense.category;
  }

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

    final updatedExpense = Expense(
      id: widget.expenseId,
      name: enteredName,
      description: enteredDescription,
      amount: enteredAmount,
      date: _selectedDateTime!,
      category: _selectedCategory!,
    );

    Provider.of<ExpenseProvider>(context, listen: false)
        .updateExpense(widget.expenseId, updatedExpense);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blueAccent,
              onPrimary: Colors.black,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(_selectedDateTime ?? DateTime.now()),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.blueAccent,
                onPrimary: Colors.black,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        },
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
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final isDarkMode = settingsProvider.darkMode;

    return Consumer<SettingsProvider>(
      builder: (BuildContext context, SettingsProvider settingsProvider, Widget? child) {
        return Scaffold(
          backgroundColor: isDarkMode ? Colors.black : Colors.white,
          appBar: AppBar(
            backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
            title: Text(
              'Edit Expense',
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            ),
            iconTheme:
                IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(
                        color:
                            isDarkMode ? Colors.grey[400] : Colors.grey[700]),
                    filled: true,
                    fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                          color: isDarkMode
                              ? Colors.grey[600]!
                              : Colors.grey[400]!),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _descriptionController,
                  style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(
                        color:
                            isDarkMode ? Colors.grey[400] : Colors.grey[700]),
                    filled: true,
                    fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                          color: isDarkMode
                              ? Colors.grey[600]!
                              : Colors.grey[400]!),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _amountController,
                  style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    labelStyle: TextStyle(
                        color:
                            isDarkMode ? Colors.grey[400] : Colors.grey[700]),
                    filled: true,
                    fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                          color: isDarkMode
                              ? Colors.grey[600]!
                              : Colors.grey[400]!),
                    ),
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDateTime == null
                            ? 'No Date and Time Chosen!'
                            : 'Picked Date and Time: ${_selectedDateTime!.toLocal()}',
                        style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black),
                      ),
                    ),
                    TextButton(
                      onPressed: _presentDatePicker,
                      child: const Text(
                        'Choose Date & Time',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  dropdownColor:
                      isDarkMode ? Colors.grey[800] : Colors.grey[300],
                  value: _selectedCategory,
                  hint: Text('Choose Category',
                      style: TextStyle(
                          color: isDarkMode
                              ? Colors.grey[400]
                              : Colors.grey[700])),
                  items: settingsProvider.expenseCategories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category,
                          style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black)),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                          color: isDarkMode
                              ? Colors.grey[600]!
                              : Colors.grey[400]!),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: const Text(
                      'Update Expense',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
