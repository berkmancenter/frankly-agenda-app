import 'package:agenda_wizard/ui/features/build_agenda_wizard/view_model/build_agenda_viewmodel.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/form_step_provider.dart';

class InitStepProvider extends FormStepProvider {
  InitStepProvider(BuildAgendaViewmodel viewModel)
      : super(isEnabled: true, viewModel: viewModel);

  @override
  int calculateNextStep() {
    return Steps.goalStep.index;
  }

  @override
  void addData() {}
}
