import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/services/firebase_service.dart';
import '../../../data/models/user_model.dart';

class UserViewModel with ChangeNotifier {
  UserModel? currentUser;

  void updateCurrentUser(UserModel? user) {
    currentUser = user;
    notifyListeners();
  }

  Future<void> deleteAccount(String userId) async {
    await FirebaseService.deleteUser(userId);
    await GoogleSignIn().signOut();
    updateCurrentUser(null);
  }

  Future<void> updateUserData(UserModel user) async {
    await FirebaseService.updateUser(user);
    updateCurrentUser(user);
  }
}
