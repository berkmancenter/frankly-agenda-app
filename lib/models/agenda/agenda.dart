import 'package:agenda_wizard/models/agenda/agenda_item.dart';
import 'package:agenda_wizard/models/agenda/agenda_section.dart';
import 'package:json_annotation/json_annotation.dart';
part 'agenda.g.dart';

@JsonSerializable()
class Agenda {
  final List<AgendaSection> sections;
  final int? eventNumber; // which event(s) in a series of events
  final List<AgendaItem>? additionalInformation;

  Agenda(
      {required this.sections,
      this.eventNumber,
      this.additionalInformation});

  factory Agenda.fromJson(Map<String, dynamic> json) => _$AgendaFromJson(json);

  Map<String, dynamic> toJson() => _$AgendaToJson(this);
}
