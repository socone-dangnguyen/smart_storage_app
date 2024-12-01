import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:smart_storage/configs/db/db_connection.dart';
import 'package:smart_storage/constants.dart';
import 'package:smart_storage/pages/login/authentication/screen_onboarding/onboarding.dart';
import 'package:smart_storage/provider/folder_provider.dart';
import 'package:smart_storage/provider/note_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String path;

  if (kIsWeb) {
    path = 'app_database.db';
    databaseFactory =
        databaseFactoryFfiWeb; // Or use any web-compatible factory
  } else {
    // For mobile (iOS/Android), you can use the usual getDatabasesPath()
    var databasesPath = await getDatabasesPath();
    path = join(databasesPath, 'app_database.db');
  }

  bool exists = await databaseExists(path);

  if (!exists) {
    // Database does not exist, create a new one
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
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NoteProvider()),
        ChangeNotifierProvider(create: (context) => FolderProvider()),
      ],
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
