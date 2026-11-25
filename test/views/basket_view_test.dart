import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/database/cinema_db.dart';
import 'package:southsea_cinema/models/booking_record.dart';
import 'package:southsea_cinema/models/cart_item.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/cart_repository.dart';
import 'package:southsea_cinema/views/basket_view.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setUp(() async {
    CartRepository.instance.clearCart();
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

  testWidgets(
      'Checkout saves the booking, clears the basket and opens the bookings', (
    WidgetTester tester,
  ) async {
    CartRepository.instance.addItem(
      const CartItem(
        movie: Movie(
          id: 'dune',
          title: 'Dune Part 2',
          description: '',
          runTime: '',
          imagePath: '',
          ageRating: '',
          price: 12.50,
          screeningTime: '',
        ),
        quantity: 2,
      ),
    );
    await tester.pumpWidget(MaterialApp(home: const BasketView()));
    await tester.runAsync(() async {
      await tester.tap(find.text('Checkout'));
      await tester.pumpAndSettle();
    });
    await tester.pumpAndSettle();

    final List<BookingRecord>? bookings = await tester.runAsync(() async {
      return await CinemaDatabase.instance.getAllBookings();
    });

    expect(bookings, isNotNull);
    if (bookings != null) {
      expect(bookings.length, 1);
      expect(bookings[0].bookingNumber, 1001);
      expect(bookings[0].summary, '2 x Dune Part 2');
      expect(bookings[0].total, 26.00);
    }
    expect(CartRepository.instance.getItems(), isEmpty);
    expect(find.text('Booking #1001'), findsOneWidget);
  });

  testWidgets('Checkout keeps the basket when saving fails',
      (WidgetTester tester) async {
    CartRepository.instance.addItem(
      const CartItem(
        movie: Movie(
          id: 'dune',
          title: 'Dune Part 2',
          description: '',
          runTime: '',
          imagePath: '',
          ageRating: '',
          price: 12.50,
          screeningTime: '',
        ),
        quantity: 2,
      ),
    );

    await tester.pumpWidget(const MaterialApp(home: BasketView()));
    await tester.pumpAndSettle();

    await tester.runAsync(() async {
      final Database database = await CinemaDatabase.instance.database;
      await database.execute('DROP TABLE orders');
    });

    await tester.runAsync(() async {
      await tester.tap(find.text('Checkout'));
      await tester.pumpAndSettle();
    });
    await tester.pumpAndSettle();

    expect(CartRepository.instance.getItems().length, 1);
    expect(find.textContaining('Could not save your booking'), findsOneWidget);
  });
}
