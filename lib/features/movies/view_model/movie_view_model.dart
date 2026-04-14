import 'package:flutter/material.dart';

import '../../../core/services/firebase_service.dart';
import '../../../data/api/api_service.dart';
import '../../../data/models/movie_model.dart';
import '../../../data/models/user_model.dart';

class MovieViewModel with ChangeNotifier {
  List<Map<String, dynamic>> favouriteMoviesList = [];

  Movie? movie;
  List<Movie> similarMovies = [];

  bool isLoading = false;
  String? error;

  Future<void> fetchMovieDetails(int movieId) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      movie = await ApiService.getMovieDetails(movieId);
      similarMovies = await ApiService.getSimilarMovies(movieId);
    } catch (e) {
      print("ERROR: $e");
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> toggleFavourite(
    int id,
    String movieCover,
    double rate,
    UserModel user,
  ) async {
    int index = favouriteMoviesList.indexWhere((movie) => movie['id'] == id);

    if (index != -1) {
      favouriteMoviesList.removeAt(index);
    } else {
      favouriteMoviesList.add({
        "id": id,
        "coverImage": movieCover,
        "movieRate": rate,
      });
    }
    notifyListeners();
    await FirebaseService.saveUserData(
      userId: user.id,
      wishlist: favouriteMoviesList,
      history: user.history,
    );
  }

  bool isFavourite(int id) {
    return favouriteMoviesList.any((movie) => movie['id'] == id);
  }
}
