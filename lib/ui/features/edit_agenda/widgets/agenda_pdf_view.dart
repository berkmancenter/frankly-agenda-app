import 'package:agenda_wizard/ui/features/edit_agenda/widgets/agenda_pdf.dart';
import '../../../../../styles/styles.dart';
import 'package:agenda_wizard/ui/features/edit_agenda/view_model/agenda_editor_viewmodel.dart';
import 'package:flutter/material.dart';


enum AgendaSaveStates { agendaSaved, saveError, adjusting }

class AgendaPdfView extends StatefulWidget {
  const AgendaPdfView({super.key, required this.viewModel});
  final AgendaEditorViewmodel viewModel;

  @override
  State<AgendaPdfView> createState() => _AgendaPdfViewState();
}

class _AgendaPdfViewState extends State<AgendaPdfView> {
  String screenTitle = "Here is your agenda.";
  String screenSubtext =
      "Double check that it looks okay, and then go ahead and download it!";

  @override
  Widget build(BuildContext context) {
    if (widget.viewModel.eventPlan.agendas.length > 1) {
      screenTitle = "Here are your agendas.";
      screenSubtext =
          "Double check that they look okay, and then go ahead and download them!";
    }

    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          screenTitle,
          style: context.theme.textTheme.headlineMedium,
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          screenSubtext,
          style: context.theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        AgendaPDF(viewModel: widget.viewModel),
      ],
    );
  }
}
