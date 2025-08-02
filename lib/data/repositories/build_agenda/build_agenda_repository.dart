import 'dart:convert';

import 'package:agenda_wizard/models/agenda/event_plan.dart';
import 'package:agenda_wizard/models/builder/agenda_builder.dart';
import 'package:agenda_wizard/utils/custom_result.dart';
import 'package:flutter/services.dart';
import 'package:cloud_functions/cloud_functions.dart';

class BuildAgendaRepository {
  final List<AgendaBuilder> _userAgendaBuilds = [];
  List<AgendaBuilder> get userAgendaBuilds {
    return _userAgendaBuilds;
  }

  Future<CustomResult<EventPlan>> buildAgenda(AgendaBuilder builder) async {

    try {
      EventPlan agendas = await _readJson(builder);
      return CustomResult.ok(agendas);
    } on FirebaseFunctionsException catch (e) {
      String message = "Cloud function error: ${e.code} - ${e.message}";
      print('Cloud function error: ${e.code} - ${e.message}');
      return CustomResult.error(
          Exception(message), "Failed to parse agenda JSON.");
    } catch (e) {
      return CustomResult.error(Exception(e), "Failed to parse agenda JSON.");
    }
  }

  Future<EventPlan> _readJson(AgendaBuilder builder) async {
    try {
      // final String response =
      //     await rootBundle.loadString('assets/sample_agenda.json');

      final HttpsCallable callable =
          FirebaseFunctions.instance.httpsCallable('createEventPlan');
      final HttpsCallableResult result = await callable.call(builder.toJson());

      var rawEvent = await json.decode(result.data['eventPlan']);
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
