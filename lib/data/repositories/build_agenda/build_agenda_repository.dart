// import agenda building package here
// and use those functions

import 'dart:convert';

import 'package:agenda_wizard/models/agenda/event_plan.dart';
import 'package:agenda_wizard/models/builder/agenda_builder.dart';
import 'package:agenda_wizard/utils/result.dart';
import 'package:flutter/services.dart';

class BuildAgendaRepository {
  final List<AgendaBuilder> _userAgendaBuilds = [];

  List<AgendaBuilder> get userAgendaBuilds {
    return _userAgendaBuilds;
  }

  Future<Result<EventPlan>> buildAgenda(AgendaBuilder builder) async {
    print(builder.toJson());
    try {
      await Future.delayed(const Duration(seconds: 2));
      EventPlan agendas = await _readJson();
      return Result.ok(agendas);
    } catch (e) {
      return Result.error(Exception(e), "Failed to parse agenda JSON.");
    }
  }

  Future<EventPlan> _readJson() async {
    try {
      final String response =
          await rootBundle.loadString('assets/sample_agenda.json');
      var rawEvent = await json.decode(response);
      EventPlan eventPlan = EventPlan.fromJson(rawEvent);

      return eventPlan;
    } catch (e) {
      print(e);
      throw Exception("bad json decoding: $e");
    }
  }

  void addAgendaBuild(AgendaBuilder agendaBuilder) {
    _userAgendaBuilds.add(agendaBuilder);
  }

  AgendaBuilder getLastAgendaBuild() {
    AgendaBuilder returnBuilder = _userAgendaBuilds.last;
    return returnBuilder;
  }
}
