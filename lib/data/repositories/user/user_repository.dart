import 'dart:io';

import 'package:agenda_wizard/models/firebase_collections.dart';
import 'package:agenda_wizard/models/user/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UserModel? _currentUser;

  UserModel? getCurrentUser() {
    if (_firebaseAuth.currentUser == null) {
      return null;
    } else if (_firebaseAuth.currentUser?.email == _currentUser?.email) {
      return _currentUser;
    } else {
      // different user, load their profile first
      loadUserProfile(_firebaseAuth.currentUser!);
      return _currentUser;
    }
  }

  void setCurrentUser(UserModel? user) {
    _currentUser = user;
  }

  Future<void> storeUserProfile(UserModel user) {
    return FirebaseFirestore.instance
        .collection(FirebaseCollections.users)
        .add(user.toJson());
  }

  /// If fireauth current user is null, we set current user to null
  /// Otherwise, load the user's details
  void loadUserProfile(User user) {
    User? user = _firebaseAuth.currentUser;
    if (user == null) {
      setCurrentUser(null);
      return;
    }
    FirebaseFirestore.instance
        .collection(FirebaseCollections.users)
        .doc(user.uid)
        .snapshots()
        .map((doc) => doc.exists
            ? setCurrentUser(
                UserModel.fromJson(doc.data() as Map<String, Object?>))
            : null);
  }
}
