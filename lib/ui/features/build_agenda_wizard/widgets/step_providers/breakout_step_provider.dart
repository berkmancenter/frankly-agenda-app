import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/step_provider.dart';
import 'package:agenda_wizard/utils/step_enums.dart';
import 'package:rxdart/rxdart.dart';

class BreakoutStepProvider extends StepProvider {
  BreakoutStepProvider() : super(isEnabled: false);

  final BehaviorSubject<HasBreakoutGroups?> _breakoutStatus =
      BehaviorSubject<HasBreakoutGroups?>.seeded(null);

  BehaviorSubject<HasBreakoutGroups?> get breakoutStatus {
    return _breakoutStatus;
  }

  Stream<HasBreakoutGroups?> getBreakoutRadioStream() => _breakoutStatus.stream;
  HasBreakoutGroups? getBreakoutRadioValue() => _breakoutStatus.value;

  void toggleBreakoutStatus(HasBreakoutGroups? newValue) {
    _breakoutStatus.add(newValue);

    if (_breakoutStatus.value != null) {
      nextStepEnabled = true;
    } else {
      nextStepEnabled = false;
    }
  }

  @override
  int calculateNextStep() {
    if (_breakoutStatus.value == HasBreakoutGroups.breakoutGroups) {
      return Steps.facilitatedBreakoutStep.index;
    } else {
      return Steps.facilitatedStep.index;
    }
  }

  @override
  void dispose() {
    _breakoutStatus.close();
  }
}
