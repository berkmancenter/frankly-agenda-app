import 'package:agenda_wizard/data/repositories/agenda/agenda_repository.dart';
import 'package:agenda_wizard/data/repositories/build_agenda/build_agenda_repository.dart';
import 'package:agenda_wizard/data/repositories/user/user_repository.dart';
import 'package:agenda_wizard/models/agenda/event_plan.dart';
import 'package:agenda_wizard/models/user/user.dart';
import 'package:agenda_wizard/utils/custom_result.dart';

class ListAgendasViewModel {
  final BuildAgendaRepository buildAgendaRepository;
  final AgendaRepository agendaRepository;
  final UserRepository userRepository;

  ListAgendasViewModel({
    required this.agendaRepository,
    required this.buildAgendaRepository,
    required this.userRepository,
  });

  List<EventPlan> getRecentEventPlans() {
    Iterable<EventPlan> reversedPlans =
        agendaRepository.getRecentEventPlans.reversed;
    return reversedPlans.toList();
  }

  Future<CustomResult<void>> deleteEventPlan(EventPlan eventPlan) async {
    return await agendaRepository.deleteEventPlan(eventPlan);
  }
}
