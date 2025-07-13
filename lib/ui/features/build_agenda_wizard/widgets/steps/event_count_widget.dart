import 'package:agenda_wizard/ui/core/themes/app_styles.dart';
import 'package:agenda_wizard/ui/core/widgets/form_input.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/progress_buttons.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/event_count_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:string_validator/string_validator.dart';

class EventCountWidget extends StatelessWidget {
  const EventCountWidget({super.key, required this.provider});

  final EventCountProvider provider;
  void onCountChange(newValue) {
    String val = provider.countController.text;
    if (isNumeric(val) == true) {
      provider.updateCountValue(
        int.parse(provider.countController.text),
      );
    }
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
          labelText: "Event Count",
          fieldController: provider.countController,
          changeCallback: onCountChange,
          isRequired: true,
          focusNode: provider.eventFocusNode,
          inputType: TextInputType.number,
          width: 150,
          typeFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        ProgressButtons(provider: provider),
      ]),
    );
  }
}
