import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/features/movies/view/widgets/similar_item.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../movies/view/movies_details_screen.dart';
import '../../../movies/view_model/movie_view_model.dart';
import '../../view_model/history_view_model.dart';

class WatchHistoryTabs extends StatefulWidget {
  @override
  State<WatchHistoryTabs> createState() => _WatchHistoryTabsState();
}

class _WatchHistoryTabsState extends State<WatchHistoryTabs> {
  int currentIndex = 0;
  PageController pageController = PageController();

  void onTabClick(int index) {
    setState(() {
      currentIndex = index;
    });
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final favouriteMovie = Provider.of<MovieViewModel>(context);
    final history = Provider.of<WatchHistory>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Container(
          color: AppTheme.darkGray,
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => onTabClick(0),
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/icons/list.svg'),
                      SizedBox(height: 5),
                      Text("Watch List", style: textTheme.titleMedium),
                      SizedBox(height: 8),

                      Container(
                        height: 3,
                        color: currentIndex == 0
                            ? AppTheme.primary
                            : Colors.transparent,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => onTabClick(1),
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/icons/history.svg'),
                      SizedBox(height: 5),
                      Text("History", style: textTheme.titleMedium),
                      SizedBox(height: 8),
                      Container(
                        height: 3,
                        color: currentIndex == 1
                            ? AppTheme.primary
                            : Colors.transparent,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            children: [
              favouriteMovie.favouriteMoviesList.isEmpty
                  ? Center(
                      child: Image.asset('assets/images/Empty.png', width: 100),
                    )
                  : GridView.builder(
                      padding: EdgeInsets.all(10),
                      itemCount: favouriteMovie.favouriteMoviesList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.6,
                      ),
                      itemBuilder: (context, i) {
                        final movie = favouriteMovie.favouriteMoviesList[i];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MoviesDetailsScreen(movieId: movie["id"]),
                              ),
                            );
                          },
                          child: SimilarItem(
                            url: movie["coverImage"],
                            rate: movie["movieRate"].toString(),
                          ),
                        );
                      },
                    ),
              history.watchHistoryMoviesList.isEmpty
                  ? Center(
                      child: Image.asset('assets/images/Empty.png', width: 100),
                    )
                  : GridView.builder(
                      padding: EdgeInsets.all(10),
                      itemCount: history.watchHistoryMoviesList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.6,
                      ),
                      itemBuilder: (context, i) {
                        final movie = history.watchHistoryMoviesList[i];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MoviesDetailsScreen(movieId: movie["id"]),
                              ),
                            );
                          },
                          child: SimilarItem(
                            url: movie["coverImage"],
                            rate: movie["movieRate"].toString(),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
