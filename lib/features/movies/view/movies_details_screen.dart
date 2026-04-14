import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/core/theme/app_theme.dart';
import 'package:movies/features/movies/view/widgets/cast_item.dart';
import 'package:movies/features/movies/view/widgets/genre_item.dart';
import 'package:movies/features/movies/view/widgets/movie_stat_chip.dart';
import 'package:movies/features/movies/view/widgets/screenshot_Item.dart';
import 'package:movies/features/movies/view/widgets/similar_item.dart';
import 'package:provider/provider.dart';

import '../../../shared/widgets/defaulte_botton.dart';
import '../../../shared/widgets/loading_indicator.dart';
import '../../profile/view_model/history_view_model.dart';
import '../../profile/view_model/user_view_model.dart';
import '../view_model/movie_view_model.dart';

class MoviesDetailsScreen extends StatefulWidget {
  static const String routeName = '/MoviesDetailsScreen';
  final int movieId;

  const MoviesDetailsScreen({super.key, required this.movieId});

  @override
  State<MoviesDetailsScreen> createState() => _MoviesDetailsScreenState();
}

class _MoviesDetailsScreenState extends State<MoviesDetailsScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<MovieViewModel>(
        context,
        listen: false,
      ).fetchMovieDetails(widget.movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserViewModel>(context, listen: false);
    final userId = userProvider.currentUser!.id;
    TextTheme textTheme = Theme.of(context).textTheme;
    double screenHeight = MediaQuery.sizeOf(context).height;
    final favouriteMovie = Provider.of<MovieViewModel>(context);
    final historyProvider = Provider.of<WatchHistory>(context, listen: false);

    return Scaffold(
      backgroundColor: AppTheme.black,
      body: Builder(
        builder: (context) {
          final movieVM = Provider.of<MovieViewModel>(context);
          if (movieVM.isLoading) {
            return const Center(child: LoadingIndicator());
          }
          if (movieVM.error != null) {
            return Center(child: Text(movieVM.error!));
          }
          if (movieVM.movie == null) {
            return const Center(child: Text("No Data"));
          }
          final movie = movieVM.movie!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.network(
                      movie.largeCoverImage,
                      height: screenHeight * 0.69,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: screenHeight * 0.69,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [AppTheme.gray, AppTheme.black],
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.broken_image_outlined,
                              color: AppTheme.lightgray,
                              size: 60,
                            ),
                          ),
                        );
                      },
                    ),
                    Container(
                      height: screenHeight * 0.69,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, AppTheme.black],
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: AppTheme.black,
                          child: Image.asset('assets/images/play.png'),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      left: 16,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset(
                          'assets/icons/back.svg',
                          width: 17,
                          height: 29,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      right: 16,
                      child: Consumer<MovieViewModel>(
                        builder: (context, favouriteMovie, child) {
                          final isFav = favouriteMovie.isFavourite(movie.id);

                          return InkWell(
                            onTap: () {
                              final user = userProvider.currentUser!;
                              favouriteMovie.toggleFavourite(
                                movie.id,
                                movie.largeCoverImage,
                                movie.rating,
                                user,
                              );
                            },
                            child: SvgPicture.asset(
                              'assets/icons/save.svg',
                              width: 20,
                              height: 30,
                              colorFilter: ColorFilter.mode(
                                isFav ? AppTheme.primary : Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 25,
                      left: 16,
                      right: 16,
                      child: Column(
                        children: [
                          Text(
                            movie.title,
                            style: textTheme.titleLarge,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            movie.year,
                            style: textTheme.titleMedium!.copyWith(
                              color: AppTheme.lightgray,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer<WatchHistory>(
                        builder: (context, watchHistory, child) {
                          return DefaulteBotton(
                            text: 'Watch',
                            onPressed: () {
                              watchHistory.addToFavourites(
                                movie.id,
                                movie.largeCoverImage,
                                movie.rating,
                                userId,
                                favouriteMovie.favouriteMoviesList,
                              );
                            },
                            colorBotton: AppTheme.red,
                            textColor: AppTheme.white,
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MovieStatChip(
                            icon: SvgPicture.asset(
                              'assets/icons/heart.svg',
                              width: 18,
                            ),
                            text: movie.likeCount.toString(),
                          ),
                          MovieStatChip(
                            icon: SvgPicture.asset(
                              'assets/icons/time.svg',
                              width: 18,
                            ),
                            text: '${movie.runtime}',
                          ),
                          MovieStatChip(
                            icon: SvgPicture.asset(
                              'assets/icons/star.svg',
                              width: 18,
                            ),
                            text: movie.rating.toString(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      if (movie.screenshots != null &&
                          movie.screenshots!.isNotEmpty) ...[
                        Text("Screen Shots", style: textTheme.titleLarge),
                        const SizedBox(height: 10),
                        ...movie.screenshots!
                            .map((url) => ScreenshotItem(url: url))
                            .toList(),
                      ],
                      const SizedBox(height: 16),
                      Text("Similar", style: textTheme.titleLarge),
                      const SizedBox(height: 16),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: movieVM.similarMovies.length > 4
                            ? 4
                            : movieVM.similarMovies.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.6,
                            ),
                        itemBuilder: (context, index) {
                          final simMovie = movieVM.similarMovies[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MoviesDetailsScreen(movieId: simMovie.id),
                                ),
                              );
                            },
                            child: SimilarItem(
                              url: simMovie.largeCoverImage,
                              rate: simMovie.rating.toString(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      Text("Summary", style: textTheme.titleLarge),
                      const SizedBox(height: 10),
                      Text(
                        movie.summary,
                        style: textTheme.titleSmall!.copyWith(
                          color: AppTheme.white,
                        ),
                      ),

                      const SizedBox(height: 20),
                      Text("Cast", style: textTheme.titleLarge),
                      const SizedBox(height: 15),

                      if (movie.cast != null)
                        ...movie.cast!
                            .map(
                              (c) => CastItem(
                                img:
                                    c.urlSmallImage ??
                                    "https://via.placeholder.com/150",
                                name: c.name,
                                character: c.characterName,
                              ),
                            )
                            .toList(),

                      const SizedBox(height: 16),
                      Text("Genres", style: textTheme.titleLarge),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 16,
                        runSpacing: 11,
                        children: movie.genres
                            .map((g) => GenreItem(text: g))
                            .toList(),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
