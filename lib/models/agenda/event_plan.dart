import 'package:agenda_wizard/models/agenda/agenda.dart';
import 'package:json_annotation/json_annotation.dart';
part 'event_plan.g.dart';

@JsonSerializable()
class EventPlan {
  String eventName, eventDescription;
  final List<Agenda> agendas;
  final bool isSeries;

  EventPlan(
      {required this.eventName,
      required this.eventDescription,
      required this.agendas,
      required this.isSeries});

  factory EventPlan.fromJson(Map<String, dynamic> json) => _$EventPlanFromJson(json);

  Map<String, dynamic> toJson() => _$EventPlanToJson(this);
}
