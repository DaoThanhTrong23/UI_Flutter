import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('huit_connect.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getApplicationDocumentsDirectory();
    final path = join(dbPath.path, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE profiles (
        mssv TEXT PRIMARY KEY,
        json_data TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE requests_cache (
        mssv TEXT PRIMARY KEY,
        json_data TEXT NOT NULL
      )
    ''');
  }

  // LƯU PROFILE
  Future<void> saveProfile(String mssv, Map<String, dynamic> data) async {
    final db = await instance.database;
    await db.insert(
      'profiles',
      {
        'mssv': mssv,
        'json_data': jsonEncode(data),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // LẤY PROFILE OFFLINE
  Future<Map<String, dynamic>?> getProfile(String mssv) async {
    final db = await instance.database;
    final result = await db.query(
      'profiles',
      where: 'mssv = ?',
      whereArgs: [mssv],
    );

    if (result.isNotEmpty) {
      final String jsonData = result.first['json_data'] as String;
      return jsonDecode(jsonData) as Map<String, dynamic>;
    } else {
      return null;
    }
  }

  // LƯU REQUESTS
  Future<void> saveRequests(String mssv, List<dynamic> requestsData, Map<String, dynamic> stats) async {
    final db = await instance.database;
    final payload = {
      'requests': requestsData,
      'stats': stats,
    };
    await db.insert(
      'requests_cache',
      {
        'mssv': mssv,
        'json_data': jsonEncode(payload),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // LẤY REQUESTS OFFLINE
  Future<Map<String, dynamic>?> getRequests(String mssv) async {
    final db = await instance.database;
    final result = await db.query(
      'requests_cache',
      where: 'mssv = ?',
      whereArgs: [mssv],
    );

    if (result.isNotEmpty) {
      final String jsonData = result.first['json_data'] as String;
      return jsonDecode(jsonData) as Map<String, dynamic>;
    } else {
      return null;
    }
  }
}
