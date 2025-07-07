import 'package:agenda_wizard/ui/core/themes/app_styles.dart';
import 'package:agenda_wizard/ui/core/themes/theme_util.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/view_model/build_agenda_viewmodel.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/view_model/generate_agenda_viewmodel.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/generate_agenda_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/step_provider.dart';
import 'package:flutter/material.dart';

class GenerateAgendaStepWizard extends StatefulWidget {
  const GenerateAgendaStepWizard({super.key, required this.provider});

  final GenerateAgendaProvider provider;

  @override
  State<GenerateAgendaStepWizard> createState() => _GenerateAgendaStepWizardState();
}

class _GenerateAgendaStepWizardState extends State<GenerateAgendaStepWizard> {
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.provider.callBuildAgenda());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context
          .theme.colorScheme.surfaceContainer, // Example background color
      child: Row(
        children: [
          ListenableBuilder(
              listenable: widget.provider,
              builder: (BuildContext context, _) {
                if (widget.provider.buildAgenda != null) {
                  if (widget.provider.buildAgenda!.isExecuting.value) {
                    return const Text('Generating Agenda . . .');
                  } else if (widget.provider.buildAgenda!.results.value.hasData) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: context.theme.colorScheme.surfaceContainerLow,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Agenda Complete!',
                              style: AppTextStyle.headline2,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    );
                  } else if (widget.provider.buildAgenda!.results.value.hasError) {
                    return Text(
                        'An error has ocurred: ${widget.provider.buildAgenda!.results.value.error}');
                  }
                  return const Text('A very unforseen error has ocurred.');
                } else {
                  return const Text('Idk weird state');
                }
              }),
        ],
      ),
    );
  }
}
