import 'package:json_annotation/json_annotation.dart';
part 'custom_duration.g.dart';

@JsonSerializable()
class CustomDuration {
  final int hours, minutes, seconds;

  CustomDuration({
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  factory CustomDuration.fromJson(Map<String, dynamic> json) =>
      _$CustomDurationFromJson(json);

  Map<String, dynamic> toJson() => _$CustomDurationToJson(this);

  CustomDuration deepCopy() {
    CustomDuration newDuration =
        CustomDuration(hours: hours, minutes: minutes, seconds: seconds);
    return newDuration;
  }

  double getMinutes() {
    double minutesToReturn =
        hours * 60 + minutes + seconds / 60;
    return minutesToReturn;
  }
}
