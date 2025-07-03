import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/step_provider.dart';
import 'package:rxdart/rxdart.dart';

class EventLengthProvider extends StepProvider {
  EventLengthProvider() : super(isEnabled: true);

  final BehaviorSubject<Duration> _duration =
      BehaviorSubject<Duration>.seeded(const Duration(minutes: 45));


  Stream<Duration> getDurationRadioStream() => _duration.stream;
  Duration getDurationRadioValue() => _duration.value;

  void updateDurationValue(Duration newValue) {
    _duration.add(newValue);
  }

  @override
  int calculateNextStep() {
    return 1000; // 1000 wizard should finish
  }

  @override
  void dispose() {
    _duration.close();
  }
}
