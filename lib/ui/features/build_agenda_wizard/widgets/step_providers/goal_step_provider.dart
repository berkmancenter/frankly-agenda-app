import 'package:agenda_wizard/ui/features/build_agenda_wizard/view_model/build_agenda_viewmodel.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/form_step_provider.dart';
import 'package:agenda_wizard/utils/step_enums.dart';
import 'package:rxdart/rxdart.dart';

class GoalStepProvider extends FormStepProvider {
  GoalStepProvider(BuildAgendaViewmodel viewModel)
      : super(isEnabled: false, viewModel: viewModel);

  /// Checkbox controls
  final Map<Goals, BehaviorSubject<bool>> _checkboxStates = {
    Goals.dialogue: BehaviorSubject<bool>.seeded(false),
    Goals.exploration: BehaviorSubject<bool>.seeded(false),
    Goals.evaluation: BehaviorSubject<bool>.seeded(false),
    Goals.deliberation: BehaviorSubject<bool>.seeded(false),
  };

  Map<Goals, BehaviorSubject<bool>> get checkboxStates {
    return _checkboxStates;
  }

  Stream<bool> getGoalCheckboxStream(Goals key) => _checkboxStates[key]!.stream;
  bool getGoalCheckboxValue(Goals key) => _checkboxStates[key]!.value;

  void toggleCheckbox(Goals key, bool newValue) {
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

  @override
  void addData() {
    Map<Goals, BehaviorSubject<bool>> filteredGoals = Map.fromEntries(
        _checkboxStates.entries.where((entry) => entry.value.value == true));
    viewModel.addGoal(filteredGoals.keys.toList());
  }
}
