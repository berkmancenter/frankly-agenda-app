import 'package:agenda_wizard/ui/features/build_agenda/widgets/step_providers/step_provider.dart';
import 'package:rxdart/rxdart.dart';

enum IsFacilitated { facilitated, notFacilitated }

class FacilitateStepProvider extends StepProvider {

  FacilitateStepProvider() : super(isEnabled: true);

  final BehaviorSubject<IsFacilitated> _facilitateStatus =
      BehaviorSubject<IsFacilitated>.seeded(IsFacilitated.facilitated);

  BehaviorSubject<IsFacilitated?> get facilitateStatus {
    return _facilitateStatus;
  }

  Stream<IsFacilitated> getFacilitatedRadioStream() => _facilitateStatus.stream;
  IsFacilitated getFacilitatedRadioValue() => _facilitateStatus.value;

  void toggleFacilitateStatus(IsFacilitated newValue) {
    _facilitateStatus.add(newValue);
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
