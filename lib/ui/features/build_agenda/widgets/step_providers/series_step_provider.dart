import 'package:agenda_wizard/ui/features/build_agenda/widgets/step_providers/step_provider.dart';
import 'package:rxdart/rxdart.dart';

enum IsSeries { series, standalone }


class SeriesStepProvider extends StepProvider {
  SeriesStepProvider() : super(isEnabled: true);

  final BehaviorSubject<IsSeries> _seriesStatus =
      BehaviorSubject<IsSeries>.seeded(IsSeries.series);


  BehaviorSubject<IsSeries?> get seriesStatus {
    return _seriesStatus;
  }

  Stream<IsSeries> getSeriesRadioStream() => _seriesStatus.stream;
  IsSeries getSeriesRadioValue() => _seriesStatus.value;

  void toggleSeriesStatus(IsSeries newValue) {
    _seriesStatus.add(newValue);
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
