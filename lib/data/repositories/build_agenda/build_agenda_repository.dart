// import agenda building package here
// and use those functions

import 'dart:convert';

import 'package:agenda_wizard/models/agenda/event_plan.dart';
import 'package:agenda_wizard/models/builder/agenda_builder.dart';
import 'package:agenda_wizard/utils/result.dart';
import 'package:agenda_wizard/utils/step_enums.dart';
import 'package:flutter/services.dart';

class BuildAgendaRepository {
  AgendaBuilder builder = AgendaBuilder();

  Future<Result<EventPlan>> buildAgenda() async {
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
          await rootBundle.loadString('lib/assets/sample_agenda.json');
      var rawEvent = await json.decode(response);
      EventPlan eventPlan = EventPlan.fromJson(rawEvent);

      return eventPlan;
    } catch (e) {
      print(e);
      throw Exception("bad json decoding: $e");
    }
  }

  void addGoal(List<Goals> goals) {
    builder.goals = goals;
  }

  void addTopic(String topic, String topicDescription) {
    builder.topic = topic;
    builder.topicDescription = topicDescription;
  }

  void addAudience(String audienceDescription) {
    builder.audienceDescription = audienceDescription;
  }

  void addParticipantCount(ParticipantBatches count) {
    builder.participantCount = count;
  }

  void addHasBreakoutGroups(HasBreakoutGroups hasGroups) {
    builder.hasBreakoutGroups = hasGroups == HasBreakoutGroups.breakoutGroups;
  }

  void addIsFacilitated(IsFacilitated isFacilitated) {
    builder.isFacilitated = isFacilitated == IsFacilitated.facilitated;
  }

  void addIsSeries(IsSeries isSeries) {
    builder.isSeries = isSeries == IsSeries.series;
  }

  void addEventCount(int eventCount) {
    builder.eventCount = eventCount;
  }

  void addEventLength(Duration eventLength) {
    builder.eventLength = eventLength;
  }
}
