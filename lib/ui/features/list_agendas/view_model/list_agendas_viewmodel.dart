import 'package:agenda_wizard/data/repositories/agenda/agenda_repository.dart';
import 'package:agenda_wizard/data/repositories/build_agenda/build_agenda_repository.dart';
import 'package:agenda_wizard/models/agenda/event_plan.dart';

class ListAgendasViewModel {
  final BuildAgendaRepository buildAgendaRepository;
  final AgendaRepository agendaRepository;

  ListAgendasViewModel(
      {required this.agendaRepository, required this.buildAgendaRepository});

  List<EventPlan> getRecentEventPlans() {
    Iterable<EventPlan> reversedPlans =
        agendaRepository.getRecentEventPlans.reversed;
    return reversedPlans.toList();
  }
}
