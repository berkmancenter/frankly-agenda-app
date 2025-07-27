import 'package:agenda_wizard/ui/features/build_agenda_wizard/view_model/build_agenda_viewmodel.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/step_provider.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

enum Steps {
  goalStep,
  concreteDecisionStep,
  topicStep,
  audienceStep,
  participantStep,
  breakoutStep,
  breakoutCountStep,
  facilitatedStep,
  facilitatedBreakoutStep,
  seriesStep,
  eventCountStep,
  eventLengthStep,
  seriesEventLengthStep,
  generateWizardStep
}

abstract class FormStepProvider extends StepProvider {
  FormStepProvider({required bool isEnabled, required this.viewModel}) {
    nextStepEnabled = isEnabled;
  }

  BuildAgendaViewmodel viewModel;

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
    addData();
    wizardController.goTo(index: calculateNextStep());
  }

  void goPreviousStep() {
    wizardController.goTo(index: previousStep);
  }

  void addData();
  int calculateNextStep();

  @mustCallSuper
  @override
  void dispose() {
    _nextStepEnabled.close();
  }
}
