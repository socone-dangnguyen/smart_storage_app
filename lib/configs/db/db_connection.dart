import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DatabaseConnection {
  static final DatabaseConnection _instance = DatabaseConnection._internal();
  factory DatabaseConnection() => _instance;

  static Database? _database;

  DatabaseConnection._internal();

  // Lấy database
  Future<Database> get database async {
    if (_database != null) return _database!;

    // Nếu database chưa được khởi tạo, tạo mới
    _database = await _initDatabase();
    return _database!;
  }

  // Khởi tạo database
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Tạo bảng trong cơ sở dữ liệu
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        hash_tag TEXT NOT NULL,
        url TEXT NOT NULL,
        summarize TEXT NOT NULL,
        sence TEXT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP
      );

      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        account TEXT NOT NULL,
        password TEXT NOT NULL,
        login_status BOOLEAN,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP
      );

      CREATE TABLE user_notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        note_id INTEGER NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users(id),
        FOREIGN KEY (note_id) REFERENCES notes(id)
      );

      CREATE TABLE folders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP
      );

      CREATE TABLE folder_notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        folder_id INTEGER NOT NULL,
        note_id INTEGER NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP,
        FOREIGN KEY (folder_id) REFERENCES folders(id),
        FOREIGN KEY (note_id) REFERENCES notes(id)
      );
    ''');
  }
}
