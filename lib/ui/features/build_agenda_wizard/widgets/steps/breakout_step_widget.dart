import 'package:agenda_wizard/styles/theme_util.dart';

import '../../../../../../styles/app_styles.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/progress_buttons.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/breakout_step_provider.dart';
import 'package:agenda_wizard/utils/step_enums.dart';
import 'package:flutter/material.dart';

class BreakoutStepWidget extends StatelessWidget {
  const BreakoutStepWidget({super.key, required this.provider});
  final BreakoutStepProvider provider;

  @override
  Widget build(BuildContext context) {
    String promptText = 'Will you be splitting into breakout groups?';

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(children: [
        const SizedBox(
          height: 40,
        ),
        Text(
          promptText,
          style: context.theme.textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        StreamBuilder<HasBreakoutGroups?>(
            stream: provider.getBreakoutRadioStream(),
            initialData: provider.getBreakoutRadioValue(),
            builder: (context, snapshot) {
              return Column(
                children: [
                  ListTile(
                      title: const Text("Yes"),
                      leading: Radio<HasBreakoutGroups?>(
                        value: HasBreakoutGroups.breakoutGroups,
                        groupValue: snapshot.data,
                        onChanged: (newValue) =>
                            provider.toggleBreakoutStatus(newValue),
                      )),
                  ListTile(
                      title: const Text("No"),
                      leading: Radio<HasBreakoutGroups?>(
                        value: HasBreakoutGroups.noBreakoutGroups,
                        groupValue: snapshot.data,
                        onChanged: (newValue) =>
                            provider.toggleBreakoutStatus(newValue),
                      )),
                ],
              );
            }),
        ProgressButtons(provider: provider),
      ]),
    );
  }
}
