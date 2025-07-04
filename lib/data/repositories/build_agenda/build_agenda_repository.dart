// import agenda building package here
// and use those functions

import 'package:agenda_wizard/models/builder/agenda_builder.dart';
import 'package:agenda_wizard/utils/result.dart';
import 'package:agenda_wizard/utils/step_enums.dart';

class BuildAgendaRepository {
  AgendaBuilder builder = AgendaBuilder();

  Future<Result<String>> buildAgenda() async {
    print(builder.toString());
    return Result.ok("Hello I am an agenda!");
  }

  void addGoal(Goals goal) {
    builder.goal = goal;
  }

  void addTopic(String topic, String topicDescription) {
    builder.topic = topic;
    builder.topicDescription = topicDescription;
  }

  void addParticipantCount(ParticipantBatches count) {
    builder.participantCount = count;
  }

  void addHasBreakoutGroups(HasBreakoutGroups hasGroups) {
    builder.hasBreakoutGroups = hasGroups;
  }

  void addIsFacilitated(IsFacilitated isFacilitated) {
    builder.isFacilitated = isFacilitated;
  }

  void addIsSeries(IsSeries isSeries) {
    builder.isSeries = isSeries;
  }

  void addEventCount(int eventCount) {
    builder.eventCount = eventCount;
  }

  void addEventLength(int eventLength) {
    builder.eventLength = eventLength;
  }
}
