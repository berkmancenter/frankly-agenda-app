import 'package:agenda_wizard/ui/features/build_agenda/widgets/step_providers/step_provider.dart';
import 'package:rxdart/rxdart.dart';

class GoalStepProvider extends StepProvider {
  GoalStepProvider() : super(isEnabled: false);
  /// Checkbox controls
  final Map<String, BehaviorSubject<bool>> _checkboxStates = {
    'dialogue': BehaviorSubject<bool>.seeded(false),
    'exploration': BehaviorSubject<bool>.seeded(false),
    'evaluation': BehaviorSubject<bool>.seeded(false),
    'deliberation': BehaviorSubject<bool>.seeded(false),
  };

  Map<String, BehaviorSubject<bool>> get checkboxStates {
    return _checkboxStates;
  }

  Stream<bool> getGoalCheckboxStream(String key) =>
      _checkboxStates[key]!.stream;
  bool getGoalCheckboxValue(String key) => _checkboxStates[key]!.value;

  void toggleCheckbox(String key, bool newValue) {
    _checkboxStates[key]!.add(newValue);

    for (var box in _checkboxStates.values) {
      if (box.value == true) {
        nextStepEnabled = true;
        return;
      }
    }
    nextStepEnabled = false;
  }

  @override
  int calculateNextStep() {
    return Steps.topicStep.index;
  }

  /// Dispose (required)

  @override
  void dispose() {
    for (var subject in _checkboxStates.values) {
      subject.close();
    }
  }
}
