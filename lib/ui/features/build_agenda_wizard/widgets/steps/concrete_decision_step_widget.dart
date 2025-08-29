import 'package:agenda_wizard/styles/theme_util.dart';

import '../../../../../../styles/app_styles.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/progress_buttons.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/concrete_decision_provider.dart';
import 'package:agenda_wizard/utils/step_enums.dart';
import 'package:flutter/material.dart';

class ConcreteDecisionStepWidget extends StatelessWidget {
  const ConcreteDecisionStepWidget({super.key, required this.provider});
  final ConcreteDecisionProvider provider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(children: [
        const SizedBox(
          height: 40,
        ),
        Text(
          'Do you hope to reach a specific decision?',
          style: context.theme.textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'In other words, are you more interested in concrete decision-making or in exploring and evaluating opportunities for action?',
          style: context.theme.textTheme.bodyMedium!
              .merge(const TextStyle(fontStyle: FontStyle.italic)),
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: 20,
        ),
        StreamBuilder<IsConcrete?>(
            stream: provider.getConcreteRadioStream(),
            initialData: provider.getConcreteRadioValue(),
            builder: (context, snapshot) {
              return Column(
                children: [
                  ListTile(
                      title: const Text("Concrete decision"),
                      leading: Radio<IsConcrete?>(
                        value: IsConcrete.concrete,
                        groupValue: snapshot.data,
                        onChanged: (newValue) =>
                            provider.toggleConcreteStatus(newValue),
                      )),
                  ListTile(
                      title: const Text("Evaluating opporunities for action"),
                      leading: Radio<IsConcrete?>(
                        value: IsConcrete.nonConcrete,
                        groupValue: snapshot.data,
                        onChanged: (newValue) =>
                            provider.toggleConcreteStatus(newValue),
                      )),
                ],
              );
            }),
        ProgressButtons(provider: provider),
      ]),
    );
  }
}
