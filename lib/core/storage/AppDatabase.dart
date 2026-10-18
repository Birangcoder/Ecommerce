import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._init();
  static Database? _database;

  AppDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1, // bump this every time you change schema
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cart (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        productId INTEGER NOT NULL,
        title TEXT NOT NULL,
        price REAL NOT NULL,
        quantity INTEGER NOT NULL,
        total REAL NOT NULL,
        thumbnail TEXT
      )
    ''');

    await db.execute('''
    CREATE TABLE orders (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      productId INTEGER NOT NULL,
      title TEXT NOT NULL,
      thumbnail TEXT NOT NULL,
      price REAL NOT NULL,
      quantity INTEGER NOT NULL DEFAULT 1,
      paymentMethod TEXT NOT NULL,
      orderedAt TEXT NOT NULL
    )
  ''');

    await db.execute('''
      CREATE TABLE wishlist (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        productId INTEGER NOT NULL,
        title TEXT NOT NULL,
        price REAL NOT NULL,
        rating REAL,
        thumbnail TEXT
      )
    ''');
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    // Example: version 1 -> 2 added a new column
    if (oldVersion < 2) {
      await db.execute('drop TABLE recent_search');
      await db.execute('drop TABLE recent_view');
    }
    // version 2 -> 3 added a whole new table
    if (oldVersion < 3) {
      await db.execute('ALTER TABLE orders ADD COLUMN thumbnail TEXT');
    }
    // keep stacking "if (oldVersion < X)" blocks for each future change
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}