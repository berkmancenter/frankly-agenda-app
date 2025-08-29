import 'package:agenda_wizard/styles/theme_util.dart';

import '../../../../../../styles/app_styles.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/progress_buttons.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/init_step_provider.dart';
import 'package:flutter/material.dart';

class InitialStepWidget extends StatelessWidget {
  const InitialStepWidget({super.key, required this.provider});

  final InitStepProvider provider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(scrollDirection: Axis.vertical, children: [
        const SizedBox(
          height: 40,
        ),
        Text(
          'Let\'s build an agenda!',
          style: context.theme.textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          '1. First, we\'ll ask you a few questions about your event.',
          style: context.theme.textTheme.bodyMedium,
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          '2. Next, we\'ll generate recommended agendas for your event based on your responses.',
          style: context.theme.textTheme.bodyMedium,
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          '3. Afterwards, you\'ll have the option to edit and customize your agendas, or to go back and revise your responses and re-generate your agendas.',
          style: context.theme.textTheme.bodyMedium,
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: 40,
        ),
        ProgressButtons(
          provider: provider,
          prevEnabled: false,
        ),
      ]),
    );
  }
}
