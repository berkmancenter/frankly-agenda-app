import 'package:agenda_wizard/data/repositories/agenda/agenda_repository.dart';
import 'package:agenda_wizard/models/agenda/event_plan.dart';
import 'package:agenda_wizard/models/user/user.dart';
import 'package:flutter/foundation.dart';

class AgendaProvider extends ChangeNotifier {
  final AgendaRepository _agendaRepository;

  AgendaProvider(this._agendaRepository) {
    _agendaRepository.addListener(_onAgendaChanged);
  }

  List<EventPlan>? get userEventPlans => _agendaRepository.userEventPlans?.reversed.toList();

  void _onAgendaChanged() {
    notifyListeners();
  }

  bool get isLoading => _agendaRepository.isLoading;

  Future<void> loadEventPlans(UserModel user) async =>
      await _agendaRepository.loadEventPlans(user);

  @override
  void dispose() {
    _agendaRepository.removeListener(_onAgendaChanged);
    super.dispose();
  }
}
