import 'package:agenda_wizard/ui/features/build_agenda/widgets/step_providers/step_provider.dart';
import 'package:rxdart/rxdart.dart';

enum ParticipantCounts { standalone }

class ParticipantCountStepProvider extends StepProvider {
  ParticipantCountStepProvider() : super(isEnabled: true);

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
  }

  @override
  int calculateNextStep() {
    int currStepIndex = wizardController.getStepIndex(this);
    return currStepIndex + 1;
  }

  @override
  void dispose() {
    _currParticipantCount.close();
  }
}
