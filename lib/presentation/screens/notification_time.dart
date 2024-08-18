import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/provider/settings_provider.dart';

class ChangeNotificationTimeScreen extends StatefulWidget {
  @override
  _ChangeNotificationTimeScreenState createState() => _ChangeNotificationTimeScreenState();
}

class _ChangeNotificationTimeScreenState extends State<ChangeNotificationTimeScreen> {
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = Provider.of<SettingsProvider>(context, listen: false).notificationTime;
  }

  void _selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  void _saveTime() {
    if (_selectedTime != null) {
      Provider.of<SettingsProvider>(context, listen: false).setNotificationTime(_selectedTime!);
      Navigator.of(context).pop();
    }
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
          'Change Notification Time',
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Notification Time',
                style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                _selectedTime != null ? _selectedTime!.format(context) : 'Select Time',
                style: TextStyle(color: textColor, fontSize: 16),
              ),
              trailing: IconButton(
                icon: Icon(Icons.access_time, color: textColor),
                onPressed: _selectTime,
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: _saveTime,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF292B4D),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                child: const Text(
                  'Save Time',
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
