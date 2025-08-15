import 'package:agenda_wizard/models/agenda/agenda_item.dart';
import 'package:agenda_wizard/models/agenda/custom_duration.dart';
import 'package:json_annotation/json_annotation.dart';
part 'agenda_section.g.dart';

@JsonSerializable()
class AgendaSection {
  String name, description;
  final List<AgendaItem> items;
  final CustomDuration duration;

  AgendaSection(
      {required this.name,
      required this.description,
      required this.items,
      required this.duration});

  factory AgendaSection.fromJson(Map<String, dynamic> json) =>
      _$AgendaSectionFromJson(json);

  Map<String, dynamic> toJson() => _$AgendaSectionToJson(this);

  AgendaSection deepCopy() {
    List<AgendaItem> newItems = [];
    for (AgendaItem item in items) {
      newItems.add(item.deepCopy());
    }
    CustomDuration newDuration;
    newDuration = duration.deepCopy();

    AgendaSection newSection = AgendaSection(
        name: name,
        description: description,
        items: newItems,
        duration: newDuration);
    return newSection;
  }
}
