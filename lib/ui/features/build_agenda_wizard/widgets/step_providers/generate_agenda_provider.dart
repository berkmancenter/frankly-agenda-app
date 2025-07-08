import 'package:agenda_wizard/ui/features/build_agenda_wizard/view_model/build_agenda_viewmodel.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/view_model/generate_agenda_viewmodel.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/form_step_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/step_provider.dart';
import 'package:agenda_wizard/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:flutter_wizard/flutter_wizard.dart';
import 'package:rxdart/src/subjects/behavior_subject.dart';

enum agendaStatuses { isComplete, inProgress, notStarted, hasError }

class GenerateAgendaProvider extends StepProvider {
  // GenerateAgendaProvider({
  //   required BuildAgendaViewmodel viewModel
  // }) : _viewModel = viewModel {
  //   buildAgenda = Command.createAsyncNoParam<Result?>(_buildAgenda, initialValue: null)..execute();
  // }

  GenerateAgendaProvider({required BuildAgendaViewmodel viewModel})
      : _viewModel = viewModel;

  final BuildAgendaViewmodel _viewModel;

  final BehaviorSubject<agendaStatuses> _agendaStatus =
      BehaviorSubject<agendaStatuses>.seeded(agendaStatuses.notStarted);
  agendaStatuses getAgendaStatusValue() => _agendaStatus.value;

  BehaviorSubject<agendaStatuses> get agendaStatus {
    return _agendaStatus;
  }

  Stream<agendaStatuses> getAgendaStatusStream() => agendaStatus.stream;

  // Command<void, Result?>? buildAgenda;

  // void callBuildAgenda() async {
  //   buildAgenda =
  //       Command.createAsyncNoParam<Result?>(_buildAgenda, initialValue: null)
  //         ..execute();
  // }

  Future<Result?> buildAgenda() async {
    _agendaStatus.add(agendaStatuses.inProgress);
    try {
      final agendaResult = await _viewModel.generateAgenda();
      switch (agendaResult) {
        case Ok<void>():
          print('Generated agenda');
          _agendaStatus.add(agendaStatuses.isComplete);
          return agendaResult;
        case Error():
          print("Bad things agenda did not generate.");
          _agendaStatus.add(agendaStatuses.hasError);
          return agendaResult;
      }
    } catch (e) {
      print("Bad things agenda did not generate very weird: ${e}");
      _agendaStatus.add(agendaStatuses.hasError);
      return Result.error(Exception(e), "Weird error happened.");
    }
  }

  @override
  void dispose() {
    _agendaStatus.close();
  }
}
