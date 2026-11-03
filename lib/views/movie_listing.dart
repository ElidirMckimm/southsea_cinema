import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieListingView extends StatefulWidget {
  final Movie movie;
  const MovieListingView({super.key, required this.movie});

  @override
  State<MovieListingView> createState() => _MovieListingViewState();
}

class _MovieListingViewState extends State<MovieListingView> {
  int totalTickets = 1;
  int? orderedTickets;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.movie.title,
          style: cinemaHeaderStyle,
        ),
        backgroundColor: cinemaSurface,
        iconTheme: const IconThemeData(color: cinemaBrand),
        elevation: 0,
      ),
      drawer: const NavDrawer(),
      body: SingleChildScrollView(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          color: cinemaSurface,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        widget.movie.title,
                        style: const TextStyle(
                          fontSize: 32,
                          color: cinemaFontWhite,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      '(${widget.movie.ageRating})',
                      style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      widget.movie.imagePath,
                      width: 100,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '(Run time: ${widget.movie.runTime} mins)',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Book Tickets',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Screening Time: ${widget.movie.screeningTime}',
                  style: const TextStyle(fontSize: 20),
                ),
                Text(widget.movie.description,
                    style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 16.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Tickets (${widget.movie.formattedPrice} each)',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    Expanded(
                      child: DropdownMenu<int>(
                        initialSelection: 1,
                        onSelected: (int? value) {
                          if (value != null) {
                            setState(() {
                              totalTickets = value;
                            });
                          }
                        },
                        dropdownMenuEntries: const [
                          DropdownMenuEntry(value: 1, label: '1 Ticket'),
                          DropdownMenuEntry(value: 2, label: '2 Tickets'),
                          DropdownMenuEntry(value: 3, label: '3 Tickets'),
                          DropdownMenuEntry(value: 4, label: '4 Tickets'),
                          DropdownMenuEntry(value: 5, label: '5 Tickets'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cinemaBrand,
                  ),
                  onPressed: () {
                    setState(() {
                      orderedTickets = totalTickets;
                    });
                  },
                  child: Text(
                    orderedTickets == null
                        ? 'Add to order'
                        : '$orderedTickets ${orderedTickets == 1 ? 'ticket' : 'tickets'} ordered',
                    style: const TextStyle(color: cinemaFontWhite),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
