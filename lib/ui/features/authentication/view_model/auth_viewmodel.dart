import 'package:agenda_wizard/data/repositories/auth/auth_repository.dart';
import 'package:agenda_wizard/models/user/user.dart';
import 'package:agenda_wizard/utils/custom_result.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  /// Constructor
  AuthViewModel({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<CustomResult> createUser(String name, String email, String password) async {
    UserModel newUser = UserModel(name: name, email: email);
    final result = await _authRepository.registerUserAuth(newUser, password);
    return result;
  }

  Future<CustomResult> logIn(String email, String password) async {
    final result = await _authRepository.login(email, password);
    return result;
  }

  Future<CustomResult> logOut(String email, String password) async {
    final result = await _authRepository.logout();
    return result;
  }
}
