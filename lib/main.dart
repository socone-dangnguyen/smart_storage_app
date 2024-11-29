import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:smart_storage/configs/db/db_connection.dart';
import 'package:smart_storage/constants.dart';
import 'package:smart_storage/pages/login/authentication/screen_onboarding/onboarding.dart';
import 'package:smart_storage/provider/note_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'app_database.db');
  bool exists = await databaseExists(path);
  if (!exists) {
    final DatabaseConnection databaseConnection = DatabaseConnection();
    await databaseConnection.database;
    print('Database created for the first time');
  } else {
    // Database already exists, just open it
    final DatabaseConnection databaseConnection = DatabaseConnection();
    await databaseConnection.database;
    print('Existing database opened');
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => NoteProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Constants.white,
      ),
      // home: tree_map_responsive(),
      home: OnboardingScreen(),
    );
  }
}
