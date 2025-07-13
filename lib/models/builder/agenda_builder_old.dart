
import 'package:agenda_wizard/utils/step_enums.dart';

class AgendaBuilderOld {
  AgendaBuilderOld();

  List<Goals>? goals;
  String? topic;
  String? topicDescription;
  String? audienceDescription;
  ParticipantBatches? participantCount;
  HasBreakoutGroups? hasBreakoutGroups;
  IsFacilitated? isFacilitated;
  IsSeries? isSeries;
  int? eventCount;
  Duration? eventLength; // in minutes
  
}
