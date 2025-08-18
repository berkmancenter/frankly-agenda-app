import '../../../../../../styles/app_styles.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/progress_buttons.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/event_length_provider.dart';
import 'package:flutter/material.dart';
import 'package:duration_picker/duration_picker.dart';

class EventLengthWidget extends StatelessWidget {
  const EventLengthWidget({super.key, required this.provider, required this.isSeries});
  final EventLengthProvider provider;
  final bool isSeries;

  @override
  Widget build(BuildContext context) {
    String promptText = "How long will the event be?";
    if (isSeries) {
      promptText = "How long will each event be?";
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(children: [
        const SizedBox(
          height: 40,
        ),
        Text(
          promptText,
          style: AppTextStyle.headline3,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        StreamBuilder<Duration>(
            stream: provider.getDurationRadioStream(),
            initialData: provider.getDurationRadioValue(),
            builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: DurationPicker(
                  duration: snapshot.data!,
                  baseUnit: BaseUnit.minute,
                  onChange: (val) {
                    provider.updateDurationValue(val);
                  },
                  lowerBound: const Duration(
                    minutes: 5,
                  ),
                ),
              );
            }),
        const SizedBox(
          height: 20,
        ),
        ProgressButtons(provider: provider),
      ]),
    );
  }
}
