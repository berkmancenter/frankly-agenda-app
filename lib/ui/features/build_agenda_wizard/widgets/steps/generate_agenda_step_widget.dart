import 'package:agenda_wizard/routing/router.dart';
import 'package:agenda_wizard/routing/routes.dart';
import 'package:agenda_wizard/styles/theme_util.dart';
import '../../../../../../styles/app_styles.dart';
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
    return StreamBuilder<AgendaStatuses>(
        stream: widget.provider.getAgendaStatusStream(),
        initialData: widget.provider.getAgendaStatusValue(),
        builder: (context, snapshot) {
          return Padding(
              padding: const EdgeInsets.all(10.0),
              child: _buildStatusContent(snapshot.data!, context));
        });
  }

  void goHome() {
    widget.provider.closeShop();
    router.go(Routes.buildAgenda);
  }

  Widget _buildStatusContent(
      AgendaStatuses agendaStatus, BuildContext context) {
    if (agendaStatus == AgendaStatuses.inProgress) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Building agenda . . .",
            style: context.theme.textTheme.headlineMedium,
          ),
          const SizedBox(
            height: 100,
          )
        ],
      );
    } else if (agendaStatus == AgendaStatuses.isComplete) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle_outline,
            size: 50,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Agenda complete.",
            style: context.theme.textTheme.headlineMedium,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Your agenda has been created!",
            style: context.theme.textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 20,
          ),
          // ElevatedButton(
          //     onPressed: () => goHome(), child: const Text("Go home")),
          const SizedBox(
            height: 100,
          ),
        ],
      );
    } else if (agendaStatus == AgendaStatuses.hasError) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 50,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Uh oh. An error ocurred.",
            style: context.theme.textTheme.headlineMedium,
          ),
          const SizedBox(
            height: 20,
          ),
          if (widget.provider.errorMessage != null)
            Column(
              children: [
                Text(
                  widget.provider.errorMessage!,
                  style: context.theme.textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ElevatedButton(
              onPressed: () => goHome(), child: const Text("Build Agenda")),
          const SizedBox(
            height: 100,
          ),
        ],
      );
    } else if (agendaStatus == AgendaStatuses.notStarted) {
      return const Text("Not started!");
    } else {
      return const Text("Agenda weirdly has no status . . .");
    }
  }
}
