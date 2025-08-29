import 'package:agenda_wizard/styles/theme_util.dart';

import '../../../../../../styles/app_styles.dart';
import 'package:agenda_wizard/ui/core/widgets/form_input.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/progress_buttons.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/audience_step_provider.dart';
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
          style: context.theme.textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        FormInput(
          labelText: "",
          fieldController: provider.audienceController,
          isRequired: false,
          focusNode: provider.audienceFocusNode,
          changeCallback: onAudienceChange,
          inputType: TextInputType.multiline,
          maxLines: null,
          minLines: 4,
        ),
        ProgressButtons(provider: provider),
      ]),
    );
  }
}
