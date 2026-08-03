import 'package:agenda_wizard/data/repositories/user/user_repository.dart';
import 'package:agenda_wizard/models/user/user.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  String _userName = "Guest";

  String get userName => _userName;

  final UserRepository _repository;
  String _name = "Loading...";

  UserModel? get currentUser => _repository.currentUser;

  UserProvider(this._repository) {
    _repository.addListener(_onUserChanged);
  }

  void _onUserChanged() {
    notifyListeners();
  }

  String get name => _repository.currentUser?.name ?? "Guest";

  @override
  void dispose() {
    _repository.removeListener(_onUserChanged);
    super.dispose();
  }
}
