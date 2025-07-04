import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/step_provider.dart';
import 'package:agenda_wizard/utils/step_enums.dart';
import 'package:rxdart/rxdart.dart';


class SeriesStepProvider extends StepProvider {
  SeriesStepProvider() : super(isEnabled: false);

  final BehaviorSubject<IsSeries?> _seriesStatus =
      BehaviorSubject<IsSeries?>.seeded(null);

  BehaviorSubject<IsSeries?> get seriesStatus {
    return _seriesStatus;
  }

  Stream<IsSeries?> getSeriesRadioStream() => _seriesStatus.stream;
  IsSeries? getSeriesRadioValue() => _seriesStatus.value;

  void toggleSeriesStatus(IsSeries? newValue) {
    _seriesStatus.add(newValue);

    if (_seriesStatus.value != null) {
      nextStepEnabled = true;
    } else {
      nextStepEnabled = false;
    }
  }

  @override
  int calculateNextStep() {
    if (_seriesStatus.value == IsSeries.standalone) {
      return Steps.eventLengthStep.index;
    }
    return Steps.eventCountStep.index;
  }

  @override
  void dispose() {
    _seriesStatus.close();
  }
}
