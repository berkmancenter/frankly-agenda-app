import 'package:agenda_wizard/styles/theme_util.dart';

import '../../../../../../styles/app_styles.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/progress_buttons.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/facilitate_step_provider.dart';
import 'package:agenda_wizard/utils/step_enums.dart';
import 'package:flutter/material.dart';

class FacilitatedStepWidget extends StatelessWidget {
  const FacilitatedStepWidget(
      {super.key, required this.provider, required this.hasBreakouts});
  final FacilitateStepProvider provider;
  final bool hasBreakouts;

  @override
  Widget build(BuildContext context) {
    String promptText = 'Will the event have a facilitator?';

    if (hasBreakouts == true) {
      promptText = 'Will each breakout group have a facilitator?';
    }

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
        StreamBuilder<IsFacilitated?>(
            stream: provider.getFacilitatedRadioStream(),
            initialData: provider.getFacilitatedRadioValue(),
            builder: (context, snapshot) {
              return Column(
                children: [
                  ListTile(
                      title: const Text("Yes"),
                      leading: Radio<IsFacilitated?>(
                        value: IsFacilitated.facilitated,
                        groupValue: snapshot.data,
                        onChanged: (newValue) =>
                            provider.toggleFacilitateStatus(
                                newValue),
                      )),
                  ListTile(
                      title: const Text("No"),
                      leading: Radio<IsFacilitated?>(
                        value: IsFacilitated.notFacilitated,
                        groupValue: snapshot.data,
                        onChanged: (newValue) =>
                            provider.toggleFacilitateStatus(
                                newValue),
                      )),
                ],
              );
            }),
        ProgressButtons(provider: provider),
      ]),
    );
  }
}
