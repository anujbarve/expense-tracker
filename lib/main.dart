import 'package:finance/domain/provider/settings_provider.dart';
import 'package:finance/presentation/constants/theme.dart';
import 'package:finance/presentation/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'data/models/expense_model.dart';
import 'data/models/settings_model.dart';
import 'domain/provider/expense_provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseAdapter());
  Hive.registerAdapter(AppSettingsAdapter());
  await Hive.openBox<Expense>('expenses');

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ExpenseProvider>(
          create: (context) => ExpenseProvider()),
      ChangeNotifierProvider<SettingsProvider>(
          create: (context) => SettingsProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (BuildContext context, SettingsProvider settingsProvider, Widget? child) {

        final isDarkMode = settingsProvider.settings?.darkMode ?? false;
        return MaterialApp(
          title: 'Personal Finance Tracker',
          debugShowCheckedModeBanner: false,
          theme: isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
          home: const Homepage(),
        );
      },
    );
  }
}
