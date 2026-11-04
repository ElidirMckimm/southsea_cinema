import 'package:southsea_cinema/models/movie.dart';

class CartItem {
  final Movie movie;
  final int quantity;

  const CartItem({required this.movie, required this.quantity});

  double get serviceFee => 0.50 * quantity;
  double get movieTotalPrice => movie.price * quantity;
  double get totalPrice => serviceFee + movieTotalPrice;

}


