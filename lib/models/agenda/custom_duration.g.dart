// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_duration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomDuration _$CustomDurationFromJson(Map<String, dynamic> json) =>
    CustomDuration(
      hours: (json['hours'] as num).toInt(),
      minutes: (json['minutes'] as num).toInt(),
      seconds: (json['seconds'] as num).toInt(),
    );

Map<String, dynamic> _$CustomDurationToJson(CustomDuration instance) =>
    <String, dynamic>{
      'hours': instance.hours,
      'minutes': instance.minutes,
      'seconds': instance.seconds,
    };
