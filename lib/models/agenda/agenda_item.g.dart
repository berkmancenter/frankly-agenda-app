// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agenda_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgendaItem _$AgendaItemFromJson(Map<String, dynamic> json) => AgendaItem(
      title: json['title'] as String,
      content:
          (json['content'] as List<dynamic>).map((e) => e as String).toList(),
      duration: json['duration'] == null
          ? null
          : CustomDuration.fromJson(json['duration'] as Map<String, dynamic>),
      importance: (json['importance'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      guidance: (json['guidance'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AgendaItemToJson(AgendaItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'duration': instance.duration,
      'importance': instance.importance,
      'guidance': instance.guidance,
    };
