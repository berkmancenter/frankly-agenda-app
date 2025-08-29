import 'package:agenda_wizard/utils/step_enums.dart';
import 'package:json_annotation/json_annotation.dart';
part 'agenda_builder.g.dart';

@JsonSerializable()
class AgendaBuilder {
  List<Goals>? goals;
  bool? isConcreteDecision;
  String? topic;
  String? topicDescription;
  String? audienceDescription;
  ParticipantBatches? participantCount;
  ParticipantBatches? participantBreakoutBatches;
  int? upperParticipantCount;
  int? lowerParticipantCount;
  bool? hasBreakoutGroups;
  bool? isFacilitated;
  bool? isSeries;
  int? eventCount;
  Duration? eventLength;

  AgendaBuilder({
    this.goals,
    this.isConcreteDecision,
    this.topic,
    this.topicDescription,
    this.audienceDescription,
    this.participantCount,
    this.upperParticipantCount,
    this.lowerParticipantCount,
    this.hasBreakoutGroups,
    this.isFacilitated,
    this.isSeries,
    this.eventCount,
    this.eventLength,
  });

  factory AgendaBuilder.fromJson(Map<String, Object?> json) =>
      _$AgendaBuilderFromJson(json);

  Map<String, dynamic> toJson() => _$AgendaBuilderToJson(this);
}
