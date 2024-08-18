import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/provider/settings_provider.dart';

class AddCategoryScreen extends StatefulWidget {
  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final _categoryController = TextEditingController();

  void _submitCategory() {
    final newCategory = _categoryController.text.trim();

    if (newCategory.isEmpty) {
      return;
    }

    // Adding the new category through the SettingsProvider
    Provider.of<SettingsProvider>(context, listen: false)
        .addExpenseCategory(newCategory);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<SettingsProvider>(context).darkMode;

    final backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final labelColor = isDarkMode ? Colors.grey[300] : Colors.grey[700];
    final fillColor = isDarkMode ? Colors.grey[800] : Colors.grey[200];
    final borderColor = isDarkMode ? Colors.grey[600]! : Colors.grey[400]!;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
        title: Text(
          'Add New Category',
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _categoryController,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                labelText: 'Category Name',
                labelStyle: TextStyle(color: labelColor),
                filled: true,
                fillColor: fillColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: borderColor),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: _submitCategory,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF292B4D),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                child: const Text(
                  'Add Category',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}