import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/database/cinema_db.dart';
import 'package:southsea_cinema/models/booking_record.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setUp(() async {
    sqfliteFfiInit();
    final Database database = await databaseFactoryFfiNoIsolate.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: CinemaDatabase.instance.createTables,
      ),
    );
    CinemaDatabase.instance.setDatabase(database);
  });

  tearDown(() async {
    await CinemaDatabase.instance.close();
  });

  BookingRecord buildBooking(int orderNumber, String summary, double total) {
    return BookingRecord(
        bookingNumber: orderNumber,
        summary: summary,
        total: total,
        date: '02/10/2026 20:00');
  }

  test('insertBooking stores a booking and returns its id', () async {
    final int id = await CinemaDatabase.instance.insertBooking(
      buildBooking(1001, '2 x Dune Part 2 Tickets', 26.00),
    );
    expect(id, greaterThan(0));

    final List<BookingRecord> bookings =
        await CinemaDatabase.instance.getAllBookings();
    expect(bookings.length, 1);
    expect(bookings[0].id, id);
    expect(bookings[0].summary, '2 x Dune Part 2 Tickets');
    expect(bookings[0].total, 26.00);
  });

  test('getNextBookingNumber increments the current maximum', () async {
    expect(await CinemaDatabase.instance.getNextBookingNumber(), 1001);

    await CinemaDatabase.instance
        .insertBooking(buildBooking(1005, 'Booking', 10.50));
    expect(await CinemaDatabase.instance.getNextBookingNumber(), 1006);
  });

  test('getAllBookings returns newest booking number first', () async {
    await CinemaDatabase.instance
        .insertBooking(buildBooking(1001, 'First', 10.50));

    await CinemaDatabase.instance
        .insertBooking(buildBooking(1003, 'Third', 21.0));

    await CinemaDatabase.instance
        .insertBooking(buildBooking(1002, 'Second', 12.50));

    final List<BookingRecord> bookings =
        await CinemaDatabase.instance.getAllBookings();
    expect(bookings[0].bookingNumber, 1003);
    expect(bookings[1].bookingNumber, 1002);
    expect(bookings[2].bookingNumber, 1001);
  });
}
