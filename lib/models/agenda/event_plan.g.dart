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
    );

Map<String, dynamic> _$EventPlanToJson(EventPlan instance) => <String, dynamic>{
      'eventName': instance.eventName,
      'eventDescription': instance.eventDescription,
      'agendas': instance.agendas,
      'isSeries': instance.isSeries,
    };
