import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';

void main() {
  group('Movie model tests', () {
    test('Create Movie instance with given properties', () {
      const movie = Movie(
        id: 'dune',
        title: 'Dune: Part Two (2024)',
        description:
            'The war for Arrakis begins. Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.',
        runTime: '2h 46m',
        ageRating: 'PG-13',
        imagePath: 'assets/images/dune2Poster1.jfif',
        screeningTime: 'Wednesday, 30th September 2026, 18:00 - 20:46',
        price: 12.50,
      );

      expect(movie.id, 'dune');
      expect(movie.title, 'Dune: Part Two (2024)');
      expect(movie.description,
          'The war for Arrakis begins. Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.');
      expect(movie.runTime, '2h 46m');
      expect(movie.ageRating, 'PG-13');
      expect(movie.imagePath, 'assets/images/dune2Poster1.jfif');
      expect(
          movie.screeningTime, 'Wednesday, 30th September 2026, 18:00 - 20:46');
    });

    test('Movie instance returns price format', () {
      const movie = Movie(
        id: 'dune',
        title: 'Dune: Part Two (2024)',
        description:
            'The war for Arrakis begins. Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.',
        runTime: '2h 46m',
        ageRating: 'PG-13',
        imagePath: 'assets/images/dune2Poster1.jfif',
        screeningTime: 'Wednesday, 30th September 2026, 18:00 - 20:46',
        price: 12.50,
      );

      expect(movie.formattedPrice, '£12.50');

      const movie2 = Movie(
        id: 'dune',
        title: 'Dune: Part Two (2024)',
        description:
            'The war for Arrakis begins. Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.',
        runTime: '2h 46m',
        ageRating: 'PG-13',
        imagePath: 'assets/images/dune2Poster1.jfif',
        screeningTime: 'Wednesday, 30th September 2026, 18:00 - 20:46',
        price: 12,
      );

      expect(movie2.formattedPrice, '£12.00');
    });

    test('Get Movie by ID when ID not null', () {
      final movieRepository = MovieRepository();
      final movie = movieRepository.getMovieById('dune')!;

      expect(movie, isNotNull);
      expect(movie.title, 'Dune: Part Two (2024)');
    });

    test('Get Movie by ID when ID is null', () {
      final movieRepository = MovieRepository();
      final Movie? movie = movieRepository.getMovieById('invalid');

      expect(movie, isNull);
    });

    test('JSON conversion preserves every sandwich field', () {
      
      final Map<String, dynamic> data = <String, dynamic>{
        'id': 'dune',
        'title': 'Dune: Part Two (2024)',
        'description':
            'The war for Arrakis begins. Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.',
        'runTime': '2h 46m',
        'ageRating': 'PG-13',
        'imagePath': 'assets/images/dune2Poster1.jfif',
        'screeningTime': 'Wednesday, 30th September 2026, 18:00 - 20:46',
        'price': 12.50,
      };

      final Movie movie = Movie.fromJson(data);
      expect(movie.id, 'dune');
      expect(movie.title, 'Dune: Part Two (2024)');
      expect(movie.price, 12.50);
      expect(movie.imagePath, 'assets/images/dune2Poster1.jfif');
      expect(movie.toJson(), data);
      
    });

    test('fromJson accepts a whole-number price', () {
        final Map<String, dynamic> data = <String, dynamic>{
        'id': 'test',
        'title': 'test!',
        'description':
            'A test',
        'runTime': '2h 46m',
        'ageRating': 'PG-13',
        'imagePath': 'test',
        'screeningTime': 'test',
        'price': 10,
        };
        final Movie movie = Movie.fromJson(data);
        expect(movie.price, 10.0);
        expect(movie.price, isA<double>());
    });
  });
}
