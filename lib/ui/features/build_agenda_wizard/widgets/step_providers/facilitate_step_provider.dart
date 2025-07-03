import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/step_provider.dart';
import 'package:rxdart/rxdart.dart';

enum IsFacilitated { facilitated, notFacilitated }

class FacilitateStepProvider extends StepProvider {

  FacilitateStepProvider() : super(isEnabled: false);

  final BehaviorSubject<IsFacilitated?> _facilitateStatus =
      BehaviorSubject<IsFacilitated?>.seeded(null);

  BehaviorSubject<IsFacilitated?> get facilitateStatus {
    return _facilitateStatus;
  }

  Stream<IsFacilitated?> getFacilitatedRadioStream() => _facilitateStatus.stream;
  IsFacilitated? getFacilitatedRadioValue() => _facilitateStatus.value;

  void toggleFacilitateStatus(IsFacilitated? newValue) {
    _facilitateStatus.add(newValue);

    if (_facilitateStatus.value != null) {
      nextStepEnabled = true;
    } else {
      nextStepEnabled = false;
    }
  }

  @override
  int calculateNextStep() {
    return Steps.seriesStep.index;
  }
  @override
  void dispose() {
    _facilitateStatus.close();
  }
}
