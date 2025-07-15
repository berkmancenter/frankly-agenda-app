import 'package:agenda_wizard/data/repositories/agenda/agenda_repository.dart';
import 'package:agenda_wizard/models/agenda/agenda_item.dart';
import 'package:agenda_wizard/models/agenda/event_plan.dart';
import 'package:agenda_wizard/utils/result.dart';
import 'package:flutter/material.dart';

class AgendaEditorViewmodel extends ChangeNotifier {
  AgendaEditorViewmodel(
      {required this.agendaRepository, required this.eventPlan});

  final AgendaRepository agendaRepository;
  EventPlan eventPlan;

  Future<Result> updateAgenda(eventPlan) async {
    return await agendaRepository.updateEvent(eventPlan);
  }

  void updateItem(int agendaIndex, int sectionIndex, int itemIndex,
      String title, List<String> content) {
    AgendaItem newItem = AgendaItem(title: title, content: content);
    eventPlan.agendas[agendaIndex].sections[sectionIndex].items[itemIndex] =
        newItem;
    notifyListeners();
  }
}
