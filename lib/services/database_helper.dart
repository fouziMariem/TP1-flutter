import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      // Ensure migration has run even if database was cached
      await _ensureQuantityColumn(_database!);
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<void> _ensureQuantityColumn(Database db) async {
    try {
      List<Map> columns = await db.rawQuery("PRAGMA table_info(book)");
      bool hasQuantity = columns.any((col) => col['name'] == 'quantity');
      
      if (!hasQuantity) {
        await db.execute(
          "ALTER TABLE book ADD COLUMN quantity INTEGER DEFAULT 1",
        );
        await db.execute(
          "UPDATE book SET quantity = 1 WHERE quantity IS NULL",
        );
      }
    } catch (e) {
      // Table might not exist yet, ignore
    }
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'FDTP.db');

    Database db = await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE IF NOT EXISTS book("
          "id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "name TEXT, "
          "price INTEGER, "
          "image TEXT, "
          "user_email TEXT, "
          "quantity INTEGER DEFAULT 1)",
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await _ensureQuantityColumn(db);
        }
      },
    );

    // Ensure quantity column exists (fallback for databases that might not have triggered upgrade)
    await _ensureQuantityColumn(db);

    return db;
  }

  // Method to reset database cache (useful for development/testing)
  Future<void> resetDatabaseCache() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
