import 'package:southsea_cinema/models/movie.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class MovieRepository {
  List<Movie>? _cachedMovies;

  List<Movie> getMovies() {

    final List<Movie>? cachedMovies = _cachedMovies;
    if (cachedMovies != null) {
      return cachedMovies;
    }

    return const [
      Movie(
          id: 'dune',
          title: 'Dune: Part Two (2024)',
          description:
              'The war for Arrakis begins. Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.',
          runTime: '2h 46',
          ageRating: 'PG-13',
          imagePath: 'assets/images/dune2Poster1.jfif',
          screeningTime: 'Wednesday, 30th September 2026, 18:00 - 20:46',
          price: 12.50),
      Movie(
          id: 'batman',
          title: 'The Batman (2022)',
          description:
              'In his second year of fighting crime, Batman uncovers corruption in Gotham City that connects to his own family while facing a serial killer known as the Riddler.',
          runTime: '2h 56',
          ageRating: 'PG-13',
          imagePath: 'assets/images/theBatmanPoster.jfif',
          screeningTime: 'Friday, 2nd October 2026, 20:00 - 22:56',
          price: 10.00)
    ];
  }

  Movie? getMovieById(String id) {
    for (final movie in getMovies()) {
      if (movie.id == id) {
        return movie;
      }
    }
    return null;
  }

  //calling loadMovies reads the JSON file
  Future<List<Movie>> loadMoviesFromAsset({
    String assetPath = 'assets/data/movies.json'
  }) async {
    //when a text string is available rootbundle reads it
    final String jsonString = await rootBundle.loadString(assetPath);
    final dynamic decodedData = jsonDecode(jsonString);
    //know we are returning a list
    //takes decoded list and assigns to jsonList
    final List<dynamic> jsonList = decodedData as List<dynamic>;
    final List<Movie> loadedMovies = [];

    //loops through all movie entries
    for (final dynamic item in jsonList) {
      //converts them to a map so fields can be read by id etc.
      final Map<String, dynamic> itemMap = item as Map<String, dynamic>;
      //converts from json file to movie
      final Movie movie = Movie.fromJson(itemMap);
      loadedMovies.add(movie);
    }

    _cachedMovies = loadedMovies;
    return loadedMovies;
  }

}
//Movie? getMovieById(String id)
