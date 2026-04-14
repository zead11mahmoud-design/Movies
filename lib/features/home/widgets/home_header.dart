import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_theme.dart';

import '../../../data/models/movie_model.dart';
import '../../movies/view/movies_details_screen.dart';
import '../../movies/view/widgets/similar_item.dart';

class HomeHeader extends StatefulWidget {
  final List<Movie> movies;

  const HomeHeader({super.key, required this.movies});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: Container(
            key: ValueKey<String>('bg-${widget.movies[currentIndex].id}'),
            height: 620,
            width: double.infinity,
            child: Image.network(
              widget.movies[currentIndex].largeCoverImage,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: AppTheme.gray,
                child: const Icon(
                  Icons.broken_image,
                  color: AppTheme.lightgray,
                  size: 80,
                ),
              ),
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
            itemCount: widget.movies.length,
            itemBuilder: (_, index, __) => GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      MoviesDetailsScreen(movieId: widget.movies[index].id),
                ),
              ),
              child: SizedBox(
                width: 200,
                child: SimilarItem(
                  url: widget.movies[index].largeCoverImage,
                  rate: widget.movies[index].rating.toString(),
                ),
              ),
            ),
            options: CarouselOptions(
              height: 320,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.50,
              onPageChanged: (index, reason) =>
                  setState(() => currentIndex = index),
            ),
          ),
        ),
        Positioned(
          top: 480,
          left: 35,
          child: Image.asset('assets/images/Watch Now.png'),
        ),
      ],
    );
  }
}
