import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_theme.dart';
import 'package:movies/features/profile/view/widgets/avatar_item.dart';
import 'package:provider/provider.dart';

import '../../../data/models/user_model.dart';
import '../../../shared/widgets/default_text_form_field.dart';
import '../../../shared/widgets/defaulte_botton.dart';
import '../../../shared/widgets/detault_text_botton.dart';
import '../../auth/view/login_screen.dart';
import '../view_model/user_view_model.dart';

class EditProfile extends StatefulWidget {
  static const String routeName = '/edit_profile';

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  int selectedIndex = 0;
  bool showAvatars = false;

  List<String> avatarList = [
    "assets/images/avatar_1.png",
    "assets/images/avatar_2.png",
    "assets/images/avatar_3.png",
    "assets/images/avatar_4.png",
    "assets/images/avatar_5.png",
    "assets/images/avatar_6.png",
    "assets/images/avatar_7.png",
    "assets/images/avatar_8.png",
    "assets/images/avatar_9.png",
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UserViewModel>(context, listen: false);
      final currentUser = userProvider.currentUser;
      if (currentUser != null) {
        int index = avatarList.indexOf(currentUser.avatar);
        if (index != -1) {
          setState(() {
            selectedIndex = index;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserViewModel>(context);
    final currentUser = userProvider.currentUser;

    if (currentUser == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(title: const Text('Pick Avatar')),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        showAvatars = true;
                      });
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(avatarList[selectedIndex]),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                DefaultTextFormField(
                  hintText: currentUser.name,
                  prefixIconImageName: 'person',
                ),
                const SizedBox(height: 20),
                DefaultTextFormField(
                  hintText: currentUser.phone,
                  prefixIconImageName: 'phone',
                ),
                const SizedBox(height: 10),
                DetaultTextBotton(text: 'Reset Password', onPressed: () {}),
                const Spacer(),
                DefaulteBotton(
                  text: 'Delete Account',
                  onPressed: () async {
                    final userVM = Provider.of<UserViewModel>(
                      context,
                      listen: false,
                    );
                    try {
                      await userVM.deleteAccount(currentUser.id);
                      Navigator.pushReplacementNamed(
                        context,
                        LoginScreen.routeName,
                      );
                    } catch (error) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error deleting account")),
                      );
                    }
                  },
                  colorBotton: AppTheme.red,
                  textColor: AppTheme.white,
                ),
                const SizedBox(height: 20),
                DefaulteBotton(
                  text: 'Update Data',
                  onPressed: () async {
                    String newAvatar = avatarList[selectedIndex];
                    UserModel updatedUser = UserModel(
                      id: currentUser.id,
                      name: currentUser.name,
                      phone: currentUser.phone,
                      email: currentUser.email,
                      avatar: newAvatar,
                      wishlist: currentUser.wishlist,
                      history: currentUser.history,
                    );
                    final userVM = Provider.of<UserViewModel>(
                      context,
                      listen: false,
                    );
                    try {
                      await userVM.updateUserData(updatedUser);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Updated successfully")),
                      );
                      if (!context.mounted) return;
                      Navigator.pop(context);
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error updating data")),
                      );
                    }
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
        if (showAvatars)
          Positioned.fill(
            child: Container(
              color: AppTheme.black.withOpacity(0.7),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SizedBox(
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: avatarList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                            ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                                showAvatars = false;
                              });
                            },
                            child: AvatarItem(
                              image: avatarList[index],
                              isSelected: selectedIndex == index,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
