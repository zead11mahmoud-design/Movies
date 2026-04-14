import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/core/theme/app_theme.dart';
import 'package:movies/features/movies/view/widgets/similar_item.dart';

import '../../../data/api/api_service.dart';
import '../../../data/models/movie_model.dart';
import '../../../shared/widgets/loading_indicator.dart';
import 'movies_details_screen.dart';

class GenreMoviesScreen extends StatefulWidget {
  final String genreName;

  const GenreMoviesScreen({required this.genreName});

  @override
  State<GenreMoviesScreen> createState() => _GenreMoviesScreenState();
}

class _GenreMoviesScreenState extends State<GenreMoviesScreen> {
  late Future<List<Movie>> genreMovies;

  @override
  void initState() {
    super.initState();
    genreMovies = ApiService.fetchMoviesByGenre(widget.genreName);
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppTheme.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("${widget.genreName} Movies", style: textTheme.titleLarge),
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/back.svg'),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List<Movie>>(
        future: genreMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LoadingIndicator());
          } else if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return Center(
              child: Text("No movies found", style: textTheme.titleMedium),
            );
          }

          final movies = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(15),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MoviesDetailsScreen(movieId: movies[index].id),
                    ),
                  );
                },
                child: SimilarItem(
                  url: movies[index].largeCoverImage,
                  rate: movies[index].rating.toString(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
