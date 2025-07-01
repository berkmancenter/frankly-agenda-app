import 'package:agenda_wizard/data/repositories/auth/auth_repository.dart';
import 'package:agenda_wizard/utils/result.dart';
import 'package:flutter/material.dart';

class LogoutViewModel extends ChangeNotifier {
  /// Constructor
  LogoutViewModel({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<Result> logOut() async {
    final result = await _authRepository.logout();
    return result;
  }
}
