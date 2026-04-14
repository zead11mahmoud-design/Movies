import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_theme.dart';
import 'package:movies/features/movies/view/widgets/movie_section.dart';

import '../../../data/api/api_service.dart';
import '../../../data/models/movie_model.dart';
import '../../../shared/widgets/loading_indicator.dart';
import '../../movies/view/movies_details_screen.dart';
import '../../movies/view/widgets/similar_item.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int currentIndex = 0;
  late Future<List<Movie>> moviesFuture;
  late Future<List<Movie>> actionMovies;
  late Future<List<Movie>> animationMovies;
  late Future<List<Movie>> dramaMovies;
  late Future<List<Movie>> sciFiMovies;
  late Future<List<Movie>> horrorMovies;

  @override
  void initState() {
    super.initState();
    moviesFuture = ApiService.fetchMovies();
    actionMovies = ApiService.fetchMoviesByGenre('Action');
    animationMovies = ApiService.fetchMoviesByGenre('Animation');
    dramaMovies = ApiService.fetchMoviesByGenre('Drama');
    sciFiMovies = ApiService.fetchMoviesByGenre('Sci-Fi');
    horrorMovies = ApiService.fetchMoviesByGenre('Horror');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.black,
      body: FutureBuilder<List<Movie>>(
        future: moviesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LoadingIndicator());
          } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "Error loading movies",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final List<Movie> movies = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: Container(
                        key: ValueKey<String>('bg_${movies[currentIndex].id}'),
                        height: 620,
                        width: double.infinity,
                        child: Image.network(
                          movies[currentIndex].largeCoverImage,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: AppTheme.black,
                              child: const Center(
                                child: Icon(
                                  Icons.movie_filter,
                                  color: AppTheme.gray,
                                  size: 80,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: 620,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            AppTheme.black.withOpacity(0.3),
                            AppTheme.black.withOpacity(0.8),
                            AppTheme.black,
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Image.asset('assets/images/Available Now.png'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 160),
                      child: CarouselSlider.builder(
                        itemCount: movies.length,
                        itemBuilder: (_, index, __) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MoviesDetailsScreen(
                                  movieId: movies[index].id,
                                ),
                              ),
                            );
                          },
                          child: SizedBox(
                            width: 200,
                            child: SimilarItem(
                              url: movies[index].largeCoverImage,
                              rate: movies[index].rating.toString(),
                            ),
                          ),
                        ),
                        options: CarouselOptions(
                          height: 320,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 0.50,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      top: 480,
                      left: 35,
                      child: Image.asset('assets/images/Watch Now.png'),
                    ),
                  ],
                ),
                MovieSection(title: 'Action', future: actionMovies),
                MovieSection(title: 'Animation', future: animationMovies),
                MovieSection(title: 'Drama', future: dramaMovies),
                MovieSection(title: 'Sci-Fi', future: sciFiMovies),
                MovieSection(title: 'Horror', future: horrorMovies),
                SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }
}
