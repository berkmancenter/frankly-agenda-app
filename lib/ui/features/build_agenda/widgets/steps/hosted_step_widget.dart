import 'package:agenda_wizard/ui/core/themes/app_styles.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/progress_buttons.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/step_providers/hosted_step_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/step_providers/step_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wizard/flutter_wizard.dart';

class HostedStepWidget extends StatelessWidget {
  const HostedStepWidget({super.key, required this.provider});
  final HostedStepProvider provider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(children: [
        const SizedBox(
          height: 40,
        ),
        Text(
          'Is the event hosted?',
          style: AppTextStyle.headline3,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        StreamBuilder<IsHosted>(
            stream: provider.getHostedRadioStream(),
            initialData: provider.getHostedRadioValue(),
            builder: (context, snapshot) {
              return Column(
                children: [
                  ListTile(
                      title: const Text("Yes"),
                      leading: Radio<IsHosted?>(
                        value: IsHosted.hosted,
                        groupValue: snapshot.data,
                        onChanged: (newValue) => provider
                            .toggleHostStatus(newValue ?? IsHosted.hosted),
                      )),
                  ListTile(
                      title: const Text("No"),
                      leading: Radio<IsHosted?>(
                        value: IsHosted.notHosted,
                        groupValue: snapshot.data,
                        onChanged: (newValue) => provider
                            .toggleHostStatus(newValue ?? IsHosted.notHosted),
                      )),
                ],
              );
            }),
            ProgressButtons(provider: provider),
      ]),
    );
  }
}
