import 'package:agenda_wizard/ui/core/themes/app_styles.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/progress_buttons.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/breakout_participant_provider.dart';
import 'package:agenda_wizard/utils/step_enums.dart';
import 'package:flutter/material.dart';

class BreakoutCountWidget extends StatelessWidget {
  const BreakoutCountWidget({super.key, required this.provider});
  final BreakoutParticipantProvider provider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(children: [
        const SizedBox(
          height: 40,
        ),
        Text(
          'How many participants will be in each breakout room?',
          style: AppTextStyle.headline3,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          children: provider.breakoutCountMap.keys.map((key) {
            return StreamBuilder<ParticipantBatches?>(
                stream: provider.getBreakoutRadioStream(),
                initialData: provider.currBreakoutCount.value,
                builder: (context, snapshot) {
                  return ListTile(
                      title: Text("${provider.getBreakoutString(key)}"),
                      leading: Radio<int?>(
                        value: key.index,
                        groupValue: snapshot.data?.index,
                        onChanged: (newValue) =>
                            provider.updateBreakoutCount(newValue),
                      ));
                });
          }).toList(),
        ),
        ProgressButtons(provider: provider),
      ]),
    );
  }
}
