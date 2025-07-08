import 'package:agenda_wizard/ui/features/build_agenda_wizard/view_model/build_agenda_viewmodel.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/form_step_provider.dart';
import 'package:agenda_wizard/utils/step_enums.dart';
import 'package:rxdart/rxdart.dart';


class SeriesStepProvider extends FormStepProvider {
  SeriesStepProvider(BuildAgendaViewmodel viewModel)
      : super(isEnabled: false, viewModel: viewModel);

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
  
  @override
  void addData() {
    if (_seriesStatus.value != null) {
      viewModel.addIsSeries(_seriesStatus.value!);
    } else {
      throw Exception("Sending null data from a radio button. Weird.");
    }
  }
}
