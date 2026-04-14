import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_theme.dart';
import 'package:provider/provider.dart';

import '../../../../core/services/auth_service.dart';
import '../../../../core/utils/ui_utils.dart';
import '../../../../shared/widgets/defaulte_botton.dart';
import '../../../auth/view/login_screen.dart';
import '../../../movies/view_model/movie_view_model.dart';
import '../../view_model/history_view_model.dart';
import '../../view_model/user_view_model.dart';
import '../edit_profile.dart';

class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favouriteMovie = Provider.of<MovieViewModel>(context);
    final history = Provider.of<WatchHistory>(context);
    final userProvider = Provider.of<UserViewModel>(context);
    final currentUser = userProvider.currentUser;
    if (currentUser == null) {
      return Center(child: CircularProgressIndicator());
    }

    TextTheme textTheme = TextTheme.of(context);
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(color: AppTheme.darkGray),
      child: Column(
        children: [
          SizedBox(height: 35),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 45,
                backgroundImage: currentUser.avatar.startsWith('http')
                    ? NetworkImage(currentUser.avatar)
                    : AssetImage(currentUser.avatar) as ImageProvider,
              ),
              Column(
                children: [
                  Text(
                    favouriteMovie.favouriteMoviesList.length.toString(),
                    style: textTheme.headlineSmall,
                  ),
                  SizedBox(height: 12),
                  Text("Wish List", style: textTheme.titleLarge),
                ],
              ),
              Column(
                children: [
                  Text(
                    history.watchHistoryMoviesList.length.toString(),
                    style: textTheme.headlineSmall,
                  ),
                  SizedBox(height: 12),
                  Text("History", style: textTheme.titleLarge),
                ],
              ),
            ],
          ),
          SizedBox(height: 15),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              currentUser.name,
              style: textTheme.titleMedium!.copyWith(fontWeight: .w700),
            ),
          ),
          SizedBox(height: 23),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: DefaulteBotton(
                  text: 'Edit Profile',
                  onPressed: () {
                    Navigator.pushNamed(context, EditProfile.routeName);
                  },
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 3,
                child: DefaulteBotton(
                  text: 'Exit',
                  textColor: AppTheme.white,
                  suffixIconImageName: 'exit',
                  colorBotton: AppTheme.red,
                  onPressed: () async {
                    try {
                      await AuthService().logout();
                    } catch (error) {
                      UIUtils.showErrorMessage(error.toString());
                    }
                    if (!context.mounted) return;
                    Navigator.pushReplacementNamed(
                      context,
                      LoginScreen.routeName,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
