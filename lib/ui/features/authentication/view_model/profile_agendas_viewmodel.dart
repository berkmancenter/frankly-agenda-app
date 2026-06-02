import 'package:agenda_wizard/data/repositories/agenda/agenda_repository.dart';

class ProfileViewModel {
  final AgendaRepository agendaRepository;

  ProfileViewModel({required this.agendaRepository});

  int getEventPlanCount() {
    return agendaRepository.getEventPlanCount();
  }
}
