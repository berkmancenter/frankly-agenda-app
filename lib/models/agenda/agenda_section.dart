import 'package:agenda_wizard/models/agenda/agenda_item.dart';
import 'package:json_annotation/json_annotation.dart';
part 'agenda_section.g.dart';

@JsonSerializable()
class AgendaSection {
  final String name, description;
  final List<AgendaItem> items;

  AgendaSection(
      {required this.name, required this.description, required this.items});

  factory AgendaSection.fromJson(Map<String, dynamic> json) => _$AgendaSectionFromJson(json);

  Map<String, dynamic> toJson() => _$AgendaSectionToJson(this);
}
