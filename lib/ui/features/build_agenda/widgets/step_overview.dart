import 'package:agenda_wizard/ui/features/build_agenda/widgets/step_providers/goal_step_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/step_providers/topic_step_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wizard/flutter_wizard.dart';

class StepOverview extends StatelessWidget {
  const StepOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: context.wizardController.stepControllers.length,
      itemBuilder: (context, index) {
        final step = context.wizardController.stepControllers[index].step;
        return StreamBuilder<bool>(
            stream: context.wizardController.getIsGoToEnabledStream(index),
            initialData: context.wizardController.getIsGoToEnabled(index),
            builder: (context, snapshot) {
              final enabled = snapshot.data!;
              // TODO make this neater
              String title;
              switch (step.runtimeType) {
                // ignore: type_literal_in_constant_pattern
                case GoalStepProvider:
                  title = "1";
                  break;
                // ignore: type_literal_in_constant_pattern
                case TopicStepProvider:
                  title = "2";
                  break;
                default:
                  title = "Unknown step description";
                  break;
              }
              return StreamBuilder<int>(
                stream: context.wizardController.indexStream,
                initialData: context.wizardController.index,
                builder: (context, snapshot) {
                  final selectedIndex = snapshot.data;
                  return ListTile(
                    title: Text(title),
                    onTap: enabled
                        ? () => context.wizardController.goTo(index: index)
                        : null,
                    enabled: enabled,
                    selected: index == selectedIndex,
                  );
                },
              );
            });
      },
    );
  }
}
