// import agenda building package here
// and use those functions

import 'dart:convert';

import 'package:agenda_wizard/models/builder/agenda_builder.dart';
import 'package:agenda_wizard/utils/result.dart';
import 'package:agenda_wizard/utils/step_enums.dart';
import 'package:flutter/services.dart';

class BuildAgendaRepository {
  AgendaBuilder builder = AgendaBuilder();

  Future<Result<String>> buildAgenda() async {
    print(builder.toJson());
    await Future.delayed(const Duration(seconds: 4));
    
    return const Result.ok("Hello I am an agenda!");
    // return Result.error(Exception("A really bad error happened!"),
    //     "A terrible error ocurred!!!!");
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/sample.json');
    final data = await json.decode(response);
// ...
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
