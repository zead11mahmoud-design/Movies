class Movie {
  final int id;
  final String title;
  final String year;
  final double rating;
  final int runtime;
  final int likeCount;
  final String summary;
  final String largeCoverImage;
  final List<String> genres;
  final List<Cast>? cast;
  final List<String> screenshots;

  Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.likeCount,
    required this.summary,
    required this.largeCoverImage,
    required this.genres,
    this.cast,
    required this.screenshots,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? "",
      year: json['year']?.toString() ?? "",
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      runtime: json['runtime'] ?? 0,
      likeCount: json['like_count'] ?? 0,
      summary: json['description_full'] ?? json['summary'] ?? "",
      largeCoverImage:
          json['large_cover_image'] ??
          json['medium_cover_image'] ??
          json['small_cover_image'] ??
          "",
      genres:
          (json['genres'] as List?)?.map((e) => e.toString()).toList() ?? [],
      cast: (json['cast'] as List?)?.map((c) => Cast.fromJson(c)).toList(),
      screenshots: [
        if (json['medium_screenshot_image1'] != null)
          json['medium_screenshot_image1'],
        if (json['medium_screenshot_image2'] != null)
          json['medium_screenshot_image2'],
        if (json['medium_screenshot_image3'] != null)
          json['medium_screenshot_image3'],
      ],
    );
  }
}

class Cast {
  final String name;
  final String characterName;
  final String? urlSmallImage;

  Cast({required this.name, required this.characterName, this.urlSmallImage});

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      name: json['name'] ?? "",
      characterName: json['character_name'] ?? "",
      urlSmallImage: json['url_small_image'],
    );
  }
}
