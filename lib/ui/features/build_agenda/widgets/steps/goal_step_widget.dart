import 'package:agenda_wizard/ui/core/themes/app_styles.dart';
import 'package:agenda_wizard/ui/core/widgets/checkbox.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/progress_buttons.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/step_providers/goal_step_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/step_providers/step_provider.dart';
import 'package:dart_casing/dart_casing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wizard/flutter_wizard.dart';

class GoalStepWidget extends StatelessWidget {
  GoalStepWidget({super.key, required this.provider});
  final GoalStepProvider provider;

  final Map<String, String> _checkedBoxLabels = {
    'dialogue': "To understand one another's values and build trust",
    'exploration': "To generate ideas, questions, and unknowns about a topic",
    'evaluation': "Coalescing around or making some type of decision(s)",
    'deliberation':
        "All of the above- find common ground and shared perspectives to make decisions",
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: [
          const SizedBox(
            height: 40,
          ),
          Text(
            'What is the goal of your event?',
            style: AppTextStyle.headline3,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: provider.checkboxStates.keys.map((key) {
              return StreamBuilder<bool>(
                  stream: provider.getGoalCheckboxStream(key),
                  initialData: provider.getGoalCheckboxValue(key),
                  builder: (context, snapshot) {
                    return AgendaCheckBox(
                      label:
                          '${Casing.titleCase(key)}: ${_checkedBoxLabels[key] ?? ""}',
                      boxValue: snapshot.data,
                      onChangedFunction: (newValue) =>
                          provider.toggleCheckbox(key, newValue ?? false),
                    );
                  });
            }).toList(),
          ),
          ProgressButtons(provider: provider, prevEnabled: false,),
        ],
      ),
    );
  }
}
