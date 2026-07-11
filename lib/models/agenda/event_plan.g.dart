// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventPlan _$EventPlanFromJson(Map<String, dynamic> json) => EventPlan(
      eventName: json['eventName'] as String,
      eventDescription: json['eventDescription'] as String,
      agendas: (json['agendas'] as List<dynamic>)
          .map((e) => Agenda.fromJson(e as Map<String, dynamic>))
          .toList(),
      isSeries: json['isSeries'] as bool,
      created: json['created'] as String?,
      modified: json['modified'] as String?,
      id: json['id'] as String?,
    )..warnings = (json['warnings'] as List<dynamic>?)
        ?.map((e) => Warning.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$EventPlanToJson(EventPlan instance) => <String, dynamic>{
      'eventName': instance.eventName,
      'eventDescription': instance.eventDescription,
      'agendas': instance.agendas.map((e) => e.toJson()).toList(),
      'isSeries': instance.isSeries,
      'id': instance.id,
      'created': instance.created,
      'modified': instance.modified,
      'warnings': instance.warnings?.map((e) => e.toJson()).toList(),
    };
