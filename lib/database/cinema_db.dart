import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:southsea_cinema/models/booking.dart';

class CinemaDatabase {
  CinemaDatabase._internal();

  static final CinemaDatabase instance = CinemaDatabase._internal();

  static Database? _database;

  void setDatabase(Database db) {
    _database = db;
  }

  Future<Database> get database async {
    final Database? cachedDatabase = _database;
    if (cachedDatabase != null) {
      return cachedDatabase;
    }
    final Database db = await _initDB('movie_data.db');
    _database = db;
    return db;
  }

  Future<Database> _initDB(String fileName) async {
    final String folder = await getDatabasesPath();
    final String filePath = join(folder, fileName);
    final Database db = await openDatabase(
      filePath,
      version: 1,
      onCreate: _createDB,
    );
    return db;
  }

  Future<void> createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        booking_number INTEGER NOT NULL,
        summary TEXT NOT NULL,
        total REAL NOT NULL,
        date TEXT NOT NULL)
        ''');
  }

  Future<void> _createDB(Database db, int version) async {
    await createTables(db, version);

    await db.insert('orders', <String, Object?>{
      'booking_number': 1003,
      'summary': '2 x Dune Part 2 Tickets',
      'total': 26.0,
      'date': '30th September 2026',
    });

    await db.insert('orders', <String, Object?>{
      'booking_number': 1002,
      'summary': '1 x Dune Part 2 Tickets',
      'total': 13.0,
      'date': '30th September 2026',
    });

    await db.insert('orders', <String, Object?>{
      'booking_number': 1001,
      'summary': '2 x The Batman Tickets',
      'total': 21.0,
      'date': '2nd October 2026',
    });
  }

  Future<int> insertBooking(BookingRecord order) async {
    final Database db = await database;
    final int id = await db.insert('orders', order.toMap());
    return id;
  }

  Future<List<BookingRecord>> getAllBookings() async {
    final Database db = await database;
    final List<Map<String, Object?>> records =
        await db.query('orders', orderBy: 'booking_number DESC');
    final List<BookingRecord> bookings = [];
    for (final Map<String, Object?> row in records) {
      bookings.add(BookingRecord.fromMap(row));
    }
    return bookings;
  }

  Future<int> getNextBookingNumber() async {
    final Database db = await database;
    final List<Map<String, Object?>> records =
        await db.rawQuery('SELECT MAX(booking_number) as max_num FROM orders');

    if (records.isEmpty) {
      return 1001;
    }
    final Object? maxValue = records[0]['max_value'];
    if (maxValue == null) {
      return 1001;
    }

    final int currentMax = maxValue as int;
    return currentMax + 1;
  }

  Future<void> close() async {
    final Database? cachedDatabase = _database;
    if (cachedDatabase != null) {
      await cachedDatabase.close();
      _database = null;
    }
  }
}
