import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/models/user_model.dart';

class FirebaseService {
  static CollectionReference<UserModel> getUsersCollection() =>
      FirebaseFirestore.instance
          .collection('users')
          .withConverter<UserModel>(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson(),
          );

  static Future<UserModel> register({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String avatar,
  }) async {
    UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    UserModel user = UserModel(
      id: credential.user!.uid,
      name: name,
      phone: phone,
      email: email,
      avatar: avatar,
      wishlist: [],
      history: [],
    );
    CollectionReference<UserModel> usersCollection = getUsersCollection();
    await usersCollection.doc(user.id).set(user);
    return user;
  }

  static Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    credential.user!.uid;
    CollectionReference<UserModel> usersCollection = getUsersCollection();
    DocumentSnapshot<UserModel> docSnapshot = await usersCollection
        .doc(credential.user!.uid)
        .get();
    return docSnapshot.data()!;
  }

  static Future<void> logout() => FirebaseAuth.instance.signOut();

  static Future<void> updateUser(UserModel user) async {
    CollectionReference<UserModel> usersCollection = getUsersCollection();
    await usersCollection.doc(user.id).set(user, SetOptions(merge: true));
  }

  static Future<void> deleteUser(String userId) async {
    await getUsersCollection().doc(userId).delete();
    await FirebaseAuth.instance.currentUser!.delete();
  }

  static Future<void> saveUserData({
    required String userId,
    required List<Map<String, dynamic>> wishlist,
    required List<Map<String, dynamic>> history,
  }) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      "wishlist": wishlist,
      "history": history,
    }, SetOptions(merge: true));
  }

  static Future<UserModel?> getUser(String userId) async {
    var doc = await getUsersCollection().doc(userId).get();
    if (!doc.exists || doc.data() == null) {
      return null;
    }
    return doc.data();
  }
}
