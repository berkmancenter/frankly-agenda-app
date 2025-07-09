import 'package:agenda_wizard/ui/core/themes/app_styles.dart';
import 'package:agenda_wizard/ui/core/widgets/form_input.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/progress_buttons.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/audience_step_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/topic_step_provider.dart';
import 'package:flutter/material.dart';

class AudienceStepWidget extends StatelessWidget {
  const AudienceStepWidget({super.key, required this.provider});

  final AudienceStepProvider provider;

  void onAudienceChange(newValue) {
    provider.updateAudience(
      provider.audienceController.text,
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
          'How might you describe your event\'s attendees?',
          style: AppTextStyle.headline3,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        FormInput(
            labelText: "Topic",
            fieldController: provider.audienceController,
            changeCallback: onAudienceChange,
            focusNode: provider.audienceFocusNode,
            isRequired: true),
        ProgressButtons(provider: provider),
      ]),
    );
  }
}
