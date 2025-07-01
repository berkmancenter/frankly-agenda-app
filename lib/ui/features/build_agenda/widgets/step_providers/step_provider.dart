import 'package:flutter_wizard/flutter_wizard.dart';
import 'package:rxdart/rxdart.dart';

abstract class StepProvider with WizardStep {
  StepProvider({required bool isEnabled}) {
    nextStepEnabled = isEnabled;
    Future.microtask(() {
      _nextStep = calculateNextStep();
    });
  }
  int _nextStep = 0;

  final BehaviorSubject<bool> _nextStepEnabled =
      BehaviorSubject<bool>.seeded(false);

  int get nextStep {
    return _nextStep;
  }
  set nextStepEnabled(val) {
    _nextStepEnabled.add(val);
  }

  BehaviorSubject<bool> get nextStepEnabled {
    return _nextStepEnabled;
  }

  Stream<bool> getNextEnabledStream() => _nextStepEnabled.stream;

  bool isNextStepEnabled() => _nextStepEnabled.value;

  
  void goNextStep() {
    wizardController.goTo(index: nextStep);
  }

  int calculateNextStep();
  void dispose();
}