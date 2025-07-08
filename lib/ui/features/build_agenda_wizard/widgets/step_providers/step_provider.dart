import 'package:flutter_wizard/flutter_wizard.dart';
import 'package:rxdart/rxdart.dart';

abstract class StepProvider with WizardStep {

  int? _previousStep;

  int get previousStep {
    return _previousStep ?? 0;
  }

  set previousStep(int stepIndex) {
    _previousStep = stepIndex;
  }

  void dispose();
}
