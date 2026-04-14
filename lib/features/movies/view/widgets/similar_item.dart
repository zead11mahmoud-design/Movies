import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/core/theme/app_theme.dart';

import '../../../../shared/widgets/loading_indicator.dart';

class SimilarItem extends StatelessWidget {
  final String url;
  final String rate;

  const SimilarItem({super.key, required this.url, required this.rate});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              url.isNotEmpty ? url : "https://via.placeholder.com/300",
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(child: LoadingIndicator());
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppTheme.gray,
                  child: const Center(
                    child: Icon(
                      Icons.broken_image,
                      color: AppTheme.white,
                      size: 40,
                    ),
                  ),
                );
              },
            ),
          ),

          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
              decoration: BoxDecoration(
                color: AppTheme.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    rate,
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall!.copyWith(color: AppTheme.white),
                  ),
                  const SizedBox(width: 5),
                  SvgPicture.asset(
                    'assets/icons/star.svg',
                    height: 15,
                    width: 15,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
