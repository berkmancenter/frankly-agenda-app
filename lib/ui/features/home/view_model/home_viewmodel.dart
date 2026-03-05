import 'package:agenda_wizard/data/repositories/agenda/agenda_repository.dart';
import 'package:agenda_wizard/data/repositories/build_agenda/build_agenda_repository.dart';
import 'package:agenda_wizard/data/repositories/user/user_repository.dart';
import 'package:agenda_wizard/models/agenda/agenda.dart';
import 'package:agenda_wizard/models/user/user.dart';
import 'package:agenda_wizard/utils/custom_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:agenda_wizard/routing/router.dart';
import 'package:agenda_wizard/routing/routes.dart';

class HomeViewmodel extends ChangeNotifier {
  // Add needed data respositories for homepage

  /// Constructor
  HomeViewmodel(
      {required UserRepository userRepository,
      required BuildAgendaRepository buildAgendaRepository,
      required AgendaRepository agendaRepository})
      : _userRepository = userRepository,
        _buildAgendaRepository = buildAgendaRepository,
        _agendaRepository = agendaRepository {
    loadHomeData = Command.createAsyncNoParam<CustomResult?>(_loadHomeData,
        initialValue: null)
      ..execute();
  }

  /// Class variables
  final UserRepository _userRepository;
  final AgendaRepository _agendaRepository;
  final BuildAgendaRepository _buildAgendaRepository;
  late Command<void, CustomResult?> loadHomeData;

  UserModel? _user;
  UserModel? get user => _user;

  final List<Agenda> _agendas = List.empty();
  List<Agenda> get agendas => _agendas;

  Future<CustomResult?> _loadHomeData() async {
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
    return const CustomResult.ok(null);
  }

  Future<void> buildSampleAgenda() async {
    try {
      final agendaResult = await _buildAgendaRepository.getSampleAgenda();
      switch (agendaResult) {
        case Ok<void>():
          router.go(Routes.editAgenda, extra: agendaResult.value);
        case Error():
          print("Bad errors.");
      }
    } catch (e) {
      print("Bad things agenda did not generate very weird: $e");
    }
  }
}
