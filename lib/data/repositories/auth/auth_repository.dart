import 'package:agenda_wizard/data/repositories/user/user_repository.dart';
import 'package:agenda_wizard/models/user/user.dart';
import 'package:agenda_wizard/utils/result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthRepository extends ChangeNotifier {
  AuthRepository(this._userRepo) {
    init();
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final UserRepository _userRepo;

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  Future<void> init() async {
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
        _userRepo.loadUserProfile(user);
      } else {
        _loggedIn = false;
      }
      notifyListeners();
    });
  }

  Future<Result> registerUserAuth(
      UserModel rawUser, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: rawUser.email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.message != null) {
        message = e.message!;
      } else {
        message = 'Unknown error creating account.';
      }
      return Result.error(Exception(e), message);
    } catch (e) {
      String message = 'Unknown error ocurred: $e';
      return Result.error(Exception(e), message);
    }
    _userRepo.storeUserProfile(rawUser);
    return const Result.ok(null);
  }

  Future<Result> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.message != null) {
        message = e.message!;
      } else {
        message = 'Unknown error creating account.';
      }
      return Result.error(Exception(e), message);
    } catch (e) {
      String message = 'Unknown error ocurred: $e';
      return Result.error(Exception(e), message);
    }
    return const Result.ok(null);
  }

  Future<Result> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.message != null) {
        message = e.message!;
      } else {
        message = 'Unknown error creating account.';
      }
      return Result.error(Exception(e), message);
    } catch (e) {
      String message = 'Unknown error ocurred: $e';
      return Result.error(Exception(e), message);
    }
    return const Result.ok(null);
    
  }
}
