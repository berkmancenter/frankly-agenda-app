import 'package:agenda_wizard/ui/features/build_agenda_wizard/view_model/build_agenda_viewmodel.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/step_provider.dart';
import 'package:agenda_wizard/utils/result.dart';
import 'package:rxdart/rxdart.dart';

enum AgendaStatuses { isComplete, inProgress, notStarted, hasError }

class GenerateAgendaProvider extends StepProvider {
  GenerateAgendaProvider(
      {required BuildAgendaViewmodel viewModel,
      required Function closeShopCallback})
      : _viewModel = viewModel,
        _closeShopCallback = closeShopCallback;

  final BuildAgendaViewmodel _viewModel;
  final Function _closeShopCallback;

  final BehaviorSubject<AgendaStatuses> _agendaStatus =
      BehaviorSubject<AgendaStatuses>.seeded(AgendaStatuses.notStarted);
  AgendaStatuses getAgendaStatusValue() => _agendaStatus.value;

  BehaviorSubject<AgendaStatuses> get agendaStatus {
    return _agendaStatus;
  }

  Stream<AgendaStatuses> getAgendaStatusStream() => agendaStatus.stream;

  @override
  Future<void> onShowing() async {
    await _buildAgenda();
  }

  Future<Result?> _buildAgenda() async {
    _agendaStatus.add(AgendaStatuses.inProgress);
    try {
      final agendaResult = await _viewModel.generateAgenda();
      switch (agendaResult) {
        case Ok<void>():
          print('Generated agenda');
          _agendaStatus.add(AgendaStatuses.isComplete);
          return agendaResult;
        case Error():
          print("Bad things agenda did not generate.");
          _agendaStatus.add(AgendaStatuses.hasError);
          return agendaResult;
      }
    } catch (e) {
      print("Bad things agenda did not generate very weird: ${e}");
      _agendaStatus.add(AgendaStatuses.hasError);
      return Result.error(Exception(e), "Weird error happened.");
    }
    finally {
      _closeShop();
    }
  }

  Future<void> _closeShop() async {
    await _closeShopCallback();
    wizardController.dispose();
  }

  @override
  void dispose() {
    _agendaStatus.close();
  }
}
