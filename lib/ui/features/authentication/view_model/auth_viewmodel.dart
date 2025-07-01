import 'package:agenda_wizard/data/repositories/auth/auth_repository.dart';
import 'package:agenda_wizard/models/user/user.dart';
import 'package:agenda_wizard/utils/result.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  /// Constructor
  AuthViewModel({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<Result> createUser(
      String name, String email, String password) async {
    UserModel newUser = UserModel(name: name, email: email);
    final result = await _authRepository.registerUserAuth(newUser, password);
    return result;
  }

  Future<Result> logIn(String email, String password) async {
    final result = await _authRepository.login(email, password);
    return result;
  }

  Future<Result> logOut(String email, String password) async {
    final result = await _authRepository.logout();
    return result;
  }
}
