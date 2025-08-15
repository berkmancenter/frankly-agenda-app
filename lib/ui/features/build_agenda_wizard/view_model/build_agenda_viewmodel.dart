import 'package:agenda_wizard/data/repositories/agenda/agenda_repository.dart';
import 'package:agenda_wizard/data/repositories/build_agenda/build_agenda_repository.dart';
import 'package:agenda_wizard/models/agenda/event_plan.dart';
import 'package:agenda_wizard/models/builder/agenda_builder.dart';
import 'package:agenda_wizard/utils/custom_result.dart';

import 'package:agenda_wizard/utils/step_enums.dart';

class BuildAgendaViewmodel {
  final BuildAgendaRepository _buildAgendaRepository;
  final AgendaRepository _agendaRepository;

  /// Constructor
  BuildAgendaViewmodel(
      {required BuildAgendaRepository buildAgendaRepository,
      required AgendaRepository agendaRepository,
      AgendaBuilder? agendaBuilder})
      : _buildAgendaRepository = buildAgendaRepository,
        _agendaRepository = agendaRepository,
        builder = agendaBuilder ?? AgendaBuilder();

  AgendaBuilder builder;

  void addGoal(List<Goals> goals) {
    builder.goals = goals;
  }

  void addIsConcrete(IsConcrete isConcreteDecision) {
    builder.isConcreteDecision = isConcreteDecision == IsConcrete.concrete;
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
    if (builder.hasBreakoutGroups == false) {
      _addBatches(count);
    }
  }

  void addBreakOutParticipantCount(ParticipantBatches count) {
    builder.participantBreakoutBatches = count;
    _addBatches(count);
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

  Future<CustomResult<Object>> generateAgenda() async {

    _buildAgendaRepository.addAgendaBuild(builder);
    final eventResult = await _buildAgendaRepository.buildAgenda(builder);
    if (eventResult.value == Ok) {
      _agendaRepository.addRecentAgenda(eventResult.value);
    }
    builder = AgendaBuilder();
    return eventResult;
  }

  void _addBatches(ParticipantBatches count) {
    if (count == ParticipantBatches.zeroToFive) {
      builder.lowerParticipantCount = 1;
      builder.upperParticipantCount = 5;
    } else if (count == ParticipantBatches.fiveToTen) {
      builder.lowerParticipantCount = 5;
      builder.upperParticipantCount = 10;
    } else if (count == ParticipantBatches.tenToFifteen) {
      builder.lowerParticipantCount = 10;
      builder.upperParticipantCount = 15;
    } else if (count == ParticipantBatches.tenToTwentyFive) {
      builder.lowerParticipantCount = 10;
      builder.upperParticipantCount = 25;
    } else if (count == ParticipantBatches.fifteenToTwentyFive) {
      builder.lowerParticipantCount = 15;
      builder.upperParticipantCount = 25;
    } else if (count == ParticipantBatches.twentyFivetoFifty) {
      builder.lowerParticipantCount = 25;
      builder.upperParticipantCount = 50;
    } else if (count == ParticipantBatches.fiftyPlus) {
      builder.lowerParticipantCount = 50;
      builder.upperParticipantCount = 75;
    }
  }
}
