import 'package:hive/hive.dart';

part 'settings_model.g.dart';

@HiveType(typeId: 1)
class AppSettings {
  @HiveField(0)
  final bool darkMode;

  @HiveField(1)
  final String currency;

  @HiveField(2)
  final List<String> expenseCategories;

  @HiveField(3)
  final bool budgetAlerts;

  @HiveField(4)
  final bool notifications;

  @HiveField(5)
  final String privacyPolicy;

  @HiveField(6)
  final String language;

  AppSettings({
    required this.darkMode,
    required this.currency,
    required this.expenseCategories,
    required this.budgetAlerts,
    required this.notifications,
    required this.privacyPolicy,
    required this.language,
  });

  AppSettings copyWith({
    bool? darkMode,
    String? currency,
    List<String>? expenseCategories,
    bool? budgetAlerts,
    bool? notifications,
    String? privacyPolicy,
    String? language,
  }) {
    return AppSettings(
      darkMode: darkMode ?? this.darkMode,
      currency: currency ?? this.currency,
      expenseCategories: expenseCategories ?? this.expenseCategories,
      budgetAlerts: budgetAlerts ?? this.budgetAlerts,
      notifications: notifications ?? this.notifications,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
      language: language ?? this.language,
    );
  }
}
