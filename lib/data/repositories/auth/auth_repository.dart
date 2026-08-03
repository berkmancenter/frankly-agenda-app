import 'package:agenda_wizard/data/repositories/user/user_repository.dart';
import 'package:agenda_wizard/models/user/user.dart';
import 'package:agenda_wizard/utils/custom_result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthRepository extends ChangeNotifier {
  AuthRepository(this._userRepo) {
    init();
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final UserRepository _userRepo;

  bool _loggedIn = false;
  bool _isRegistering = false;
  bool get loggedIn => _loggedIn;

  Future<void> init() async {
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
        if (!_isRegistering) {
          // skip during registration
          _userRepo.loadUserProfile(user);
        }
      } else {
        _loggedIn = false;
      }
      notifyListeners();
    });
  }

  Future<CustomResult> registerUserAuth(
      UserModel rawUser, String password) async {
    _isRegistering = true;
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: rawUser.email,
        password: password,
      );
      await _userRepo.storeUserProfile(rawUser);
      _userRepo.loadUserProfile(_firebaseAuth.currentUser!); // then load
      _isRegistering = false;
      return const CustomResult.ok(null);
    } on FirebaseAuthException catch (e) {
      _isRegistering = false;
      String message = "";
      if (e.message != null) {
        message = e.message!;
      } else {
        message = 'Unknown error creating account.';
      }
      return CustomResult.error(Exception(e), message);
    } catch (e) {
      _isRegistering = false;
      String message = 'Unknown error ocurred: $e';
      return CustomResult.error(Exception(e), message);
    }

    
  }

  Future<CustomResult> login(String email, String password) async {
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
      return CustomResult.error(Exception(e), message);
    } catch (e) {
      String message = 'Unknown error ocurred: $e';
      return CustomResult.error(Exception(e), message);
    }
    return const CustomResult.ok(null);
  }

  Future<CustomResult> logout() async {
    try {
      await _firebaseAuth.signOut();
      _userRepo.clearUser();
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.message != null) {
        message = e.message!;
      } else {
        message = 'Unknown error creating account.';
      }
      return CustomResult.error(Exception(e), message);
    } catch (e) {
      String message = 'Unknown error ocurred: $e';
      return CustomResult.error(Exception(e), message);
    }
    return const CustomResult.ok(null);
  }
}
