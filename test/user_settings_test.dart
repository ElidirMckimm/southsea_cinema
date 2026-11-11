import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/user_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:southsea_cinema/views/settings_view.dart';

void main() {
  //so it doesnt change any real profiles
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });
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

  testWidgets('SettingsScreen pre-fills saved settings on open',
      (WidgetTester tester) async {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.withData(<String, Object>{
      prefName: 'Alice Wilson',
      prefEmail: 'awilson@example.com',
      prefAddress: 'rosalind frankline, PO2 0EJ',
      prefNewsletter: true,
    });

    await tester.pumpWidget(const MaterialApp(home: SettingsView()));
    await tester.pumpAndSettle();

    expect(find.text('Alice Wilson'), findsOneWidget);
    expect(find.text('awilson@example.com'), findsOneWidget);
    expect(find.text('rosalind frankline, PO2 0EJ'), findsOneWidget);
    final Switch switchWidget = tester.widget<Switch>(find.byType(Switch));
    expect(switchWidget.value, isTrue);
  });

  testWidgets('Save Persist test', (WidgetTester tester) async {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();

    await tester.pumpWidget(const MaterialApp(home: SettingsView()));
    await tester.pumpAndSettle();

    final fields = find.byType(TextField);

    await tester.enterText(fields.at(0), 'Geralt Rivia');
    await tester.enterText(fields.at(1), 'Heidel, HO24 7JR');
    await tester.enterText(fields.at(2), 'geraltrivia@example.com');

    await tester.tap(find.byType(Switch));
    await tester.pump();

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.text('Settings saved for Geralt Rivia'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpWidget(const MaterialApp(home: SettingsView()));
    await tester.pumpAndSettle();

    expect(find.text('Geralt Rivia'), findsOneWidget);
    expect(find.text('geraltrivia@example.com'), findsOneWidget);
    expect(find.text('Heidel, HO24 7JR'), findsOneWidget);
    final Switch switchWidget = tester.widget<Switch>(find.byType(Switch));
    expect(switchWidget.value, isTrue);
  });
}