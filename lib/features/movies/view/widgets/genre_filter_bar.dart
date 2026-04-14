import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_theme.dart';

class GenreFilterBar extends StatelessWidget {
  final List<String> genres;
  final String selectedGenre;
  final Function(String) onGenreSelected;

  const GenreFilterBar({
    super.key,
    required this.genres,
    required this.selectedGenre,
    required this.onGenreSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final genre = genres[index];
          bool isSelected = genre == selectedGenre;

          return GestureDetector(
            onTap: () => onGenreSelected(genre),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.primary : Colors.transparent,
                border: Border.all(color: AppTheme.primary, width: 1.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  genre,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: isSelected ? AppTheme.black : AppTheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
