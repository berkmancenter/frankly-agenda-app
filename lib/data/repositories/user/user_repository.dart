import 'package:agenda_wizard/models/firebase_collections.dart';
import 'package:agenda_wizard/models/user/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserRepository extends ChangeNotifier{
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  void setCurrentUser(UserModel? user) {
    _currentUser = user;
    notifyListeners();
  }

  Future<void> storeUserProfile(UserModel user) async {
    final uid = _firebaseAuth.currentUser!.uid;
    final docRef = FirebaseFirestore.instance
        .collection(FirebaseCollections.users)
        .doc(uid); // pre-generate the ref

    await docRef.set({
      ...user.toJson(),
      'id': docRef.id,
    });
  }

  /// If fireauth current user is null, we set current user to null
  /// Otherwise, load the user's details
  void loadUserProfile(User user) {
    FirebaseFirestore.instance
        .collection(FirebaseCollections.users)
        .doc(user.uid)
        .snapshots()
        .listen((doc) => doc.exists
            ? setCurrentUser(
                UserModel.fromJson(doc.data() as Map<String, Object?>))
            : null);
  }
}
