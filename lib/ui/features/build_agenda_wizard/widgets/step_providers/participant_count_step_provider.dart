import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/step_provider.dart';
import 'package:rxdart/rxdart.dart';

enum ParticipantCounts { standalone }

class ParticipantCountStepProvider extends StepProvider {
  ParticipantCountStepProvider() : super(isEnabled: false);

  final List<bool> _participantCountStates = [
    false,
    false,
    false,
    false,
    false,
  ];

  final Map<int, String> _participantCountMap = {
    1: '0-5',
    2: '5-10',
    3: '10-25',
    4: '25-50',
    5: '50+',
  };

  final BehaviorSubject<int?> _currParticipantCount =
      BehaviorSubject<int?>.seeded(null);

  Map<int, String> get participantCountMap {
    return _participantCountMap;
  }

  BehaviorSubject<int?> get currParticipantCount {
    return _currParticipantCount;
  }

  Stream<int?> getParticipantRadioStream() => _currParticipantCount.stream;
  bool getParticipantRadioValue(int radioNum) =>
      _participantCountStates[radioNum];

  String? getParticipantString(int key) {
    return _participantCountMap[key];
  }

  void updateParticipantCount(int? newValue) {
    _currParticipantCount.add(newValue);

    if (_currParticipantCount.value != null) {
      nextStepEnabled = true;
    } else {
      nextStepEnabled = false;
    }
  }

  @override
  int calculateNextStep() {
    // breakout group step
    int nextStep = Steps.breakoutStep.index;
    if (_currParticipantCount.value == 1) {
      // if it is a tiny amount, no participants
      // go to event facilitator step
      nextStep = Steps.facilitatedStep.index;
    }
    return nextStep;
  }

  @override
  void dispose() {
    _currParticipantCount.close();
  }
}
