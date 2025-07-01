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
            _buildButtons(context, provider)
      ]),
    );
  }
}


Widget _buildButtons(BuildContext context, StepProvider provider) {
  return StreamBuilder<int>(
    stream: context.wizardController.indexStream,
    initialData: context.wizardController.index,
    builder: (context, snapshot) {
      bool isFinished = false;
      bool prevEnabled = true;
      if (!snapshot.hasData || snapshot.hasError) {
        return const SizedBox.shrink();
      }
      final index = snapshot.data!;
      if (context.wizardController.isFirstStep(index)) {
        prevEnabled = false;
      }
      if (context.wizardController.isLastStep(index)) {
        isFinished = true;
      }
      return ProgressButtons(
          provider: provider, isFinished: isFinished, prevEnabled: prevEnabled);
    },
  );
}
