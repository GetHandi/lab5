import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/calculation.dart';

class DBProvider {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
  final databasesPath = await getDatabasesPath();
  final path = join(databasesPath, 'calculator.db');

  return await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      print('Создаю таблицу calculations...');
      await db.execute('''
        CREATE TABLE calculations(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          mass REAL,
          radius REAL,
          result REAL,
          date TEXT
        )
      ''');
    },
  );
}

  Future<int> insertCalculation(Calculation calc) async {
    final db = await database;
    return await db.insert('calculations', calc.toMap());
  }

  Future<List<Calculation>> getAllCalculations() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('calculations');
    return List.generate(maps.length, (i) => Calculation.fromMap(maps[i]));
  }
}