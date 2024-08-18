import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../data/models/settings_model.dart';

class SettingsProvider with ChangeNotifier {
  Box<AppSettings>? _settingsBox;
  AppSettings? _currentSettings;

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    _settingsBox = await Hive.openBox<AppSettings>('settingsBox');
    _currentSettings = _settingsBox?.get('settings', defaultValue: AppSettings(
      darkMode: false,
      currency: 'USD',
      expenseCategories: [],
      budgetAlerts: true,
      notifications: true,
      privacyPolicy: 'Default Privacy Policy',
      language: 'en',
    ));
    notifyListeners();
  }

  // General Getter and Setter
  AppSettings? get settings => _currentSettings;

  Future<void> updateSettings(AppSettings newSettings) async {
    _currentSettings = newSettings;
    if (_settingsBox != null) {
      await _settingsBox!.put('settings', newSettings);
      notifyListeners();
    }
  }

  // Specific Getters
  bool get darkMode => _currentSettings?.darkMode ?? false;
  String get currency => _currentSettings?.currency ?? 'USD';
  List<String> get expenseCategories => _currentSettings?.expenseCategories ?? [];
  bool get budgetAlerts => _currentSettings?.budgetAlerts ?? true;
  bool get notifications => _currentSettings?.notifications ?? true;
  String get privacyPolicy => _currentSettings?.privacyPolicy ?? 'Default Privacy Policy';
  String get language => _currentSettings?.language ?? 'en';

  // Specific Setters
  Future<void> setDarkMode(bool value) async {
    if (_currentSettings != null) {
      final updatedSettings = _currentSettings!.copyWith(darkMode: value);
      await updateSettings(updatedSettings);
    }
  }

  Future<void> setCurrency(String value) async {
    if (_currentSettings != null) {
      final updatedSettings = _currentSettings!.copyWith(currency: value);
      await updateSettings(updatedSettings);
    }
  }

  Future<void> setExpenseCategories(List<String> categories) async {
    if (_currentSettings != null) {
      final updatedSettings = _currentSettings!.copyWith(expenseCategories: categories);
      await updateSettings(updatedSettings);
    }
  }

  Future<void> setBudgetAlerts(bool value) async {
    if (_currentSettings != null) {
      final updatedSettings = _currentSettings!.copyWith(budgetAlerts: value);
      await updateSettings(updatedSettings);
    }
  }

  Future<void> setNotifications(bool value) async {
    if (_currentSettings != null) {
      final updatedSettings = _currentSettings!.copyWith(notifications: value);
      await updateSettings(updatedSettings);
    }
  }

  Future<void> setPrivacyPolicy(String value) async {
    if (_currentSettings != null) {
      final updatedSettings = _currentSettings!.copyWith(privacyPolicy: value);
      await updateSettings(updatedSettings);
    }
  }

  Future<void> setLanguage(String value) async {
    if (_currentSettings != null) {
      final updatedSettings = _currentSettings!.copyWith(language: value);
      await updateSettings(updatedSettings);
    }
  }

  @override
  void dispose() {
    _settingsBox?.close();
    super.dispose();
  }
}
