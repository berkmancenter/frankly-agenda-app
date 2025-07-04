
import 'package:agenda_wizard/utils/step_enums.dart';

class AgendaBuilder {
  AgendaBuilder();

  Goals? goal;
  String? topic;
  String? topicDescription;
  ParticipantBatches? participantCount;
  HasBreakoutGroups? hasBreakoutGroups;
  IsFacilitated? isFacilitated;
  IsSeries? isSeries;
  int? eventCount;
  int? eventLength; // in minutes
}
