// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agenda_builder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AgendaBuilder _$AgendaBuilderFromJson(Map<String, dynamic> json) =>
    _AgendaBuilder(
      goals: (json['goals'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$GoalsEnumMap, e))
          .toList(),
      topic: json['topic'] as String?,
      topicDescription: json['topicDescription'] as String?,
      audienceDescription: json['audienceDescription'] as String?,
      participantCount: $enumDecodeNullable(
          _$ParticipantBatchesEnumMap, json['participantCount']),
      hasBreakoutGroups: json['hasBreakoutGroups'] as bool?,
      isFacilitated: json['isFacilitated'] as bool?,
      isSeries: json['isSeries'] as bool?,
      eventCount: (json['eventCount'] as num?)?.toInt(),
      eventLength: json['eventLength'] == null
          ? null
          : Duration(microseconds: (json['eventLength'] as num).toInt()),
    );

Map<String, dynamic> _$AgendaBuilderToJson(_AgendaBuilder instance) =>
    <String, dynamic>{
      'goals': instance.goals?.map((e) => _$GoalsEnumMap[e]!).toList(),
      'topic': instance.topic,
      'topicDescription': instance.topicDescription,
      'audienceDescription': instance.audienceDescription,
      'participantCount':
          _$ParticipantBatchesEnumMap[instance.participantCount],
      'hasBreakoutGroups': instance.hasBreakoutGroups,
      'isFacilitated': instance.isFacilitated,
      'isSeries': instance.isSeries,
      'eventCount': instance.eventCount,
      'eventLength': instance.eventLength?.inMicroseconds,
    };

const _$GoalsEnumMap = {
  Goals.dialogue: 'dialogue',
  Goals.exploration: 'exploration',
  Goals.evaluation: 'evaluation',
  Goals.deliberation: 'deliberation',
};

const _$ParticipantBatchesEnumMap = {
  ParticipantBatches.zeroToFive: 'zeroToFive',
  ParticipantBatches.fiveToTen: 'fiveToTen',
  ParticipantBatches.tenToTwentyFive: 'tenToTwentyFive',
  ParticipantBatches.twentyFivetoFifty: 'twentyFivetoFifty',
  ParticipantBatches.fiftyPlus: 'fiftyPlus',
};
