import 'package:agenda_wizard/ui/features/build_agenda_wizard/view_model/build_agenda_viewmodel.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/form_step_provider.dart';
import 'package:agenda_wizard/utils/step_enums.dart';
import 'package:rxdart/rxdart.dart';

class FacilitateStepProvider extends FormStepProvider {
  FacilitateStepProvider(BuildAgendaViewmodel viewModel)
      : super(isEnabled: false, viewModel: viewModel);

  final BehaviorSubject<IsFacilitated?> _facilitateStatus =
      BehaviorSubject<IsFacilitated?>.seeded(null);

  BehaviorSubject<IsFacilitated?> get facilitateStatus {
    return _facilitateStatus;
  }

  Stream<IsFacilitated?> getFacilitatedRadioStream() =>
      _facilitateStatus.stream;
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

  @override
  void addData() {
    if (_facilitateStatus.value != null) {
      viewModel.addIsFacilitated(_facilitateStatus.value!);
    } else {
      throw Exception("Sending null data from a radio button. Weird.");
    }
  }
}
