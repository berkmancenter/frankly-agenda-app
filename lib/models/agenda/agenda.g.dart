// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agenda.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Agenda _$AgendaFromJson(Map<String, dynamic> json) => Agenda(
      name: json['name'] as String,
      description: json['description'] as String,
      sections: (json['sections'] as List<dynamic>)
          .map((e) => AgendaSection.fromJson(e as Map<String, dynamic>))
          .toList(),
      isSeries: json['isSeries'] as bool,
      eventNumber: (json['eventNumber'] as num?)?.toInt(),
      additionalInformation: (json['additionalInformation'] as List<dynamic>?)
          ?.map((e) => AgendaItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AgendaToJson(Agenda instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'sections': instance.sections,
      'isSeries': instance.isSeries,
      'eventNumber': instance.eventNumber,
      'additionalInformation': instance.additionalInformation,
    };
