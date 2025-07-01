import 'package:agenda_wizard/ui/core/themes/app_styles.dart';
import 'package:agenda_wizard/ui/core/widgets/form_input.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/progress_buttons.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/step_providers/step_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/step_providers/topic_step_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wizard/flutter_wizard.dart';

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
          style: AppTextStyle.headline3,
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
          )
        ]),
        ProgressButtons(provider: provider),
      ]),
    );
  }
}


