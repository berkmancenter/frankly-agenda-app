import 'package:agenda_wizard/ui/features/build_agenda_wizard/view_model/build_agenda_viewmodel.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/view_model/generate_agenda_viewmodel.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/step_provider.dart';
import 'package:agenda_wizard/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:flutter_wizard/flutter_wizard.dart';

class GenerateAgendaProvider extends ChangeNotifier with WizardStep {
  // GenerateAgendaProvider({
  //   required BuildAgendaViewmodel viewModel
  // }) : _viewModel = viewModel {
  //   buildAgenda = Command.createAsyncNoParam<Result?>(_buildAgenda, initialValue: null)..execute();
  // }

  GenerateAgendaProvider({required BuildAgendaViewmodel viewModel})
      : _viewModel = viewModel;

  final BuildAgendaViewmodel _viewModel;

  Command<void, Result?>? buildAgenda;

  void callBuildAgenda() {
    buildAgenda =
        Command.createAsyncNoParam<Result?>(_buildAgenda, initialValue: null)
          ..execute();
  }

  Future<Result?> _buildAgenda() async {
    try {
      final agendaResult = await _viewModel.generateAgenda();
      switch (agendaResult) {
        case Ok<void>():
          print('Generated agenda');
          return agendaResult;
        case Error():
          print("Bad things agenda did not generate.");
          return agendaResult;
      }
    } finally {
      notifyListeners();
    }
  }
}
