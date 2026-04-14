import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  Future<void> logout() async {
    final user = FirebaseAuth.instance.currentUser;
    final provider = user?.providerData.first.providerId;
    if (provider == 'google.com') {
      try {
        await GoogleSignIn().disconnect();
      } catch (_) {}
    }
    await FirebaseAuth.instance.signOut();
  }
}
