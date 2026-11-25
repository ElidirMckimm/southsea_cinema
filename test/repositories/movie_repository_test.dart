import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Movie Repo Tests', () {
    test('loadMoviesFromAsset reads the bundled JSON menu', () async {
      final MovieRepository repository = MovieRepository();
      final List<Movie> movies = await repository.loadMoviesFromAsset();

      expect(movies.length, 2);
      expect(movies[0].id, 'dune');
      expect(movies[1].id, 'batman');
      //checks if it returns the cached list
      expect(repository.getMovies(), movies);
    });
  });
}
