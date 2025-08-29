import 'package:agenda_wizard/styles/theme_util.dart';

import '../../../../../../styles/app_styles.dart';
import 'package:agenda_wizard/ui/core/widgets/form_input.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/progress_buttons.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/topic_step_provider.dart';
import 'package:flutter/material.dart';

class TopicStepWidget extends StatelessWidget {
  const TopicStepWidget({super.key, required this.provider});

  final TopicStepProvider provider;

  void onTopicChange(newValue) {
    provider.updateTopic(
      provider.topicController.text,
    );
  }

  void onDescriptionChange(newValue) {
    provider.updateDescription(
      provider.topicDescriptionController.text,
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
          'What is the topic of your event?',
          style: context.theme.textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          FormInput(
              labelText: "Topic",
              fieldController: provider.topicController,
              changeCallback: onTopicChange,
              focusNode: provider.topicFocusNode,
              isRequired: true),
          FormInput(
            labelText: "Briefly describe your topic.",
            fieldController: provider.topicDescriptionController,
            isRequired: false,
            changeCallback: onDescriptionChange,
            inputType: TextInputType.multiline,
            maxLines: null,
            minLines: 4,
          )
        ]),
        ProgressButtons(provider: provider),
      ]),
    );
  }
}
