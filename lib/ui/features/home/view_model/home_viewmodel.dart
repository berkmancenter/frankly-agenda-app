import 'package:agenda_wizard/data/repositories/agenda/agenda_repository.dart';
import 'package:agenda_wizard/data/repositories/user/user_repository.dart';
import 'package:agenda_wizard/models/agenda/agenda.dart';
import 'package:agenda_wizard/models/user/user.dart';
import 'package:agenda_wizard/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';

class HomeViewmodel extends ChangeNotifier{
  // Add needed data respositories for homepage

  /// Constructor
  HomeViewmodel({
    required UserRepository userRepository, required AgendaRepository agendaRepository
  }) : _userRepository = userRepository, _agendaRepository = agendaRepository {
    loadHomeData = Command.createAsyncNoParam<Result?>(_loadHomeData, initialValue: null)..execute();
  }

  /// Class variables
  final UserRepository _userRepository;
  final AgendaRepository _agendaRepository;
  late Command<void, Result?> loadHomeData;

  UserModel? _user;
  UserModel? get user => _user;

  List<AgendaModel> _agendas = List.empty();
  List<AgendaModel> get agendas => _agendas;

  Future<Result?> _loadHomeData() async {
    _user = _userRepository.getCurrentUser();
    // try {
    //   final agendaResult = await _agendaRepository.getAgendas();
    //   switch (agendaResult) {
    //     case Ok<AgendaModel>():
    //       _agendas = agendaResult.value;
    //       print('Loaded user');
    //     case Error<AgendaModel>():
    //       print("Bad things user did not load.");
    //   }
    //   return userResult;
    // } finally {
    //   notifyListeners();
    // }
    
    notifyListeners();
    return const Result.ok(null);
   
  }

}