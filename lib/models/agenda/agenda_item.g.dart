// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agenda_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AgendaItem _$AgendaItemFromJson(Map<String, dynamic> json) => _AgendaItem(
      title: json['title'] as String,
      content: json['content'] as String?,
      duration: Duration(microseconds: (json['duration'] as num).toInt()),
    );

Map<String, dynamic> _$AgendaItemToJson(_AgendaItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'duration': instance.duration.inMicroseconds,
    };
