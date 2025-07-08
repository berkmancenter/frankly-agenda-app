import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/generate_agenda_provider.dart';
import 'package:flutter/material.dart';

class GenerateAgendaStepWizard extends StatefulWidget {
  const GenerateAgendaStepWizard({super.key, required this.provider});

  final GenerateAgendaProvider provider;

  @override
  State<GenerateAgendaStepWizard> createState() =>
      _GenerateAgendaStepWizardState();
}

class _GenerateAgendaStepWizardState extends State<GenerateAgendaStepWizard> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(children: [
        const SizedBox(
          height: 40,
        ),
        StreamBuilder<AgendaStatuses>(
            stream: widget.provider.getAgendaStatusStream(),
            initialData: widget.provider.getAgendaStatusValue(),
            builder: (context, snapshot) {
              return Column(children: [_buildStatusContent(snapshot.data!)]);
            }),
      ]),
    );
  }
}

Widget _buildStatusContent(AgendaStatuses agendaStatus) {
  if (agendaStatus == AgendaStatuses.inProgress) {
    return Text("Loading!");
  } else if (agendaStatus == AgendaStatuses.isComplete) {
    return Text("All done yay!");
  } else if (agendaStatus == AgendaStatuses.hasError) {
    return Text("Bad error boo!");
  } else if (agendaStatus == AgendaStatuses.notStarted) {
    return Text("Not started!");
  } else {
    return Text("Agenda weirdly has no status . . .");
  }
}
