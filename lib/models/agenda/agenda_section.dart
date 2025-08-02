import 'package:agenda_wizard/models/agenda/agenda_item.dart';
import 'package:json_annotation/json_annotation.dart';
part 'agenda_section.g.dart';

@JsonSerializable()
class AgendaSection {
  String name, description;
  final List<AgendaItem> items;

  AgendaSection(
      {required this.name, required this.description, required this.items});

  factory AgendaSection.fromJson(Map<String, dynamic> json) =>
      _$AgendaSectionFromJson(json);

  Map<String, dynamic> toJson() => _$AgendaSectionToJson(this);

  AgendaSection deepCopy() {
    List<AgendaItem> newItems = [];
    for (AgendaItem item in items) {
      newItems.add(item.deepCopy());
    }
    AgendaSection newSection =
        AgendaSection(name: name, description: description, items: newItems);
    return newSection;
  }
}
