// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agenda.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Agenda _$AgendaFromJson(Map<String, dynamic> json) => Agenda(
      sections: (json['sections'] as List<dynamic>)
          .map((e) => AgendaSection.fromJson(e as Map<String, dynamic>))
          .toList(),
      eventNumber: (json['eventNumber'] as num?)?.toInt(),
      additionalInformation: (json['additionalInformation'] as List<dynamic>?)
          ?.map((e) => AgendaItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AgendaToJson(Agenda instance) => <String, dynamic>{
      'sections': instance.sections,
      'eventNumber': instance.eventNumber,
      'additionalInformation': instance.additionalInformation,
    };
