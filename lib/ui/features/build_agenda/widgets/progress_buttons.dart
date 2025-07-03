import 'package:agenda_wizard/ui/features/build_agenda/widgets/finish_button.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/next_button.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/previous_button.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/step_providers/step_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wizard/flutter_wizard.dart';

class ProgressButtons extends StatelessWidget {
  const ProgressButtons(
      {super.key,
      required this.provider,
      this.prevEnabled});
  final StepProvider provider;
  final bool? prevEnabled;

  @override
  Widget build(BuildContext context) {
    return _buildButtons(context, provider, prevEnabled ?? true);
  }
}

Widget _buildButtons(BuildContext context, StepProvider provider, bool prevEnabled) {
  return StreamBuilder<int>(
    stream: context.wizardController.indexStream,
    initialData: context.wizardController.index,
    builder: (context, snapshot) {
      bool isFinished = false;
      if (!snapshot.hasData || snapshot.hasError) {
        return const SizedBox.shrink();
      }
      final index = snapshot.data!;
      if (context.wizardController.isFirstStep(index)) {
        prevEnabled = false;
      }
      if (provider.calculateNextStep() == 1000) {
        isFinished = true;
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 10,),
          prevEnabled ? PreviousButton(returnFunc: provider.goPreviousStep,) : const SizedBox.shrink(),
          const SizedBox(width: 10),
          isFinished ? const FinishButton() : NextButton(provider: provider),
        ],
      );
    },
  );
}
