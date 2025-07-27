import 'package:agenda_wizard/ui/features/build_agenda_wizard/view_model/build_agenda_viewmodel.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/form_step_provider.dart';
import 'package:agenda_wizard/utils/step_enums.dart';
import 'package:rxdart/rxdart.dart';

class BreakoutParticipantProvider extends FormStepProvider {
  BreakoutParticipantProvider(BuildAgendaViewmodel viewModel)
      : super(isEnabled: false, viewModel: viewModel);

  final List<bool> _breakoutCountStates = [
    false,
    false,
    false,
    false,
    false
  ];

  final Map<ParticipantBatches, String> _breakoutCountMap = {
    ParticipantBatches.zeroToFive: '0-5',
    ParticipantBatches.fiveToTen: '5-10',
    ParticipantBatches.tenToFifteen: '10-15',
    ParticipantBatches.fifteenToTwentyFive: '15-25',
    ParticipantBatches.twentyFivetoFifty: '25+',
  };

  final BehaviorSubject<ParticipantBatches?> _currBreakoutCount =
      BehaviorSubject<ParticipantBatches?>.seeded(null);

  Map<ParticipantBatches, String> get breakoutCountMap {
    return _breakoutCountMap;
  }

  BehaviorSubject<ParticipantBatches?> get currBreakoutCount {
    return _currBreakoutCount;
  }

  Stream<ParticipantBatches?> getBreakoutRadioStream() =>
      _currBreakoutCount.stream;
  bool getParticipantRadioValue(int radioNum) =>
      _breakoutCountStates[radioNum];

  String? getBreakoutString(ParticipantBatches key) {
    return breakoutCountMap[key];
  }

  void updateBreakoutCount(int? newValue) {
    // if (ParticipantBatches.values != null)
    if (newValue != null) {
      _currBreakoutCount.add(ParticipantBatches.values[newValue]);
    } else {
      _currBreakoutCount.add(null);
    }
    if (_currBreakoutCount.value != null) {
      nextStepEnabled = true;
    } else {
      nextStepEnabled = false;
    }
  }

  @override
  int calculateNextStep() {
    // breakout group step
    int nextStep = Steps.facilitatedBreakoutStep.index;
    return nextStep;
  }

  @override
  void dispose() {
    _currBreakoutCount.close();
    super.dispose();
  }

  @override
  void addData() {
    if (_currBreakoutCount.value != null) {
      viewModel.addBreakOutParticipantCount(_currBreakoutCount.value!);
    } else {
      throw Exception("Sending null data from a radio button. Weird.");
    }
  }
}
