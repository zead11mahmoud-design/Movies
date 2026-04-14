import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/services/firebase_service.dart';
import '../../../core/services/google_sign_in_service.dart';
import '../../../data/models/user_model.dart';

class AuthViewModel with ChangeNotifier {
  final GoogleSignInService googleService = GoogleSignInService();

  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<UserModel?> login(String email, String password) async {
    return await FirebaseService.login(email: email, password: password);
  }

  Future<UserModel?> loginWithGoogle() async {
    final success = await googleService.signInWithGoogle();
    if (!success) return null;
    final firebaseUser = FirebaseAuth.instance.currentUser;
    return UserModel(
      id: firebaseUser?.uid ?? '',
      name: firebaseUser?.displayName ?? '',
      avatar: firebaseUser?.photoURL ?? '',
      email: firebaseUser?.email ?? '',
      phone: firebaseUser?.phoneNumber ?? '',
      wishlist: [],
      history: [],
    );
  }

  Future<UserModel?> register(UserModel user, String password) async {
    return FirebaseService.register(
      name: user.name,
      phone: user.phone,
      email: user.email,
      password: password,
      avatar: user.avatar,
    );
  }
}
