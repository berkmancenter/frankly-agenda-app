
import 'package:agenda_wizard/utils/step_enums.dart';

class AgendaBuilder {
  AgendaBuilder();

  List<Goals>? goals;
  String? topic;
  String? topicDescription;
  ParticipantBatches? participantCount;
  HasBreakoutGroups? hasBreakoutGroups;
  IsFacilitated? isFacilitated;
  IsSeries? isSeries;
  int? eventCount;
  Duration? eventLength; // in minutes
}
