import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/movie_model.dart';

class ApiService {
  static const String baseUrl = "https://movies-api.accel.li/api/v2";

  static Future<List<Movie>> fetchMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/list_movies.json'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List moviesJson = data['data']['movies'];
      return moviesJson.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  static Future<Movie> getMovieDetails(int id) async {
    var url = Uri.parse(
      "https://movies-api.accel.li/api/v2/movie_details.json?movie_id=$id&with_images=true&with_cast=true",
    );
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return Movie.fromJson(data['data']['movie']);
    }
    throw Exception("Failed to load details");
  }

  static Future<List<Movie>> getSimilarMovies(int id) async {
    try {
      var url = Uri.parse(
        "https://movies-api.accel.li/api/v2/movie_suggestions.json?movie_id=$id",
      );
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['data'] != null && data['data']['movies'] != null) {
          List moviesJson = data['data']['movies'];
          return moviesJson.map((json) => Movie.fromJson(json)).toList();
        }
      }
      return [];
    } catch (e) {
      print("Similar Movies Error: $e");
      return [];
    }
  }

  static Future<List<Movie>> searchMovies(String query) async {
    final String urlString =
        '$baseUrl/list_movies.json?query_term=${Uri.encodeComponent(query)}';

    final response = await http.get(Uri.parse(urlString));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['data']['movies'] != null) {
        List moviesJson = data['data']['movies'];
        return moviesJson.map((json) => Movie.fromJson(json)).toList();
      }
      return [];
    } else {
      throw Exception('Failed to load movies');
    }
  }

  static Future<List<Movie>> fetchMoviesByGenre(String genre) async {
    final response = await http.get(
      Uri.parse('$baseUrl/list_movies.json?genre=$genre'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['data']['movies'] != null) {
        List moviesJson = data['data']['movies'];
        return moviesJson.map((json) => Movie.fromJson(json)).toList();
      }
      return [];
    } else {
      throw Exception('Failed to load movies for $genre');
    }
  }
}
