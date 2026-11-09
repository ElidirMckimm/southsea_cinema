import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/user_settings.dart';

void main() {

  test('UserSettings defaults to empty value and false newsletter', () {

    const UserSettings settings = UserSettings();
    expect(settings.name, isEmpty);
    expect(settings.address, isEmpty);
    expect(settings.email, isEmpty);
    expect(settings.receiveNewsLetter, isFalse);
  });

  test('UserSettings stores configured values', () {

    const UserSettings settings = UserSettings(
      name: 'Alice Wilson',
      address: '717F Rosalind Franklin Halls',
      email: 'alicew@example.com',
      receiveNewsLetter: true,

    );
    expect(settings.name, 'Alice Wilson');
    expect(settings.address, '717F Rosalind Franklin Halls');
    expect(settings.email, 'alicew@example.com');
    expect(settings.receiveNewsLetter, isTrue);
  });

}