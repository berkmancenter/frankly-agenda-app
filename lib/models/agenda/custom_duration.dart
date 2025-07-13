import 'package:json_annotation/json_annotation.dart';
part 'custom_duration.g.dart';

@JsonSerializable()
class CustomDuration {
  final int? hours, minutes, seconds;

  CustomDuration({
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  factory CustomDuration.fromJson(Map<String, dynamic> json) =>
      _$CustomDurationFromJson(json);

  Map<String, dynamic> toJson() => _$CustomDurationToJson(this);
}
