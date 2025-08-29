// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warning.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Warning _$WarningFromJson(Map<String, dynamic> json) => Warning(
      name: json['name'] as String,
      message: json['message'] as String,
      errorType: json['errorType'] as String,
    );

Map<String, dynamic> _$WarningToJson(Warning instance) => <String, dynamic>{
      'name': instance.name,
      'message': instance.message,
      'errorType': instance.errorType,
    };
