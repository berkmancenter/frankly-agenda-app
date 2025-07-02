import 'package:agenda_wizard/ui/features/build_agenda/widgets/step_providers/facilitate_breakout_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/step_providers/breakout_step_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/step_providers/goal_step_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/step_providers/participant_count_step_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/step_providers/series_step_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/step_providers/facilitate_single_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/step_providers/topic_step_provider.dart';
import 'package:flutter_wizard/flutter_wizard.dart';
import 'package:rxdart/rxdart.dart';

enum Steps {
  goalStep,
  topicStep,
  participantStep,
  breakoutStep,
  facilitatedStep,
  facilitatedBreakoutStep,
  seriesStep
}

Map<Steps, StepProvider> stepProviderMap = {
  Steps.goalStep: GoalStepProvider(),
  Steps.topicStep: TopicStepProvider(),
  Steps.participantStep: ParticipantCountStepProvider(),
  Steps.breakoutStep: BreakoutStepProvider(),
  Steps.facilitatedStep: FacilitateSingleProvider(),
  Steps.facilitatedBreakoutStep: FacilitateBreakoutProvider(),
  Steps.seriesStep: SeriesStepProvider()
};

abstract class StepProvider with WizardStep {
  StepProvider({required bool isEnabled}) {
    nextStepEnabled = isEnabled;
  }

  int? _previousStep;

  int get previousStep {
    return _previousStep ?? 0;
  }

  set previousStep(int stepIndex) {
    _previousStep = stepIndex;
  }

  final BehaviorSubject<bool> _nextStepEnabled =
      BehaviorSubject<bool>.seeded(false);

  set nextStepEnabled(val) {
    _nextStepEnabled.add(val);
  }

  BehaviorSubject<bool> get nextStepEnabled {
    return _nextStepEnabled;
  }

  Stream<bool> getNextEnabledStream() => _nextStepEnabled.stream;
  bool isNextStepEnabled() => _nextStepEnabled.value;

  void goNextStep() {
    wizardController.goTo(index: calculateNextStep());
  }

  int calculateNextStep();

  void dispose();
}
