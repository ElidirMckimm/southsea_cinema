class Movie {
  final String id;
  final String title;
  final String description;
  final String runTime;
  final String imagePath;
  final String ageRating;
  final String screeningTime;
  final double price;

  const Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.runTime,
    required this.imagePath,
    required this.ageRating,
    required this.price,
    required this.screeningTime,
  });

  String get formattedPrice => '£${price.toStringAsFixed(2)}';

  factory Movie.fromJson(Map<String, dynamic> json) {
    final String id = json["id"] as String;
    final String title = json["title"] as String;
    final String description = json["description"] as String;
    final String runTime = json["runTime"] as String;
    final String imagePath = json["imagePath"] as String;
    final String ageRating = json["ageRating"] as String;
    final String screeningTime = json["screeningTime"] as String;
    final num priceNumber = json['price'] as num;
    final double price = priceNumber.toDouble();

    return Movie(
      id: id,
      title: title,
      description: description,
      runTime: runTime,
      imagePath: imagePath,
      ageRating: ageRating,
      screeningTime: screeningTime,
      price: price,
    );
  }

  //returns a map, not JSON text, can be decoded later with dart:convert if needed
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'runTime': runTime,
      'imagePath': imagePath,
      'ageRating': ageRating,
      'screeningTime': screeningTime,
      'price': price,
    };
    return data;
  }
}
