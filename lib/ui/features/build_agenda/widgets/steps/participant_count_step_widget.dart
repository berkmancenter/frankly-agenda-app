import 'package:agenda_wizard/ui/core/themes/app_styles.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/progress_buttons.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/step_providers/participant_count_step_provider.dart';
import 'package:flutter/material.dart';

class ParticipantCountWidget extends StatelessWidget {
  const ParticipantCountWidget({super.key, required this.provider});
  final ParticipantCountStepProvider provider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(children: [
        const SizedBox(
          height: 40,
        ),
        Text(
          'Will this event be part of a series, or is it a standalone?',
          style: AppTextStyle.headline3,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          children: provider.participantCountMap.keys.map((key) {
            return StreamBuilder<int?>(
                stream: provider.getParticipantRadioStream(),
                initialData: provider.currParticipantCount.value,
                builder: (context, snapshot) {
                  return ListTile(
                      title: Text("${provider.getParticipantString(key)}"),
                      leading: Radio<int?>(
                        value: key,
                        groupValue: snapshot.data,
                        onChanged: (newValue) =>
                            provider.updateParticipantCount(newValue),
                      ));
                });
          }).toList(),
        ),
        ProgressButtons(provider: provider),
      ]),
    );
  }
}
