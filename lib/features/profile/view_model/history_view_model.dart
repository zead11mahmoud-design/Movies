import 'package:flutter/material.dart';

import '../../../core/services/firebase_service.dart';

class WatchHistory with ChangeNotifier {
  List<Map<String, dynamic>> watchHistoryMoviesList = [];

  Future<void> addToFavourites(
    int id,
    String movieCover,
    double rate,
    String userId,
    List<Map<String, dynamic>> wishlist,
  ) async {
    if (watchHistoryMoviesList.any((movie) => movie['id'] == id)) return;

    watchHistoryMoviesList.add({
      "id": id,
      "coverImage": movieCover,
      "movieRate": rate,
    });

    notifyListeners();
    await FirebaseService.saveUserData(
      userId: userId,
      history: watchHistoryMoviesList,
      wishlist: wishlist,
    );
  }

  bool isFavourite(int id) {
    return watchHistoryMoviesList.any((movie) => movie['id'] == id);
  }

  int get watchHistoryCount => watchHistoryMoviesList.length;
}
