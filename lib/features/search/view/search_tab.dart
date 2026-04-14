import 'package:flutter/material.dart';

import '../../../data/api/api_service.dart';
import '../../../data/models/movie_model.dart';
import '../../../shared/widgets/default_text_form_field.dart';
import '../../movies/view/movies_details_screen.dart';
import '../../movies/view/widgets/similar_item.dart';

class SearchTab extends StatefulWidget {
  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController searchController = TextEditingController();
  List<Movie> movies = [];
  bool isLoading = false;

  void _onSearch(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        movies = [];
        isLoading = false;
      });
      return;
    }
    try {
      var searchResults = await ApiService.searchMovies(query);
      if (searchController.text.trim().isEmpty) {
        setState(() {
          movies = [];
        });
      } else {
        setState(() {
          movies = searchResults;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            DefaultTextFormField(
              hintText: 'Search',
              prefixIconImageName: 'search',
              controller: searchController,
              onChanged: (value) {
                _onSearch(value);
              },
            ),
            const SizedBox(height: 12),
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.amber),
                    )
                  : movies.isEmpty
                  ? _buildEmptyState()
                  : _buildMoviesGrid(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Image.asset(
        'assets/images/Empty.png',
        width: 100,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.movie_filter, size: 100, color: Colors.grey),
      ),
    );
  }

  Widget _buildMoviesGrid() {
    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 16,
        childAspectRatio: 0.65,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MoviesDetailsScreen(movieId: movie.id),
              ),
            );
          },
          child: SimilarItem(
            url: movie.largeCoverImage,
            rate: (movie.rating).toString(),
          ),
        );
      },
    );
  }
}
