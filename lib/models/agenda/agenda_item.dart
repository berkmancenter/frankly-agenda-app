import 'package:agenda_wizard/models/agenda/custom_duration.dart';
import 'package:json_annotation/json_annotation.dart';
part 'agenda_item.g.dart';

@JsonSerializable()
class AgendaItem {
  final String title;
  final List<String> content;
  final CustomDuration? duration;
  final List<String>? importance, guidance;

  AgendaItem(
      {required this.title,
      required this.content,
      this.duration,
      this.importance,
      this.guidance});

  factory AgendaItem.fromJson(Map<String, dynamic> json) =>
      _$AgendaItemFromJson(json);

  Map<String, dynamic> toJson() => _$AgendaItemToJson(this);
}
