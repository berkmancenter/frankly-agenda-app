import 'package:agenda_wizard/ui/features/build_agenda/widgets/step_providers/step_provider.dart';
import 'package:rxdart/rxdart.dart';

enum IsHosted { hosted, notHosted }

class HostedStepProvider extends StepProvider {

  HostedStepProvider() : super(isEnabled: true);

  final BehaviorSubject<IsHosted> _hostStatus =
      BehaviorSubject<IsHosted>.seeded(IsHosted.hosted);

  BehaviorSubject<IsHosted?> get hostStatus {
    return _hostStatus;
  }

  Stream<IsHosted> getHostedRadioStream() => _hostStatus.stream;
  IsHosted getHostedRadioValue() => _hostStatus.value;

  void toggleHostStatus(IsHosted newValue) {
    _hostStatus.add(newValue);
  }

  @override
  int calculateNextStep() {
    int currStepIndex = wizardController.getStepIndex(this);
    return currStepIndex + 1;
  }
  @override
  void dispose() {
    _hostStatus.close();
  }
}
