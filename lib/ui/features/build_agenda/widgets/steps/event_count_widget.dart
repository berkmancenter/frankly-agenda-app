import 'package:agenda_wizard/ui/core/themes/app_styles.dart';
import 'package:agenda_wizard/ui/core/widgets/form_input.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/progress_buttons.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/step_providers/event_count_provider.dart';
import 'package:flutter/material.dart';

class EventCountWidget extends StatelessWidget {
  const EventCountWidget({super.key, required this.provider});

  final EventCountProvider provider;
  void onCountChange(newValue) {
    provider.updateCountValue(
      // TODO: check if int
      int.parse(provider.countController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(children: [
        const SizedBox(
          height: 40,
        ),
        Text(
          'How many events will you have?',
          style: AppTextStyle.headline3,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        FormInput(
            labelText: "Number of events",
            fieldController: provider.countController,
            changeCallback: onCountChange,
            isRequired: true,
            inputType: TextInputType.number),
        ProgressButtons(provider: provider),
      ]),
    );
  }
}
