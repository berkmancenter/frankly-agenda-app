import 'package:agenda_wizard/data/repositories/build_agenda/build_agenda_repository.dart';
import 'package:agenda_wizard/models/agenda/agenda.dart';
import 'package:agenda_wizard/models/agenda/event_plan.dart';
import 'package:agenda_wizard/utils/result.dart';
import 'package:agenda_wizard/utils/step_enums.dart';

class BuildAgendaViewmodel {
  final BuildAgendaRepository _buildAgendaRepository;

  /// Constructor
  BuildAgendaViewmodel({required BuildAgendaRepository buildAgendaRepository})
      : _buildAgendaRepository = buildAgendaRepository;

  void addGoal(List<Goals> goals) {
    _buildAgendaRepository.addGoal(goals);
  }

  void addTopic(String topic, String topicDescription) {
    _buildAgendaRepository.addTopic(topic, topicDescription);
  }

  void addAudience(String audienceDescription) {
    _buildAgendaRepository.addAudience(audienceDescription);
  }

  void addParticipantCount(ParticipantBatches count) {
    _buildAgendaRepository.addParticipantCount(count);
  }

  void addHasBreakoutGroups(HasBreakoutGroups hasGroups) {
    _buildAgendaRepository.addHasBreakoutGroups(hasGroups);
  }

  void addIsFacilitated(IsFacilitated isFacilitated) {
    _buildAgendaRepository.addIsFacilitated(isFacilitated);
  }

  void addIsSeries(IsSeries isSeries) {
    _buildAgendaRepository.addIsSeries(isSeries);
  }

  void addEventCount(int eventCount) {
    _buildAgendaRepository.addEventCount(eventCount);
  }

  void addEventLength(Duration eventLength) {
    _buildAgendaRepository.addEventLength(eventLength);
  }

  Future<Result<EventPlan>> generateAgenda() async {
    final eventResult = await _buildAgendaRepository.buildAgenda();
    return eventResult;
  }


  
}
