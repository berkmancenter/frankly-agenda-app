import 'package:agenda_wizard/utils/step_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart'; 
part 'agenda_builder.freezed.dart';
part 'agenda_builder.g.dart';

@unfreezed
abstract class AgendaBuilder with _$AgendaBuilder {
  AgendaBuilder._();

  factory AgendaBuilder({
    List<Goals>? goals,
    String? topic,
    String? topicDescription,
    String? audienceDescription,
    ParticipantBatches? participantCount,
    bool? hasBreakoutGroups,
    bool? isFacilitated,
    bool? isSeries,
    int? eventCount,
    Duration? eventLength, // in minutes
  }) = _AgendaBuilder;

  factory AgendaBuilder.fromJson(Map<String, Object?> json) => _$AgendaBuilderFromJson(json);


  
}
