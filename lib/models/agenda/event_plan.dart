import 'package:agenda_wizard/models/agenda/agenda.dart';
import 'package:agenda_wizard/models/agenda/warning.dart';
import 'package:json_annotation/json_annotation.dart';
part 'event_plan.g.dart';

@JsonSerializable(explicitToJson: true)
class EventPlan {
  String eventName, eventDescription;
  final List<Agenda> agendas;
  final bool isSeries;
  String? id;
  String? created;
  String? modified;
  List<Warning>? warnings;

  EventPlan(
      {required this.eventName,
      required this.eventDescription,
      required this.agendas,
      required this.isSeries,
      this.created,
      this.modified,
      this.id});

  factory EventPlan.fromJson(Map<String, dynamic> json) =>
      _$EventPlanFromJson(json);

  Map<String, dynamic> toJson() => _$EventPlanToJson(this);

  EventPlan deepCopy() {
    List<Agenda> newAgendas = [];
    for (Agenda agenda in agendas) {
      newAgendas.add(agenda.deepCopy());
    }

    EventPlan newEvent = EventPlan(
        eventName: eventName,
        eventDescription: eventDescription,
        agendas: newAgendas,
        isSeries: isSeries,
        id: id);

    if (warnings != null) {
      List<Warning> newWarnings = [];

      for (Warning warning in warnings!) {
        newWarnings.add(warning.deepCopy());
      }
      newEvent.warnings = newWarnings;
    }
    return newEvent;
  }
}
