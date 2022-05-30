import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = "eyebody.db";
  static final int _databaseVersion = 1;
  static final foodTable = "food";
  static final workoutTable = "workout";
  static final eyeBodyTable = "eyeBody";

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, _databaseName);
    return await openDatabase(path,version:_databaseVersion,
      onCreate:_onCreate,onUpgrade:_onUpgrade); 
  }

  Future _onCreate
} //DatabaseHelper
