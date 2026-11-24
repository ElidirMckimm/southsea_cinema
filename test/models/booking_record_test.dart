import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/booking_record.dart';

void main() {
  const BookingRecord booking = BookingRecord(
    bookingNumber: 1004,
    summary: '3 x Dune Part 2 Tickets',
    total: 38.50,
    date: '31st september 2026',
  );

  test('New bookings omit database ids and convert to map', () {
    expect(booking.id, isNull);
    expect(booking.toMap(), <String, Object?>{
      'booking_number': 1004,
      'summary': '3 x Dune Part 2 Tickets',
      'total': 38.50,
      'date': '31st september 2026'
    });
  });

  test('A database map converts back to an order', () {
    final Map<String, Object?> row = <String, Object?>{
      'id': 7,
      'booking_number': 1010,
      'summary': '3 x Batman Tickets',
      'total': 31.00,
      'date': '27th september 2026'
    };
    final BookingRecord restored = BookingRecord.fromMap(row);
    expect(restored.id, 7);
    expect(restored.bookingNumber, 1010);
    expect(restored.summary, '3 x Batman Tickets');
    expect(restored.total, 31.00);
    expect(restored.date, '27th september 2026');
  });

  test('Whole-number SQLite totals become doubles', () {
    final Map<String, Object?> row = booking.toMap();
    row['total'] = 31;
    final BookingRecord restored = BookingRecord.fromMap(row);
    expect(restored.total, 31.0);
    expect(restored.total, isA<double>());
  });
}
