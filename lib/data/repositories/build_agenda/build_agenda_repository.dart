import 'dart:convert';

import 'package:agenda_wizard/models/agenda/event_plan.dart';
import 'package:agenda_wizard/models/builder/agenda_builder.dart';
import 'package:agenda_wizard/utils/custom_result.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/services.dart';

class BuildAgendaRepository {
  final List<AgendaBuilder> _userAgendaBuilds = [];
  List<AgendaBuilder> get userAgendaBuilds {
    return _userAgendaBuilds;
  }

  Future<CustomResult<Object>> buildAgenda(AgendaBuilder builder) async {
    try {
      HttpsCallableResult result = await callbuildAgendaCloudFunction(builder);
      var agendaResult = await json.decode(result.data['eventPlan']);
      if (agendaResult["isSuccess"] == true) {
        EventPlan eventPlan = EventPlan.fromJson(agendaResult["eventPlan"]);
        return CustomResult.ok(eventPlan);
      } else {
        return CustomResult.error(Exception(agendaResult["error"]),
            getDisplayError(agendaResult["error"]["message"]));
      }
    } on FirebaseFunctionsException catch (e) {
      String message = "Cloud function error: ${e.code} - ${e.message}";
      print('Cloud function error: ${e.code} - ${e.message}');
      return CustomResult.error(Exception(message), getDisplayError(null));
    } catch (e) {
      print('Other error: $e');
      return CustomResult.error(Exception(e), getDisplayError(null));
    }
  }

  Future<HttpsCallableResult> callbuildAgendaCloudFunction(
      AgendaBuilder builder) async {
    final HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('agendaBuildEventPlan');
    final HttpsCallableResult result = await callable.call(builder.toJson());
    return result;
  }

  String? getDisplayError(String? errorType) {
    if (errorType == "MissingInformation") {
      // shouldn't happen, but just in case
      return "We did not receive all required information. Please ensure you answer all the prompts so we can build the best agenda for you!";
    } else {
      return "We apologize- this error is on us. Please try again!";
    }
  }

  void addAgendaBuild(AgendaBuilder agendaBuilder) {
    _userAgendaBuilds.add(agendaBuilder);
  }

  AgendaBuilder getLastAgendaBuild() {
    AgendaBuilder returnBuilder = _userAgendaBuilds.last;
    return returnBuilder;
  }

  Future<CustomResult<EventPlan>> getSampleAgenda() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      EventPlan agendas = await _readJson();
      return CustomResult.ok(agendas);
    } catch (e) {
      return CustomResult.error(Exception(e), "Failed to parse agenda JSON.");
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

  EventPlan createSampleEventPlan() {
    EventPlan eventPlan = EventPlan(
        eventName: "Test Event - Climate Change",
        eventDescription:
            "This is a discussion about climate change and climate change policy.",
        agendas: [],
        isSeries: false);
    return eventPlan;
  }
}
