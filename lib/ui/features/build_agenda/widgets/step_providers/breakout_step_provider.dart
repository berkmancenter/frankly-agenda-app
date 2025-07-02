import 'package:agenda_wizard/ui/features/build_agenda/widgets/step_providers/step_provider.dart';
import 'package:rxdart/rxdart.dart';

enum HasBreakoutGroups {
  breakoutGroups, noBreakoutGroups
}

class BreakoutStepProvider extends StepProvider {
    BreakoutStepProvider() : super(isEnabled: true);

  final BehaviorSubject<HasBreakoutGroups> _breakoutStatus =
      BehaviorSubject<HasBreakoutGroups>.seeded(HasBreakoutGroups.breakoutGroups);

  BehaviorSubject<HasBreakoutGroups?> get breakoutStatus {
    return _breakoutStatus;
  }

  Stream<HasBreakoutGroups> getBreakoutRadioStream() => _breakoutStatus.stream;
  HasBreakoutGroups getBreakoutRadioValue() => _breakoutStatus.value;

  void toggleBreakoutStatus(HasBreakoutGroups newValue) {
    _breakoutStatus.add(newValue);
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