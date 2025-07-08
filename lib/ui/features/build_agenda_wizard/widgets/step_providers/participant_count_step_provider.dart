import 'package:agenda_wizard/ui/features/build_agenda_wizard/view_model/build_agenda_viewmodel.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/form_step_provider.dart';
import 'package:agenda_wizard/utils/step_enums.dart';
import 'package:rxdart/rxdart.dart';

class ParticipantCountStepProvider extends FormStepProvider {
  ParticipantCountStepProvider(BuildAgendaViewmodel viewModel)
      : super(isEnabled: false, viewModel: viewModel);

  final List<bool> _participantCountStates = [
    false,
    false,
    false,
    false,
    false,
  ];

  final Map<ParticipantBatches, String> _participantCountMap = {
    ParticipantBatches.zeroToFive: '0-5',
    ParticipantBatches.fiveToTen: '5-10',
    ParticipantBatches.tenToTwentyFive: '10-25',
    ParticipantBatches.twentyFivetoFifty: '25-50',
    ParticipantBatches.fiftyPlus: '50+',
  };

  final BehaviorSubject<ParticipantBatches?> _currParticipantCount =
      BehaviorSubject<ParticipantBatches?>.seeded(null);

  Map<ParticipantBatches, String> get participantCountMap {
    return _participantCountMap;
  }

  BehaviorSubject<ParticipantBatches?> get currParticipantCount {
    return _currParticipantCount;
  }

  Stream<ParticipantBatches?> getParticipantRadioStream() =>
      _currParticipantCount.stream;
  bool getParticipantRadioValue(int radioNum) =>
      _participantCountStates[radioNum];

  String? getParticipantString(ParticipantBatches key) {
    return _participantCountMap[key];
  }

  void updateParticipantCount(int? newValue) {
    // if (ParticipantBatches.values != null)
    if (newValue != null) {
      _currParticipantCount.add(ParticipantBatches.values[newValue]);
    } else {
      _currParticipantCount.add(null);
    }
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
    if (_currParticipantCount.value == ParticipantBatches.zeroToFive) {
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

  @override
  void addData() {
    if (_currParticipantCount.value != null) {
      viewModel.addParticipantCount(_currParticipantCount.value!);
    } else {
      throw Exception("Sending null data from a radio button. Weird.");
    }
  }
}
