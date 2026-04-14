import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_theme.dart';
import 'package:movies/features/movies/view/widgets/similar_item.dart';

import '../../../../data/models/movie_model.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../genre_movies_screen.dart';
import '../movies_details_screen.dart';

class MovieSection extends StatelessWidget {
  final String title;
  final Future<List<Movie>> future;

  const MovieSection({super.key, required this.title, required this.future});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => GenreMoviesScreen(genreName: title),
              ),
            ),
            child: Row(
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const Spacer(),
                Text(
                  "See More",
                  style: textTheme.titleSmall!.copyWith(
                    color: AppTheme.primary,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_right_alt, color: AppTheme.primary),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 240,
          child: FutureBuilder<List<Movie>>(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: LoadingIndicator());
              }
              if (snapshot.hasData) {
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    var movie = snapshot.data![index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              MoviesDetailsScreen(movieId: movie.id),
                        ),
                      ),
                      child: SizedBox(
                        width: 150,
                        child: SimilarItem(
                          url: movie.largeCoverImage,
                          rate: movie.rating.toString(),
                        ),
                      ),
                    );
                  },
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
