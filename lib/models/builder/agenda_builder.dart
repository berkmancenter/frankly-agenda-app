import 'package:agenda_wizard/utils/step_enums.dart';
import 'package:json_annotation/json_annotation.dart';
part 'agenda_builder.g.dart';

@JsonSerializable()
class AgendaBuilder {
  List<Goals>? goals;
  String? topic;
  String? topicDescription;
  String? audienceDescription;
  ParticipantBatches? participantCount;
  bool? hasBreakoutGroups;
  bool? isFacilitated;
  bool? isSeries;
  int? eventCount;
  Duration? eventLength;

  AgendaBuilder({
    this.goals,
    this.topic,
    this.topicDescription,
    this.audienceDescription,
    this.participantCount,
    this.hasBreakoutGroups,
    this.isFacilitated,
    this.isSeries,
    this.eventCount,
    this.eventLength, // in minutes
  });

  factory AgendaBuilder.fromJson(Map<String, Object?> json) =>
      _$AgendaBuilderFromJson(json);

  Map<String, dynamic> toJson() => _$AgendaBuilderToJson(this);
}
