import 'package:agenda_wizard/ui/features/build_agenda_wizard/view_model/build_agenda_viewmodel.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/form_step_provider.dart';
import 'package:agenda_wizard/utils/step_enums.dart';
import 'package:rxdart/rxdart.dart';

class ConcreteDecisionProvider extends FormStepProvider{
   ConcreteDecisionProvider(BuildAgendaViewmodel viewModel)
      : super(isEnabled: false, viewModel: viewModel);

  final BehaviorSubject<IsConcrete?> _concreteStatus =
      BehaviorSubject<IsConcrete?>.seeded(null);

  BehaviorSubject<IsConcrete?> get concreteStatus {
    return _concreteStatus;
  }

  Stream<IsConcrete?> getConcreteRadioStream() => _concreteStatus.stream;
  IsConcrete? getConcreteRadioValue() => _concreteStatus.value;

  void toggleConcreteStatus(IsConcrete? newValue) {
    _concreteStatus.add(newValue);

    if (_concreteStatus.value != null) {
      nextStepEnabled = true;
    } else {
      nextStepEnabled = false;
    }
  }

  @override
  int calculateNextStep() {
    return Steps.topicStep.index;
  }


  @override
  void dispose() {
    _concreteStatus.close();
    super.dispose();
  }

  @override
  void addData() {
    if (_concreteStatus.value != null) {
      viewModel.addIsConcrete(_concreteStatus.value!);
    } else {
      throw Exception("Sending null data from a radio button. Weird.");
    }
  }
}