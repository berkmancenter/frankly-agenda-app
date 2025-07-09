import 'package:agenda_wizard/ui/features/build_agenda_wizard/view_model/build_agenda_viewmodel.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/agenda_wizard.dart';
import 'package:flutter/material.dart';

class BuildAgendaScreen extends StatefulWidget {
  final BuildAgendaViewmodel viewModel;
  const BuildAgendaScreen({super.key, required this.viewModel});

  @override
  State<BuildAgendaScreen> createState() => _BuildAgendaScreenState();
}

class _BuildAgendaScreenState extends State<BuildAgendaScreen> {

  void refreshWizardCallback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AgendaWizard.provider(pViewModel: widget.viewModel);
  }
}


