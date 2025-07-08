import 'package:agenda_wizard/ui/core/themes/app_styles.dart';
import 'package:agenda_wizard/ui/core/themes/theme_util.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/view_model/build_agenda_viewmodel.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/view_model/generate_agenda_viewmodel.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/generate_agenda_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/form_step_provider.dart';
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
        StreamBuilder<agendaStatuses>(
            stream: widget.provider.getAgendaStatusStream(),
            initialData: widget.provider.getAgendaStatusValue(),
            builder: (context, snapshot) {
              return Column(children: [_buildStatusContent(snapshot.data!)]);
            }),
      ]),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     color: context
  //         .theme.colorScheme.surfaceContainer, // Example background color
  //     child: Row(
  //       children: [
  //         ListenableBuilder(
  //             listenable: widget.provider,
  //             builder: (BuildContext context, _) {
  //               if (widget.provider.buildAgenda != null) {
  //                 if (widget.provider.buildAgenda!.isExecuting.value) {
  //                   return const Text('Generating Agenda . . .');
  //                 } else if (widget.provider.buildAgenda!.results.value.hasData) {
  //                   return Container(
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(4.0),
  //                       color: context.theme.colorScheme.surfaceContainerLow,
  //                     ),
  //                     child: Padding(
  //                       padding: const EdgeInsets.all(20.0),
  //                       child: Column(
  //                         children: [
  //                           const SizedBox(
  //                             height: 10,
  //                           ),
  //                           Text(
  //                             'Agenda Complete!',
  //                             style: AppTextStyle.headline2,
  //                             textAlign: TextAlign.center,
  //                           ),
  //                           const SizedBox(height: 20),
  //                           const SizedBox(height: 20),
  //                         ],
  //                       ),
  //                     ),
  //                   );
  //                 } else if (widget.provider.buildAgenda!.results.value.hasError) {
  //                   return Text(
  //                       'An error has ocurred: ${widget.provider.buildAgenda!.results.value.error}');
  //                 }
  //                 return const Text('A very unforseen error has ocurred.');
  //               } else {
  //                 return const Text('Idk weird state');
  //               }
  //             }),
  //       ],
  //     ),
  //   );
  // }
}

Widget _buildStatusContent(agendaStatuses agendaStatus) {
  if (agendaStatus == agendaStatuses.inProgress) {
    return Text("Loading!");
  } else if (agendaStatus == agendaStatuses.isComplete) {
    return Text("All done yay!");
  } else if (agendaStatus == agendaStatuses.hasError) {
    return Text("Bad error boo!");
  } else if (agendaStatus == agendaStatuses.notStarted) {
    return Text("Not started!");
  } else {
    return Text("Agenda weirdly has no status . . .");
  }
}
