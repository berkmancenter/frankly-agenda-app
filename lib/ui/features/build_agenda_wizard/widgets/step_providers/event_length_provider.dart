import 'package:agenda_wizard/ui/features/build_agenda_wizard/view_model/build_agenda_viewmodel.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/step_provider.dart';
import 'package:rxdart/rxdart.dart';

class EventLengthProvider extends StepProvider {
  EventLengthProvider(BuildAgendaViewmodel viewModel)
      : super(isEnabled: true, viewModel: viewModel);

  final BehaviorSubject<Duration> _duration =
      BehaviorSubject<Duration>.seeded(const Duration(minutes: 45));

  Stream<Duration> getDurationRadioStream() => _duration.stream;
  Duration getDurationRadioValue() => _duration.value;

  void updateDurationValue(Duration newValue) {
    _duration.add(newValue);
    nextStepEnabled = true;
  }
    

  @override
  int calculateNextStep() {
    return Steps.generateWizardStep.index; // 1000 wizard should finish
  }

  @override
  void dispose() {
    _duration.close();
  }

  @override
  void addData() {
    viewModel.addEventLength(_duration.value);
  }
}
