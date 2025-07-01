import 'package:agenda_wizard/ui/features/build_agenda/view_model/build_agenda_viewmodel.dart';
import 'package:agenda_wizard/ui/features/build_agenda/agenda_wizard.dart';
import 'package:flutter/material.dart';

class BuildAgendaScreen extends StatelessWidget {
  final BuildAgendaViewmodel viewModel;
  const BuildAgendaScreen({super.key, required this.viewModel});


  @override
  Widget build(BuildContext context) {
    return AgendaWizard.provider();
  }
}


