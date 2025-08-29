// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agenda_section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgendaSection _$AgendaSectionFromJson(Map<String, dynamic> json) =>
    AgendaSection(
      name: json['name'] as String,
      description: json['description'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => AgendaItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      duration:
          CustomDuration.fromJson(json['duration'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AgendaSectionToJson(AgendaSection instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'items': instance.items,
      'duration': instance.duration,
    };
